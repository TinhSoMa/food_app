import 'package:get/get.dart';

import '../data/repository/recommended_product_repo.dart';
import '../models/products_model.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;

  bool _isLoader = false;
  bool get isLoader => _isLoader;

  Future<void> getRecommendedProductList() async {
    Response response = await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode==200) {
      // print("iloveu");
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      // print(_popularProductList);
      _isLoader = true;
      update();
    } else {
      print("Loi recommended");
    }
  }
}