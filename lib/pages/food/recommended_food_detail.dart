import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text.dart';
import 'package:get/get.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  const RecommendedFoodDetail({Key? key, required this.pageId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductModel product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .init(Get.find<CartController>(), product);
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 60,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: const AppIcon(icon: Icons.clear),
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
            pinned: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(30),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  ),
                  color: Colors.white,
                ),
                child: Center(
                    child: BigText(
                  text: product.name,
                  size: Dimensions.font26,
                )),
                width: double.maxFinite,
                padding: const EdgeInsets.only(
                  top: 5,
                  bottom: 10,
                ),
                // decoration: ,
              ),
            ),
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 320,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL + "/uploads/${product.img}",
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                  child: ExpandableTextWidget(text: product.description),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProduct) {
          int amount = popularProduct.quantity * product.price;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //calculation part
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width20 * 2.5,
                  vertical: Dimensions.height10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () => popularProduct.setQuantity(false),
                      child: AppIcon(
                        icon: Icons.remove,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        iconSize: Dimensions.iconSize24,
                      ),
                    ),
                    BigText(
                      text: "\$${product.price} X ${popularProduct.quantity}",
                      color: AppColors.mainBlackColor,
                      size: Dimensions.font26,
                    ),
                    InkWell(
                      onTap: () => popularProduct.setQuantity(true),
                      child: AppIcon(
                        icon: Icons.add,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        iconSize: Dimensions.iconSize24,
                      ),
                    ),
                  ],
                ),
              ),
              //add to cart and like
              Container(
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
                          horizontal: Dimensions.width20,
                          vertical: Dimensions.height20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: AppColors.mainColor,
                        )),
                    InkWell(
                      onTap: () => popularProduct.addItem(product),
                      child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width15,
                            vertical: Dimensions.height20,
                          ),
                          child: BigText(
                            text: "\$ $amount | Add to bag",
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: AppColors.mainColor,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
