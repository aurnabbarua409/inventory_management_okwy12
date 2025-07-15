// RxInt unreadMessage=0.obs;

//   RxList<NotificationDatum> notificationModel = <NotificationDatum>[].obs;
//   Rx<NotificationModel> unReadModel= NotificationModel().obs;

//   ///========================= Listen to Socket =======================

//   listenToNewNotification()async{
//   String id=  await SharePrefsHelper.getString(SharedPreferenceValue.creatorId);

//     SocketApi.socket.on("NewNotification::$id",(data){
//      // debugPrint("Socket Res=================>>>>>>>>>>>>>$data");

//       try {

//         if (data != null) {

//           NotificationModel unreadNotification=NotificationModel.fromJson(data);
//           NotificationDatum newNotification = NotificationDatum.fromJson(data);

//           getNotification();

//           notificationModel.insert(0, newNotification);
//           notificationModel.refresh();

//           if (unreadNotification.data?.unRead != null && unreadNotification.data?.unRead !=0){

//             unreadMessage.value = unreadNotification.data!.unRead!.toInt();

//             unreadMessage.refresh();


//             update();
//             debugPrint("-===--=-=-=-=-=-=-=-=-=-=-= this is unread ${unreadNotification.data!.unRead!.toString()}");
//           }

//           update();
//         } else {
//           debugPrint("Received null data for patient-notifications");
//         }
//       } catch (e) {
//         debugPrint("Error processing patient-notifications: $e");
//       }
//     });
//   }

//   ///<====================== This is for get notification ====================>

//   Future<void> getNotification()async{

//     setRxRequestStatus(Status.loading);
//     var response = await ApiClient.getData(ApiConstant.getNotification);
//     if (response.statusCode == 200) {
//       unReadModel.value=NotificationModel.fromJson(response.body);
//       notificationModel.value = List<NotificationDatum>.from(
//           response.body["data"]["result"].map((x) => NotificationDatum.fromJson(x)));


//       if (notificationModel.isNotEmpty){

//         // currentPage.value = response.body["pagination"]['currentPage'];
//         // totalPage.value = response.body["pagination"]['totalPage'];

//       }
//       notificationModel.refresh();
//       debugPrint("===============----------------- ================== ---------------==== This is unread message");
//       setRxRequestStatus(Status.completed);
//     } else {

//       if (response.statusText == ApiClient.noInternetMessage){
//         setRxRequestStatus(Status.internetError);
//       } else {
//         setRxRequestStatus(Status.error);
//       }
//       ApiChecker.checkApi(response);

//     }
//   }