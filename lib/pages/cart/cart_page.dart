import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/cart_item.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

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
                    onTap: () => Get.to(() => const MainFoodPage()),
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
                builder: (cartProduct) => ListView.builder(
                  padding:
                      EdgeInsets.symmetric(horizontal: Dimensions.height10),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    debugPrint("count: ${cartProduct.getItems.length}");
                    return CartItem(
                      item: cartProduct.getItems[index],
                    );
                  },
                  itemCount: cartProduct.getItems.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
