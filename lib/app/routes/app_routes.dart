
import 'package:edemadetection/app/modules/splash_screen/bindings/splash_screen_binding.dart';
import 'package:edemadetection/app/modules/splash_screen/views/splash_screen_view.dart';
import 'package:edemadetection/screens/login.dart';
import 'package:edemadetection/screens/onboarding_screens.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  static const String initialRoute = '/initialRoute';
  static const String loginRoute = '/loginRoute';
  static const String onBoardingRoute = '/onBoardingRoute';

  static List<GetPage> pages = [
    GetPage(
      name: initialRoute,
      page: () => const SplashScreen(),
      bindings: [
        SplashScreenBinding(),
      ],
    ),
    GetPage(
      name: onBoardingRoute,
      page: () => const OnBoardingPage(),
    ),
    GetPage(
      name: loginRoute,
      page: () => const LoginView(),
    ),

  ];
}