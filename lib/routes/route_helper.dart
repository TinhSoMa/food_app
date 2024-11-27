// import 'package:food_app/cart/cart_page.dart';
import 'package:food_app/pages/account/update_info_page.dart';
import 'package:food_app/pages/address/add_address_page.dart';
import 'package:food_app/pages/address/pick_address_map.dart';
import 'package:food_app/pages/auth/sign_in_page.dart';
import 'package:food_app/pages/food/popular_food_detail.dart';
import 'package:food_app/pages/home/home_page.dart';
import 'package:food_app/pages/home/main_food_page.dart';
import 'package:food_app/pages/splash/splash_page.dart';
import 'package:get/get.dart';

import '../pages/cart/cart_page.dart';
import '../pages/food/recommended_food_detail.dart';

class RouteHelper {
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String splashPage = "/splash-page";
  static const String signInPage = "/sign-in-page";
  static const String addAddress = "/add-address-page";
  static const String updateInfo = '/update-info';
  static const String pickAddressMap = '/pick-address-map';

  static String getInitial() => '$initial';
  static String getPopularFood(int idPage, String page) =>
      '$popularFood?idPage=$idPage&page=$page';
  static String getRecommendedFood(int idPage, String page) =>
      '$recommendedFood?idPage=$idPage&page=$page';
  static String getCartPage() => '$cartPage';
  static String getSplashPage() => '$splashPage';
  static String getSignInPage() => '$signInPage';
  static String getAddressPage() => '$addAddress';
  static String getUpdateInfo() => updateInfo;
  static String getPickAddresspage() => '$pickAddressMap';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => const SplashScreen()),
    GetPage(
        name: initial,
        page: () {
          return const HomePage();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: signInPage,
        page: () {
          return SignInPage();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: popularFood,
        page: () {
          var idPage = Get.parameters['idPage'];
          // print("Nhận được giá trị " + idPage.toString());
          var page = Get.parameters["page"];
          return PopularFoodDetail(idPage: int.parse(idPage!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFood,
        page: () {
          var idPage = Get.parameters['idPage'];
          var page = Get.parameters["page"];

          return RecommendedFoodDetail(idPage: int.parse(idPage!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () {
          return const CartPage();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: addAddress,
        page: () {
          return const AddressPage();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: updateInfo,
        page: () => const UpdateInfoPage(),
        transition: Transition.fadeIn),
    GetPage(name: pickAddressMap, page: () {
        PickAddressMap _pickAddressMap = Get.arguments;
        return _pickAddressMap;

    })
  ];
}
