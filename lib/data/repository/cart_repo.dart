import 'dart:convert';

import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo extends GetxService {
  final SharedPreferences sp;
  CartRepo({required this.sp});

  List<String> cart = [];

  void addToSharedPreferences(List<CartModel> items) {
    cart = [];
    for (int i = 0; i < items.length; i++) {
      cart.add(jsonEncode(items[i]));
    }
    sp.setStringList(AppConstants.CART_LIST, cart);
    // print(sp.getStringList(AppConstants.CART_LIST));
  }

  List<CartModel> getCartItems() {
    List<String> cart = [];
    if (sp.containsKey(AppConstants.CART_LIST)) {
      cart = sp.getStringList(AppConstants.CART_LIST) ?? [];
      print("from local storage: $cart");
    }

    List<CartModel> finalCart = [];

    for (int i = 0; i < cart.length; i++) {
      finalCart.add(CartModel.fromJson(jsonDecode(cart[i])));
    }
    return finalCart;
  }
}
