import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'big_text.dart';
import 'small_text.dart';
import 'icon_and_text.dart';

class AppColumn extends StatelessWidget {
  const AppColumn({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          // left: Dimensions.width15,
          // right: Dimensions.width15,
          top: Dimensions.height20),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(
            text: text,
            size: Dimensions.font26,
          ),
          SizedBox(height: Dimensions.height10),
          Row(
            children: [
              Wrap(
                children: List.generate(
                  5,
                  (index) => const Icon(
                    Icons.star,
                    color: AppColors.mainColor,
                    size: 15,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SmallText(text: "4.5"),
              const SizedBox(width: 10),
              SmallText(text: "1234"),
              SizedBox(width: 5),
              SmallText(text: "comments"),
            ],
          ),
          SizedBox(height: Dimensions.width20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              IconText(
                icon: Icons.circle_sharp,
                text: "Normal",
                iconColor: AppColors.iconColor1,
              ),
              IconText(
                icon: Icons.location_on,
                text: "1.7km",
                iconColor: AppColors.mainColor,
              ),
              IconText(
                icon: Icons.access_time_rounded,
                text: "32min",
                iconColor: AppColors.iconColor2,
              )
            ],
          ),
        ],
      ),
    );
  }
}
