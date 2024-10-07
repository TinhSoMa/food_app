import 'package:food_app/models/products_model.dart';

class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  bool? isExit;
  String? time;
  ProductsModel? productsModel;

  CartModel(
      {this.id,
        this.name,
        this.price,
        this.img,
        this.quantity,
        this.isExit,
        this.time,
        this.productsModel,
      });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    isExit = json['img'];
    time = json['time'];
    productsModel = ProductsModel.fromJson(json['product']);
  }
}