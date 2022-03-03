import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    required this.item,
    required this.addItem,
  }) : super(key: key);
  final CartModel item;
  final Function addItem;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var popularIndex = Get.find<PopularProductController>()
            .popularProductList
            .indexOf(item.product);
        if (popularIndex >= 0) {
          Get.toNamed(RouteHelper.getPopularPage(popularIndex));
        } else {
          var recommendedIndex = Get.find<RecommendedProductController>()
              .recommendedProductList
              .indexOf(item.product);
          Get.toNamed(RouteHelper.getRecommendedPage(recommendedIndex));
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: Dimensions.height10),
        height: Dimensions.height20 * 6,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              height: Dimensions.height20 * 6,
              width: Dimensions.height20 * 6,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      AppConstants.BASE_URL + "/uploads/${item.img}"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(Dimensions.radius20),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BigText(text: item.name),
                    SmallText(text: "spicy"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BigText(
                          text: "\$${item.price}",
                          color: Colors.red,
                        ),
                        Container(
                          height: Dimensions.height20 * 2,
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width10,
                            vertical: Dimensions.height10 / 1.5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () =>
                                    addItem(item.product, item.quantity - 1),
                                icon: const Icon(
                                  Icons.remove,
                                  color: AppColors.signColor,
                                ),
                              ),
                              SizedBox(width: Dimensions.width10 / 8),
                              BigText(text: "${item.quantity}"),
                              SizedBox(width: Dimensions.width10 / 8),
                              IconButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () =>
                                    addItem(item.product, item.quantity + 1),
                                icon: const Icon(
                                  Icons.add,
                                  color: AppColors.signColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
