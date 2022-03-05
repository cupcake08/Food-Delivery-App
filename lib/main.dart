import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/helpers/dependencies.dart' as dep;
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/pages/splash/splash_screen.dart';
import 'package:get/get.dart';
import './routes/route_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    // return GetBuilder<PopularProductController>(builder: (_) {
    //   return GetBuilder<RecommendedProductController>(builder: (_) {
    //     return GetMaterialApp(
    //       debugShowCheckedModeBanner: false,
    //       title: 'Flutter Demo',
    //       initialRoute: RouteHelper.getSplashPage(),
    //       getPages: RouteHelper.routes,
    //     );
    //   });
    // });
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: RouteHelper.getSplashPage(),
      getPages: RouteHelper.routes,
    );
  }
}
