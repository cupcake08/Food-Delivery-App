import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text.dart';

class PopularFoodDetail extends StatelessWidget {
  const PopularFoodDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              decoration: const BoxDecoration(
                  //later it gonna be dynamic
                  image: DecorationImage(
                image: AssetImage("assets/image/food0.png"),
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
              children: const [
                AppIcon(icon: Icons.arrow_back_ios),
                AppIcon(icon: Icons.shopping_bag_outlined),
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
                  const AppColumn(text: "Chinese Side"),
                  SizedBox(height: Dimensions.height20),
                  const BigText(text: "Introduce"),
                  SizedBox(height: Dimensions.height20),
                  //Expandable text widget
                  const Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(
                          text:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
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
                horizontal: Dimensions.width15,
                vertical: Dimensions.height20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.remove,
                    color: AppColors.signColor,
                  ),
                  SizedBox(width: Dimensions.width10 / 5),
                  const BigText(text: "0"),
                  SizedBox(width: Dimensions.width10 / 5),
                  const Icon(
                    Icons.add,
                    color: AppColors.signColor,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width15,
                vertical: Dimensions.height20,
              ),
              child: const BigText(
                text: "\$ 10 | Add to bag",
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: AppColors.mainColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
