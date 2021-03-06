import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text.dart';
import 'package:get/get.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  const PopularFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductModel product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .init(Get.find<CartController>(), product);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //Image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularFoodImgSize,
              decoration: BoxDecoration(
                  //later it gonna be dynamic
                  image: DecorationImage(
                image: NetworkImage(
                    AppConstants.BASE_URL + "/uploads/${product.img}"),
                fit: BoxFit.cover,
              )),
            ),
          ),
          //icons
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: const AppIcon(icon: Icons.arrow_back_ios),
                  onTap: () => Get.toNamed(RouteHelper.getInitial()),
                ),
                GetBuilder<PopularProductController>(builder: (product) {
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () => Get.toNamed(RouteHelper.getCartPage()),
                        child:
                            const AppIcon(icon: Icons.shopping_cart_outlined),
                      ),
                      Get.find<PopularProductController>().inCartItems > 0
                          ? const Positioned(
                              top: 0,
                              right: 0,
                              child: AppIcon(
                                icon: Icons.circle,
                                size: 18,
                                iconColor: Colors.transparent,
                                backgroundColor: AppColors.mainColor,
                              ),
                            )
                          : Container(),
                      Get.find<PopularProductController>().inCartItems > 0
                          ? Positioned(
                              top: 2,
                              right: 5,
                              child: BigText(
                                text: Get.find<PopularProductController>()
                                    .inCartItems
                                    .toString(),
                                size: 12,
                                color: Colors.white,
                              ))
                          : Container(),
                    ],
                  );
                }),
              ],
            ),
          ),
          //details part
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodImgSize - 20,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20),
                  topRight: Radius.circular(Dimensions.radius20),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(text: product.name),
                  SizedBox(height: Dimensions.height20),
                  const BigText(text: "Introduce"),
                  SizedBox(height: Dimensions.height20),
                  //Expandable text widget
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(text: product.description),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (controller) {
          int amount = controller.quantity * product.price;
          return Container(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
            height: Dimensions.bottomHeightBar,
            decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20 * 2),
                topRight: Radius.circular(Dimensions.radius20 * 2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width10,
                    vertical: Dimensions.height10 / 1.5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () => controller.setQuantity(false),
                        icon: const Icon(
                          Icons.remove,
                          color: AppColors.signColor,
                        ),
                      ),
                      SizedBox(width: Dimensions.width10 / 5),
                      BigText(text: '${controller.quantity}'),
                      SizedBox(width: Dimensions.width10 / 5),
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () => controller.setQuantity(true),
                        icon: const Icon(
                          Icons.add,
                          color: AppColors.signColor,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => controller.addItem(product),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width15,
                      vertical: Dimensions.height20,
                    ),
                    child: BigText(
                      text: "\$$amount | Add to cart",
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
