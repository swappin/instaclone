import 'package:flutter/material.dart';
import 'package:instaclone/ui/home.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  String title = "Instaclone";
  CustomAppBar({this.title});
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Home(),
                ),
              );
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {},
              child: Icon(
                Icons.airplanemode_active,
                color: Colors.black,
              ),
            ),
          ],
        ),
        preferredSize: Size(double.infinity, 200));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50);
}
