import 'dart:convert';

import 'package:food_app/models/cart_model.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart=[];

  void addToCartList(List<CartModel> cartList) {
    cart = [];
    // cartList.forEach((action) {
    //   return cart.add(jsonEncode(action));
    // });
    
    cartList.forEach((action)=> cart.add(jsonEncode(action)));
    
    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    getCartList();
    // print(sharedPreferences.getStringList(AppConstants.CART_LIST));
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      print("getCartList: " + carts.toString());
    }
    
    List<CartModel> cartList = [];
    carts.forEach((action) {
      Map<String, dynamic> cartMap = jsonDecode(action);
      cartList.add(CartModel.fromJson(cartMap));
    });

    return cartList;
  }
}