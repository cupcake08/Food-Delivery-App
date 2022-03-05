import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:get/get.dart';

import '../data/repository/popular_product_repo.dart';
import '../models/product_model.dart';
import '../utils/colors.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});

  //variables
  List<dynamic> _popularProductList = [];
  bool _isLoading = true;
  int _quantity = 0;
  int _inCartItems = 0;
  late CartController _cart;

  //getters
  List<dynamic> get popularProductList => _popularProductList;
  bool get isLoading => _isLoading;
  int get quantity => _quantity;
  int get inCartItems => _inCartItems;
  List<CartModel> get getItems => _cart.getItems;

  void init(CartController cart, ProductModel product) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    bool exist = false;
    exist = _cart.cartExist(product);
    if (exist) {
      _quantity = _cart.items[product.id]!.quantity;
    }
    _cart.items.forEach((key, value) {
      if (key == product.id) {
        _inCartItems = value.quantity;
      }
    });
    //get data from storage
  }

  void addItem(ProductModel product) {
    if (_quantity > 0) {
      _cart.addItem(product, _quantity);
      _cart.items.forEach((key, value) {
        if (key == product.id) {
          _inCartItems = value.quantity;
        }
      });
    } else {
      Get.snackbar(
        "Item count",
        "Add atleast 1 item to cart",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.black,
      );
    }
    update();
  }

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      debugPrint("Popular Product Got");
      _popularProductList = [];
      _popularProductList
          .addAll(Product.fromJson(response.body).products as List);
      // print(_popularProductList);
      _isLoading = false;
      update();
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if (quantity < 0) {
      Get.snackbar(
        "Item count can't be negative",
        "You can't reduce more",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.black,
      );
      return 0;
    } else if (quantity > 20) {
      Get.snackbar(
        "Quantity reached!",
        "You can't add more",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.black,
      );
      return 20;
    } else {
      return quantity;
    }
  }
}
