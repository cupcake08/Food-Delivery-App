import 'package:flutter/foundation.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/state_manager.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      debugPrint("got Products");
      _popularProductList = [];
      _popularProductList
          .addAll(Product.fromJson(response.body).products as List);
      // print(_popularProductList);
      _isLoading = false;
      update();
    }
  }
}
