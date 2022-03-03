import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  _FoodPageBodyState createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  double _pageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;
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
    return Column(
      children: [
        //Page Slider
        GetBuilder<PopularProductController>(
          builder: (popularProducts) {
            return popularProducts.isLoading
                ? const Center(
                    child:
                        CircularProgressIndicator(color: AppColors.mainColor),
                  )
                : SizedBox(
                    height: Dimensions.pageView,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: popularProducts.popularProductList.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position,
                            popularProducts.popularProductList[position]);
                      },
                    ),
                  );
          },
        ),
        //Dot Indicator
        GetBuilder<PopularProductController>(
          builder: (popularProducts) => DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _pageValue,
            decorator: const DotsDecorator(
              activeColor: AppColors.mainColor,
              size: Size.square(9.0),
              activeSize: Size(18, 9),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
            ),
          ),
        ),
        //Popular Text
        SizedBox(height: Dimensions.height30),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const BigText(text: "Recommended"),
              SizedBox(width: Dimensions.width10),
              Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  child: const BigText(text: ".", color: Colors.black26)),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: const SmallText(text: "Food pairing"),
              ),
            ],
          ),
        ),
        //list of food and images
        GetBuilder<RecommendedProductController>(
          builder: (recommendedProduct) => ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recommendedProduct.recommendedProductList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => Get.toNamed(RouteHelper.getRecommendedPage(index)),
                child: Container(
                  margin: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    bottom: Dimensions.height10,
                  ),
                  child: Row(
                    children: [
                      //image sectionp
                      Container(
                        width: Dimensions.listViewImgSize,
                        height: Dimensions.listViewImgSize,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white38,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(AppConstants.BASE_URL +
                                "/uploads/${recommendedProduct.recommendedProductList[index].img}"),
                          ),
                        ),
                      ),
                      //text Container
                      Expanded(
                        child: Container(
                          height: Dimensions.listViewTextContSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(Dimensions.radius20),
                              bottomRight: Radius.circular(Dimensions.radius20),
                            ),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: Dimensions.width10,
                                right: Dimensions.width10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(
                                    text: recommendedProduct
                                        .recommendedProductList[index].name),
                                SizedBox(height: Dimensions.height10),
                                SmallText(
                                  text: recommendedProduct
                                      .recommendedProductList[index]
                                      .description,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
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
      child: InkWell(
        onTap: () => Get.toNamed(RouteHelper.getPopularPage(index)),
        child: Stack(
          children: [
            Container(
              height: _height,
              margin: EdgeInsets.symmetric(horizontal: Dimensions.width10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: index.isEven
                    ? const Color(0xff69c5df)
                    : const Color(0xFF9294cc),
                image: DecorationImage(
                  image: NetworkImage(
                      AppConstants.BASE_URL + "/uploads/${popularProduct.img}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                height: Dimensions.pageViewTextContainer,
                margin: EdgeInsets.only(
                  bottom: Dimensions.height20,
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
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
                child: AppColumn(
                  text: popularProduct.name,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
