import 'package:get/get.dart';
import 'package:restaurant_api/routes/routes_name.dart';
import 'package:restaurant_api/views/favourite_view.dart';
import 'package:restaurant_api/views/home_view.dart';
import 'package:restaurant_api/views/search_view.dart';
import 'package:restaurant_api/views/setting_view.dart';
import 'package:restaurant_api/views/splash_view.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: RoutesName.splashView,
      page: () => const SplashView(),
    ),
    GetPage(
      name: RoutesName.homeView,
      page: () => HomeView(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 600),
    ),
    GetPage(
      name: RoutesName.searchView,
      page: () => SearchView(),
      transition: Transition.upToDown,
      transitionDuration: const Duration(milliseconds: 600),
    ),
    GetPage(
      name: RoutesName.favouriteView,
      page: () => FavouriteView(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 600),
    ),
    GetPage(
      name: RoutesName.settingView,
      page: () => SettingView(),
      transition: Transition.upToDown,
      transitionDuration: const Duration(milliseconds: 600),
    ),
  ];
}
