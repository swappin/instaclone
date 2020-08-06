import 'package:flutter/material.dart';
import 'package:instaclone/ui/chat_screen.dart';
import 'package:instaclone/ui/widgets/custom_icon.dart';

class NavigationAppBar extends StatefulWidget {
  @override
  _NavigationAppBarState createState() => _NavigationAppBarState();
}

class _NavigationAppBarState extends State<NavigationAppBar> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        child: Container(
          color: Color(0xFFF3F4F5),
          child: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: Color(0xFFCCCCCC),
                      ))),
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                    },
                    child: Container(
                      width: 50,
                      alignment: Alignment.center,
                      child: CustomIcon(
                        icon: "camera",
                        width: 26,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Image.asset(
                        "assets/logo.png",
                        height: 30,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: 50,
                      alignment: Alignment.center,
                      child: CustomIcon(
                        icon: "message",
                        width: 26,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        preferredSize: Size.fromHeight(50)
    );
  }
}
