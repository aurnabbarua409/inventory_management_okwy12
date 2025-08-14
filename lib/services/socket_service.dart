import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:inventory_app/helpers/prefs_helper.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_notification_screen/controller/retailer_notification_controller.dart';
import 'package:inventory_app/utils/app_logger.dart';
import 'package:inventory_app/utils/app_urls.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

//class SocketServices {
//   static io.Socket? socket; // Change to nullable type
//   bool show = false;

//   /// Connect with the socket
//   static void connectToSocket() {
//     // Ensure the socket is initialized before using it
//     if (socket == null) {
//       socket = io.io(
//         Urls.socketUrl,
//         io.OptionBuilder()
//             .setTransports(['websocket'])
//             .enableAutoConnect()
//             .build(),
//       );

//       socket!.onConnect((data) {
//         debugPrint("=============================> Connection $data");
//       });
//       socket!.onConnectError((data) {
//         if (kDebugMode) {
//           print("============================>Connection Error $data");
//         }
//       });

//       socket!.connect();

//       socket!.on("getNotification::${PrefsHelper.userId}", (data) {
//         if (kDebugMode) {
//           print("================> get Data on socket: $data");
//         }
//         NotificationService.showNotification(data);
//       });
//     }
//   }

//   /// Disconnect the socket when the controller is disposed
//   static void disconnectSocket() {
//     if (socket != null) {
//       socket!.disconnect();
//       debugPrint("Socket disconnected");
//     }
//   }
// }

// import 'package:flutter/foundation.dart';
// import 'package:socket_io_client/socket_io_client.dart' as io;
// import 'package:socket_io_client/socket_io_client.dart';

///<------------------------- Socket Class ---------------->

class SocketApi {
  factory SocketApi() {
    return _socketApi;
  }

  SocketApi._internal();

  static io.Socket socket = io.io(
    Urls.socketUrl,
    io.OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect()
        .setTimeout(5000)
        .setReconnectionDelay(1000)
        .enableReconnection()
        .build(),
  );

  static bool _isConnected = false; // Track connection status

  bool get isConnected => _isConnected;

  static void init() {
    debugPrint('=============> Socket initialization');
    if (!_isConnected) {
      socket.connect();

      socket.onConnect((_) {
        _isConnected = true;
        debugPrint(
          '==============>>>>>>> Socket Connected :$_isConnected ===============<<<<<<<',
        );
      });

      socket.on('unauthorized', (dynamic data) {
        debugPrint('Unauthorized');
      });
      final userId = PrefsHelper.userId;
      appLogger("in socket service, the user id: $userId");
      socket.on('get-notification::$userId', (dynamic data) {
        Get.find<NotificationsController>().unreadMessage.value += 1;
        appLogger(
            '============ Socket connected and getting values: $data ==============================');
      });

      socket.onError((dynamic error) {
        debugPrint('Socket error: $error');
        _isConnected = false;
      });

      socket.onDisconnect((dynamic data) {
        debugPrint('Socket instance disconnected');
        _isConnected = false;
        connectWithRetry(); // Attempt reconnection on disconnect
      });
    } else {
      debugPrint('Socket instance already connected');
    }
  }

  static Future<void> connectWithRetry({
    int retryCount = 0,
    int maxRetries = 5,
  }) async {
    if (!_isConnected && retryCount < maxRetries) {
      debugPrint('Attempting to connect (retry $retryCount)...');
      socket.connect();

      await Future.delayed(
        Duration(seconds: retryCount * 2 + 1),
      ); // Exponential backoff

      if (!_isConnected) {
        connectWithRetry(retryCount: retryCount + 1, maxRetries: maxRetries);
      } else {
        debugPrint('Socket successfully connected');
      }
    } else if (retryCount >= maxRetries) {
      debugPrint('Max retry attempts reached. Connection failed.');
    }
  }

  static void sendMessage(String event, dynamic data) {
    if (_isConnected) {
      socket.emit(event, data);
    } else {
      debugPrint('Socket not connected. Cannot send message.');
    }
  }

  static void listen(String event, Function(dynamic) callback) {
    socket.on(event, callback);
  }

  static final SocketApi _socketApi = SocketApi._internal();
}
