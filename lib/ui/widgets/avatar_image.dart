import 'package:flutter/material.dart';

class AvatarImage extends StatelessWidget {
  final String image;

  AvatarImage({this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            image,
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(35)),
      ),
    );
  }
}
