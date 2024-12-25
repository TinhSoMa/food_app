import 'package:food_app/data/repository/order_repo.dart';
import 'package:food_app/models/place_order_model.dart';
import 'package:get/get.dart';

import '../models/order_model.dart';

class OrderController extends GetxController implements GetxService {
  OrderRepo orderRepo;
  OrderController({required this.orderRepo});
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  late List<OrderModel> _currentOrderList;
  late List<OrderModel> _historyOrderList;
  List<OrderModel> get currentOrderList => _currentOrderList;
  List<OrderModel> get historyOrderList => _historyOrderList;
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

  Future<void> getOrderList() async {
    _isLoading = true;
    Response response = await orderRepo.getOrderList();
    if (response.statusCode == 200) {
      _historyOrderList = [];
      _currentOrderList = [];
      response.body.forEach((order) {
        OrderModel orderModel = OrderModel.fromJson(order);
        if (orderModel.orderStatus == 'pending' ||
            orderModel.orderStatus == 'accepted' ||
            orderModel.orderStatus == 'processing' ||
            orderModel.orderStatus == 'handover' ||
            orderModel.orderStatus == 'picked_up'
        ) {
          _currentOrderList.add(orderModel);
        } else {
          _historyOrderList.add(orderModel);
        }
      });
    } else {
      _historyOrderList = [];
      _currentOrderList = [];
    }
    _isLoading = false;
    print("currentOrderList:  ${_currentOrderList.length}");
    update();
  }
}