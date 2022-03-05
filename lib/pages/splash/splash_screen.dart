import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  // Future<void> _loadResources() async {
  //   await Get.find<PopularProductController>().getPopularProductList();
  //   await Get.find<RecommendedProductController>().getRecommendedProductList();
  // }

  @override
  void initState() {
    super.initState();
    // _loadResources();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    )..forward();
    // _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _animation = Tween(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    Timer(
      const Duration(seconds: 3),
      () => Get.offNamed(RouteHelper.getInitial()),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: _animation,
            child: Center(
              child: Image.asset(
                "assets/image/logo part 1.png",
                width: Dimensions.imgWidth,
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: _controller.value,
            duration: const Duration(milliseconds: 1300),
            child: Center(
              child: Image.asset(
                "assets/image/logo part 2.png",
                width: Dimensions.imgWidth,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
