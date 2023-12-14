import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/screens/cancelled_tasks_screen.dart';
import 'package:task_manager/ui/screens/completed_tasks_screen.dart';
import 'package:task_manager/ui/screens/edit_profile_screen.dart';
import 'package:task_manager/ui/screens/forgot_password_screen.dart';
import 'package:task_manager/ui/screens/login_screen.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager/ui/screens/new_tasks_screen.dart';
import 'package:task_manager/ui/screens/pin_verification_screen.dart';
import 'package:task_manager/ui/screens/progress_tasks_screen.dart';
import 'package:task_manager/ui/screens/reset_password_screen.dart';
import 'package:task_manager/ui/screens/sign_up_screen.dart';
import 'package:task_manager/ui/screens/splash_screen.dart';

class AllRoutes{
  static const String splashScreen = '/splash';
  static const String signUpScreen = '/signUpScreen';
  static const String loginScreen = '/loginScreen';
  static const String forgotPasswordScreen = '/forgotPasswordScreen';
  static const String pinVerificationScreen = '/pinVerificationScreen';
  static const String resetPasswordScreen = '/resetPasswordScreen';
  static const String mainBottomNavScreen = '/mainBottomNavScreen';
  static const String newTasksScreen = '/newTasksScreen';
  static const String progressTasksScreen = '/progressTasksScreen';
  static const String completedTasksScreen = '/completedTasksScreen';
  static const String cancelledTasksScreen = '/cancelledTasksScreen';
  static const String addNewTaskScreen = '/addNewTaskScreen';
  static const String editProfileScreen = '/editProfileScreen';




  static String getSplashRoute() => splashScreen;
  static String getSignUpScreen() => signUpScreen;
  static String getLoginScreen() => loginScreen;
  static String getForgotPasswordScreen() => forgotPasswordScreen;
  static String getPinVerificationScreen() => pinVerificationScreen;
  static String getResetPasswordScreen() => resetPasswordScreen;
  static String getMainBottomNavScreen() => mainBottomNavScreen;
  static String getNewTasksScreen() => newTasksScreen;
  static String getProgressTasksScreen() => progressTasksScreen;
  static String getCompletedTasksScreen() => completedTasksScreen;
  static String getCancelledTasksScreen() => cancelledTasksScreen;
  static String getAddNewTaskScreen() => addNewTaskScreen;
  static String getEditProfileScreen() => editProfileScreen;


  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: signUpScreen, page: () => const SignUpScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: forgotPasswordScreen, page: () => const ForgotPasswordScreen()),
    GetPage(name: pinVerificationScreen, page: () => const PinVerificationScreen(email: '',)),
    GetPage(name: resetPasswordScreen, page: () => const ResetPasswordScreen(email: '', otp: '',)),
    GetPage(name: mainBottomNavScreen, page: () => const MainBottomNavScreen()),
    GetPage(name: newTasksScreen, page: () => const NewTasksScreen()),
    GetPage(name: progressTasksScreen, page: () => const ProgressTasksScreen()),
    GetPage(name: completedTasksScreen, page: () => const CompletedTasksScreen()),
    GetPage(name: cancelledTasksScreen, page: () => const CancelledTasksScreen()),
    GetPage(name: addNewTaskScreen, page: () => const AddNewTaskScreen()),
    GetPage(name: editProfileScreen, page: () => const EditProfileScreen()),



  ];
}