import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../styles/colors.dart';

class GeneralItem extends StatelessWidget {
  const GeneralItem(this.icon,this.name, {super.key}
      );
  final String icon;
  final String name;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
           Container(
               margin: EdgeInsets.all(5),
               width: 40, // Adjust the size as needed
            height: 40, // Adjust the size as needed
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.withOpacity(0.5),             ),
            child: Center(
              child: Image.asset(
                icon, // Replace with your image asset path
                width: 30,
                height: 20,
              ),

          )
        ),
        SizedBox(height: 20,child:Text(name,style:TextStyle(color: Colors.black,fontSize: 12),)
          ,)
      ],
    );
  }
}