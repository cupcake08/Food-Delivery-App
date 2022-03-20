import 'dart:convert';

import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo extends GetxService {
  final SharedPreferences sp;
  CartRepo({required this.sp});

  List<String> cart = [];
  List<String> cartHistory = [];

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
      //print("from local storage: $cart");
    }

    List<CartModel> finalCart = [];

    for (int i = 0; i < cart.length; i++) {
      finalCart.add(CartModel.fromJson(jsonDecode(cart[i])));
    }
    return finalCart;
  }

  List<CartModel> getCartHistoryItems() {
    if (sp.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = [];
      cartHistory = sp.getStringList(AppConstants.CART_HISTORY_LIST) ?? [];
    }
    List<CartModel> historyCart = [];
    for (int i = 0; i < cartHistory.length; i++) {
      historyCart.add(CartModel.fromJson(jsonDecode(cartHistory[i])));
    }
    return historyCart;
  }

  void addToCartHistoryList() {
    if (sp.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = sp.getStringList(AppConstants.CART_HISTORY_LIST) ?? [];
    }
    for (int i = 0; i < cart.length; i++) {
      cartHistory.add(cart[i]);
    }
    sp.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
  }

  void removeCart() {
    cart = [];
    sp.remove(AppConstants.CART_LIST);
  }
}
