import 'package:flutter/material.dart';
import '../styles/colors.dart';

class TabbarItem extends StatelessWidget {
  const TabbarItem(this.icon,
      {super.key,
        this.onTap,
        this.color = grey,
        this.activeColor = maroon,
        this.isActive = false});
  final String icon;
  final Color color;
  final Color activeColor;
  final bool isActive;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        padding: const EdgeInsets.all(6),
        child: Image.asset(
          icon,
          color: isActive ? maroon : color,
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}
