import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';

import './food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  _MainFoodPageState createState() => _MainFoodPageState();
}

Gradient getGradient(Color color) {
  return LinearGradient(
      colors: [color.withOpacity(0.4), color.withOpacity(0.4)],
      stops: const [0.0, 0.7]);
}

class _MainFoodPageState extends State<MainFoodPage> {
  int _selectedIndex = 0;
  List<Widget> list = const [
    MainPage(),
    Center(child: Text("Second page")),
    Center(child: Text("third page")),
    Center(child: Text("fourth page")),
  ];
  List<Tabs> tabs = [
    Tabs(Icons.home, "Home", AppColors.mainColor,
        getGradient(AppColors.mainColor)),
    Tabs(Icons.archive_outlined, "Archive", Colors.pink,
        getGradient(Colors.pink)),
    Tabs(Icons.shopping_cart_outlined, "Cart", Colors.amber,
        getGradient(Colors.amber)),
    Tabs(Icons.person_outline_outlined, "Person", Colors.teal,
        getGradient(Colors.teal)),
  ];
  // void onNavItemTap(int index) => setState(() => _selectedIndex = index);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[_selectedIndex],
      bottomNavigationBar: CubertoBottomBar(
        barBackgroundColor: Colors.white60,
        tabStyle: CubertoTabStyle.STYLE_FADED_BACKGROUND,
        selectedTab: _selectedIndex,
        barBorderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.radius20),
          topRight: Radius.circular(Dimensions.radius20),
        ),
        tabs: tabs
            .map((value) => TabData(
                  iconData: value.icon,
                  title: value.title,
                  tabColor: value.color,
                  key: Key(value.title),
                  tabGradient: value.gradient,
                ))
            .toList(),
        onTabChangedListener: (position, title, tabColor) {
          setState(() {
            _selectedIndex = position;
          });
        },
      ),
    );
  }
}

class Tabs {
  final IconData icon;
  final String title;
  final Color color;
  final Gradient gradient;

  Tabs(this.icon, this.title, this.color, this.gradient);
}

class MainPage extends StatelessWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Container(
            margin: EdgeInsets.only(
                top: Dimensions.height45, bottom: Dimensions.height15),
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const BigText(
                      text: "India",
                      color: AppColors.mainColor,
                    ),
                    Row(
                      children: const [
                        SmallText(
                          text: "Ankit",
                          color: Colors.black54,
                        ),
                        Icon(Icons.arrow_drop_down_rounded),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: Dimensions.width45,
                  height: Dimensions.height45,
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: Dimensions.iconSize24,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                    color: AppColors.mainColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Expanded(
          child: SingleChildScrollView(
            child: FoodPageBody(),
          ),
        ),
      ],
    );
  }
}
