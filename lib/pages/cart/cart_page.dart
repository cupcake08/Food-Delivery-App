import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/cart_item.dart';
import 'package:get/get.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(Dimensions.height10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppIcon(
                    icon: Icons.arrow_back_ios_new,
                    backgroundColor: AppColors.mainColor,
                  ),
                  const Spacer(flex: 2),
                  GestureDetector(
                    onTap: () => Get.toNamed(RouteHelper.getInitial()),
                    child: AppIcon(
                      icon: Icons.home_outlined,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  SizedBox(width: Dimensions.width30),
                  AppIcon(
                    icon: Icons.shopping_cart_outlined,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ],
              ),
            ),
            Expanded(
              child: GetBuilder<CartController>(
                builder: (cartProduct) {
                  var cartList = cartProduct.getItems;
                  return ListView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: Dimensions.height10),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      debugPrint("count: ${cartList.length}");
                      return CartItem(
                        item: cartList[index],
                        addItem: cartProduct.addItem,
                      );
                    },
                    itemCount: cartList.length,
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar:
            GetBuilder<CartController>(builder: (cartController) {
          var cartList = cartController.getItems;
          int price = 0;
          for (int i = 0; i < cartList.length; i++) {
            price += cartList[i].quantity * cartList[i].price;
          }
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
                    horizontal: Dimensions.width20,
                    vertical: Dimensions.height20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                  ),
                  child: BigText(
                    text: "\$$price",
                    color: AppColors.mainColor,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width15,
                        vertical: Dimensions.height20,
                      ),
                      child: const BigText(
                        text: "Place Order",
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
          );
        }),
      ),
    );
  }
}
