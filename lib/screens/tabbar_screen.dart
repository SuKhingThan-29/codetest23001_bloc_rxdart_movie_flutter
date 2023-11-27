
import 'package:flutter/material.dart';
import '../styles/colors.dart';
import '../widgets/tabbar_item.dart';
import 'home_screen.dart';
class TabbarScreen extends StatefulWidget {
  const TabbarScreen({Key? key}) : super(key: key);

  @override
  TabbarScreenState createState() => TabbarScreenState();
}

class TabbarScreenState extends State<TabbarScreen>
    with TickerProviderStateMixin {
  int activeTabIndex = 0;
  List barItems = [
    {
      "icon": "assets/icons/home.png",
      "page": HomeScreen(),
    },
    {
      "icon": "assets/icons/wallet.png",
      "page": HomeScreen(),
    },
    {
      "icon": "assets/icons/more.png",
      "page": HomeScreen(),
    },
  ];

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  void onPageChanged(int index) {
    if (index == activeTabIndex) return;
    _controller.reset();
    setState(() {
      activeTabIndex = index;
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      bottomNavigationBar: buildBottomBar(),
      body: buildBottomBarPage(),
    );
  }

  Widget buildBottomBarPage() {
    return IndexedStack(
      index: activeTabIndex,
      children: List.generate(
          barItems.length,
          (index) => FadeTransition(
              child: barItems[index]["page"], opacity: _animation)),
    );
  }

  Widget buildBottomBar() {
    return Container(
      height: 75,
      width: double.infinity,
      decoration: BoxDecoration(
          color: white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: black87.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 1),
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 45,
          right: 45,
          bottom: 15,
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
                barItems.length,
                (index) => TabbarItem(
                      barItems[index]["icon"],
                      isActive: activeTabIndex == index,
                      activeColor: maroon,
                      onTap: () {
                        onPageChanged(index);
                      },
                    ))),
      ),
    );
  }
}
