import 'package:food_delivery/models/product_model.dart';

class CartModel {
  int? _id;
  String? _name;
  int? _price;
  String? _img;
  int? _quantity;
  bool? _isExist;
  String? _time;
  ProductModel? _product;

  CartModel(
      {int? id,
      String? name,
      int? price,
      String? img,
      int? quantity,
      bool isExist = false,
      String? time,
      ProductModel? product}) {
    if (id != null) {
      _id = id;
    }
    if (name != null) {
      _name = name;
    }
    if (price != null) {
      _price = price;
    }

    if (img != null) {
      _img = img;
    }
    _quantity = quantity;
    _isExist = isExist;
    _time = time;
    _product = product;
  }

  String get img => _img!;
  String get name => _name!;
  int get price => _price!;
  int get id => _id!;
  int get quantity => _quantity!;
  String get time => _time!;
  bool get isExist => _isExist!;
  ProductModel get product => _product!;

  CartModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _price = json['price'];
    _img = json['img'];
    _quantity = json['quantity'];
    _time = json['time'];
    _isExist = json['isExist'];
    _product = ProductModel.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": _id,
      "name": _name,
      "price": _price,
      "img": _img,
      "quantity": _quantity,
      "time": _time,
      "isExist": _isExist,
      "product": _product,
    };
  }
}
