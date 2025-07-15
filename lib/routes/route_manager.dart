import 'package:get/get.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_about_us_screen/retailer_about_us_screen.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_change_password_screen/retailer_change_password_screen.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_contact_us_screen/retailer_contact_us_screen.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_create_new_order_screen/retailer_create_new_order_screen.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_faq_screen/retailer_faq_screen.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_home_screen/order_history.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_notification_screen/retailer_notification_screen.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_order_history_screen/retailer_confirmed_order_details_history_screen/retailer_confirmed_order_details_history_screen.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_order_history_screen/retailer_order_history_screen.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_profile_screen/retailer_profile_screen.dart';
import 'package:inventory_app/screens/retailer_screens/retailer_terms_conditions_screen/retailer_terms_conditions_screen.dart';
import 'package:inventory_app/screens/wholesaler_screens/wholesaler_home_screen/wholesaler_home_screen.dart';
import 'package:inventory_app/screens/wholesaler_screens/wholesaler_home_screen/wholesaler_order_details.dart';
import 'package:inventory_app/screens/wholesaler_screens/wholesaler_order_history/wholesaler_order_history.dart';
import 'package:inventory_app/screens/wholesaler_screens/wholesaler_settings/subscription/add_card.dart';
import 'package:inventory_app/screens/wholesaler_screens/wholesaler_settings/subscription/payment_webview_page.dart';
import 'package:inventory_app/screens/wholesaler_screens/wholesaler_settings/subscription/subscription_screen.dart';
import 'package:inventory_app/screens/wholesaler_screens/wholesaler_settings/wholesaler_settings.dart';
import 'package:inventory_app/screens/widgets/wholesaler_tabbar_view.dart';

import '../screens/auth_screens/forgot_password_screen/forgot_password_screen.dart';
import '../screens/auth_screens/forgot_password_verification_code_screen/forgot_password_verification_code_screen.dart';
import '../screens/auth_screens/reset_password_screen/reset_password_screen.dart';
import '../screens/auth_screens/signin_screen/signin_screen.dart';
import '../screens/auth_screens/signup_screen/signup_screen.dart';
import '../screens/auth_screens/signup_verification_code_screen/signup_verification_code_screen.dart';
import '../screens/auth_screens/store_information_screen/store_information_screen.dart';
import '../screens/bottom_nav_bar/bottom_nav_bar.dart';
import '../screens/onboarding_screen/onboarding_screen.dart';
import '../screens/retailer_screens/retailer_find_wholeseller_screen/retailer_find_wholeseller_screen.dart';
import '../screens/retailer_screens/retailer_home_screen/retailer_home_screen.dart';
import '../screens/retailer_screens/retailer_order_history_screen/retailer_pending_order_details_history_screen/retailer_pending_order_details_history_screen.dart';
import '../screens/retailer_screens/retailer_order_history_screen/retailer_received_price_details_history_screen/retailer_received_price_details_history_screen.dart';
import '../screens/retailer_screens/retailer_saved_order_screen/retailer_saved_order_screen.dart';
import '../screens/splash_screen/splash_screen.dart';
import '../screens/wholesaler_screens/wholesaler_change_password_screen/wholesaler_change_password_screen.dart';
import '../screens/wholesaler_screens/wholesaler_find_wholeseller_screen/wholesaler_find_wholeseller_screen.dart';
import '../screens/wholesaler_screens/wholesaler_new_orders_screen/wholesaler_confirmed_order_details_screen/wholesaler_confirmed_order_details_screen.dart';
import '../screens/wholesaler_screens/wholesaler_new_orders_screen/wholesaler_new_order_details_screen/wholesaler_new_order_details_screen.dart';
import '../screens/wholesaler_screens/wholesaler_new_orders_screen/wholesaler_new_orders_screen.dart';
import '../screens/wholesaler_screens/wholesaler_new_orders_screen/wholesaler_pending_order_details_screen/wholesaler_pending_order_details_screen.dart';
import '../screens/wholesaler_screens/wholesaler_notification_screen/wholesaler_notification_screen.dart';
import '../screens/wholesaler_screens/wholesaler_profile_screen/wholesaler_profile_screen.dart';
import 'app_routes.dart';

class RouteManager {
  RouteManager._();

  static const initial = AppRoutes.splashScreen;

  static List<GetPage> getPages() {
    return [
      GetPage(
        name: AppRoutes.splashScreen,
        page: () => const SplashScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.onboardingScreen,
        page: () => const OnboardingScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.signinScreen,
        page: () => SigninScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.forgotPasswordScreen,
        page: () => ForgotPasswordScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.forgotPasswordVerificationCodeScreen,
        page: () => ForgotPasswordVerificationCodeScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.resetPasswordScreen,
        page: () => ResetPasswordScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.signupScreen,
        page: () => SignupScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.storeInformationScreen,
        page: () => StoreInformationScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.signupVerificationCodeScreen,
        page: () => SignupVerificationCodeScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.bottomNavBar,
        page: () => const BottomNavBar(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.retailerHomeScreen,
        page: () => const RetailerHomeScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.retailerCreateNewOrderScreen,
        page: () => RetailerCreateNewOrderScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.retailerFindWholeSellerScreen,
        page: () => RetailerFindWholeSellerScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.wholeSellerOrderScreen,
        page: () => const WholesalerOrder(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.retailerSavedOrderScreen,
        page: () => RetailerSavedOrderScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.orderHistoryScreen,
        page: () => const OrderHistoryScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.retailerProfile,
        page: () => RetailerProfileScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.changePassword,
        page: () => RetailerChangePasswordScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.retailerNotification,
        page: () => const RetailerNotificationScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.about,
        page: () => const RetailerAboutUsScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.retailerContact,
        page: () => const RetailerContactUsScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.retailerFaq,
        page: () => const RetailerFaqScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.retailerTerms,
        page: () => const RetailerTermsConditionsScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.retailerOrderHistoryScreen,
        page: () => RetailerOrderHistoryScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.retailerConfirmOrderDetailsHistoryScreen,
        page: () => const RetailerConfirmedOrderDetailsHistoryScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.wholesalerHomeScreen,
        page: () => const WholesalerHomeScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.wholesalerSettings,
        page: () => const WholesalerSettings(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.subscriptionScreen,
        page: () => const SubscriptionScreen(),
        // binding: GeneralBindings(),
      ),
      // GetPage(
      //   name: AppRoutes.wholesalerAddCard,
      //   page: () => const AddCardScreen(),
      //   // binding: GeneralBindings(),
      // ),
      GetPage(
        name: AppRoutes.retailerPendingOrderDetailsHistoryScreen,
        page: () => const RetailerPendingOrderDetailsHistoryScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.retailerAddNewItemScreen,
        page: () => RetailerCreateNewOrderScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.retailerReceivedPriceDetailsHistoryScreen,
        page: () => const RetailerReceivedPriceDetailsHistoryScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.wholesalerOrderHistoryScreen,
        page: () => WholesalerOrderHistoryScreen(),
        // binding: GeneralBindings(),
      ),
      // GetPage(
      //   name: AppRoutes.wholesalerTabview,
      //   page: () => const WholesalerTabView(),
      //   // binding: GeneralBindings(),
      // ),
      GetPage(
        name: AppRoutes.wholesalerConfirmedOrderDetailsScreen,
        page: () => const WholesalerConfirmedOrderDetailsScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.wholesalerPendingOrderDetailsScreen,
        page: () => const WholesalerPendingOrderDetailsScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.wholesalerNewOrderDetailsScreen,
        page: () => const WholesalerNewOrderDetailsScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.wholesalerProfileScreen,
        page: () => WholesalerProfileScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.wholesalerChangePasswordScreen,
        page: () => WholesalerChangePasswordScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.wholesalerNotificationScreen,
        page: () => const WholesalerNotificationScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.wholesalerFindWholeSellerScreen,
        page: () => WholesalerFindWholeSellerScreen(),
        // binding: GeneralBindings(),
      ),
      
    ];
  }
}
