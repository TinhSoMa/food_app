import 'package:food_app/cart/cart_page.dart';
import 'package:food_app/pages/food/popular_food_detail.dart';
import 'package:food_app/pages/home/home_page.dart';
import 'package:food_app/pages/home/main_food_page.dart';
import 'package:get/get.dart';

import '../pages/food/recommended_food_detail.dart';

class RouteHelper {
  static const String initial="/";
  static const String popularFood="/popular-food";
  static const String recommendedFood="/recommended-food";
  static const String cartPage="/cart-page";


  static String getInitial()=>'$initial';
  static String getPopularFood(int idPage, String page)=>'$popularFood?idPage=$idPage&page=$page';
  static String getRecommendedFood(int idPage, String page)=>'$recommendedFood?idPage=$idPage&page=$page';
  static String getCartPage()=>'$cartPage';

  static List<GetPage> routes=[
    GetPage(name: initial, page: ()=>const HomePage()),

    GetPage(name: popularFood, page: (){
      var idPage = Get.parameters['idPage'];
      // print("Nhận được giá trị " + idPage.toString());
      var page = Get.parameters["page"];
      return PopularFoodDetail(idPage: int.parse(idPage!), page:page!);
    },
      transition: Transition.fadeIn
    ),

    GetPage(name: recommendedFood, page: (){
      var idPage = Get.parameters['idPage'];
      var page = Get.parameters["page"];

      return RecommendedFoodDetail(idPage: int.parse(idPage!), page:page!);
    },
        transition: Transition.fadeIn
    ),

    GetPage(name: cartPage, page: () {
      return const CartPage();
    },
      transition: Transition.fadeIn
    ),

  ];


}