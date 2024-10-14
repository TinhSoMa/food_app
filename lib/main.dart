import 'package:flutter/material.dart';
// import 'package:food_app/cart/cart_page.dart';
import 'package:food_app/controllers/popular_product_coontroller.dart';
import 'package:food_app/controllers/recommended_product_controller.dart';

import 'package:food_app/routes/route_helper.dart';
import 'package:get/get.dart';

import 'helper/dependencies.dart' as dep;
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  // Get.put(CartController(cartRepo: CartRepo(sharedPreferences: Get.find())));
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetBuilder<PopularProductController>(builder: (_) {
      return GetBuilder<RecommendedProductController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',

          // home: SplashScreen(),
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
        );
      });
    });
  }
}