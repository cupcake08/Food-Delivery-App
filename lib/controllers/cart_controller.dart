import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:get/state_manager.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  final Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;
  bool cartExist(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    } else {
      return false;
    }
  }

  int get cartItems => _items.length;
  List<CartModel> get getItems {
    return _items.entries.map((e) => e.value).toList();
  }

  void addItem(ProductModel product, int quantity) {
    if (quantity < 0) return;
    if (_items.containsKey(product.id) && quantity == 0) {
      _items.remove(product.id);
    } else if (_items.containsKey(product.id)) {
      _items.update(product.id, (cartModel) {
        return CartModel(
          id: cartModel.id,
          img: cartModel.img,
          name: cartModel.name,
          price: cartModel.price,
          isExist: true,
          time: DateTime.now().toString(),
          quantity: quantity,
          product: product,
        );
      });
    } else {
      _items.putIfAbsent(
        product.id,
        () {
          return CartModel(
            id: product.id,
            img: product.img,
            name: product.name,
            price: product.price,
            isExist: true,
            time: DateTime.now().toString(),
            quantity: quantity,
            product: product,
          );
        },
      );
    }
    cartRepo.addToSharedPreferences(getItems);
    update();
  }
}
