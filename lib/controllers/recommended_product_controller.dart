import 'package:flutter/foundation.dart';
import 'package:food_delivery/data/repository/recommended_product_repo.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/state_manager.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> getRecommendedProductList() async {
    Response res = await recommendedProductRepo.getRecommendeProductList();
    if (res.statusCode == 200) {
      debugPrint("Recommended Products Got");
      _recommendedProductList = [];
      _recommendedProductList
          .addAll(Product.fromJson(res.body).products as List);
      _isLoading = false;
      update();
    }
  }
}
