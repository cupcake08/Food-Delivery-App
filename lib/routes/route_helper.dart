import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/food/popular_food_detail.dart';
import 'package:food_delivery/pages/food/recommended_food_detail.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = "/";
  static const String popularRoute = "/popular-food-details";
  static const String recommendedRoute = "/recommended-food-details";
  static const String cartRoute = "/cart";

  static String getPopularPage(int pageId) => "$popularRoute?pageId=$pageId";
  static String getInitial() => initial;
  static String getRecommendedPage(int pageId) =>
      "$recommendedRoute?pageId=$pageId";
  static String getCartPage() => cartRoute;
  static List<GetPage> routes = [
    GetPage(
      name: initial,
      page: () => const MainFoodPage(),
    ),
    GetPage(
      name: popularRoute,
      page: () {
        String? pageId = Get.parameters['pageId'];
        return PopularFoodDetail(pageId: int.parse(pageId!));
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: recommendedRoute,
      page: () {
        String? pageId = Get.parameters['pageId'];
        return RecommendedFoodDetail(pageId: int.parse(pageId!));
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: cartRoute,
      page: () => const Cart(),
      transition: Transition.fadeIn,
    )
  ];
}
