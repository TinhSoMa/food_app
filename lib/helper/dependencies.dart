import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/controllers/popular_product_coontroller.dart';
import 'package:food_app/data/api/api_client.dart';
import 'package:food_app/data/repository/cart_repo.dart';
import 'package:food_app/data/repository/popular_product_repo.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';

import '../controllers/recommended_product_controller.dart';
import '../data/repository/recommended_product_repo.dart';

Future<void> init() async {
  // api client 10.0.2.2 http://192.168.101.36:8000
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));
  // repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo());
//   controller
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));

}