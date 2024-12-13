import 'package:food_app/data/repository/order_repo.dart';
import 'package:food_app/models/place_order_model.dart';
import 'package:get/get.dart';

class OrderController extends GetxController implements GetxService {
  OrderRepo orderRepo;
  OrderController({required this.orderRepo});
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<void> placeOrder(PlaceOrderBody placeOrderBody ,Function callBack) async {
    Response response = await orderRepo.placeOrder(placeOrderBody);
    if (response.statusCode == 200) {
      _isLoading = false;
      String message = response.body['message'];
      String orderID = response.body['order_id'].toString();
      callBack(true, message, orderID);

    } else {
      print("loi order" + response.body.toString());
      callBack(false, response.statusText!, '');
    }
  }
}