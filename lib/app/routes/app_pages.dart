import 'package:get/get.dart';
import 'package:task_app/main.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();
  static  String INITIAL = init == true ? Routes.HOME : Routes.ONBOARDING;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnBoardingView(),
      binding: OnBoardingBinding(),
    ),
  ];
}
