import 'package:flutter/material.dart';
import 'package:food_app/cart/cart_page.dart';
import 'package:food_app/controllers/popular_product_coontroller.dart';
import 'package:food_app/controllers/recommended_product_controller.dart';
import 'package:food_app/models/products_model.dart';
import 'package:food_app/pages/food/popular_food_detail.dart';
import 'package:food_app/pages/food/recommended_food_detail.dart';
import 'package:food_app/pages/home/food_page_body.dart';
import 'package:food_app/pages/home/main_food_page.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:get/get.dart';
import 'controllers/cart_controller.dart';
import 'data/repository/cart_repo.dart';
import 'helper/dependencies.dart' as dep;
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  Get.put(CartController(cartRepo: CartRepo()));
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      Get.find<PopularProductController>().getPopularProductList();
      Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      // home: MainFoodPage(),
      initialRoute: RouteHelper.getInitial(),
      getPages: RouteHelper.routes,
    );
  }
}