import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final String icon;
  final double width;
  final double height;
  //final VoidCallback onTap;

  CustomIcon({this.icon, this.width, this.height, /*this.onTap*/});

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/icons/$icon.png",
      width: width,
      height: height,
    );
  }
}