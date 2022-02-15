import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text.dart';
import 'package:food_delivery/widgets/small_text.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  _FoodPageBodyState createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  double _pageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = 200;
  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _pageValue = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: PageView.builder(
        controller: _pageController,
        itemCount: 5,
        itemBuilder: (context, position) {
          return _buildPageItem(position);
        },
      ),
    );
  }

  Widget _buildPageItem(int index) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _pageValue.floor()) {
      double currScale = 1 - (_pageValue - index) * (1 - _scaleFactor);
      double currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _pageValue.floor() + 1) {
      double currScale =
          _scaleFactor + (_pageValue - index + 1) * (1 - _scaleFactor);
      double currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _pageValue.floor() - 1) {
      double currScale = 1 - (_pageValue - index) * (1 - _scaleFactor);
      double currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      double currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 0);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: _height,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: index.isEven
                  ? const Color(0xff69c5df)
                  : const Color(0xFF9294cc),
              image: const DecorationImage(
                image: AssetImage("assets/image/food0.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 120,
              margin: const EdgeInsets.only(bottom: 30, left: 40, right: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 5),
                    blurRadius: 5,
                    color: Colors.black.withOpacity(0.3),
                  ),
                  const BoxShadow(
                    offset: Offset(-5, 0),
                    color: Colors.white,
                  ),
                  const BoxShadow(
                    offset: Offset(5, 0),
                    color: Colors.white,
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BigText(text: "Chinese Slide"),
                    const SizedBox(height: 10),
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
                    const SizedBox(height: 15),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
