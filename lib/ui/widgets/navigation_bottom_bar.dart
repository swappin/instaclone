import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:instaclone/main.dart';
import 'package:instaclone/stores/post_store.dart';
import 'package:instaclone/ui/activity_screen.dart';
import 'package:instaclone/ui/camera_screen.dart';
import 'package:instaclone/ui/home.dart';
import 'package:instaclone/ui/profile_screen.dart';
import 'package:instaclone/ui/search_screen.dart';
import 'package:instaclone/ui/widgets/custom_icon.dart';

class NavigationBottomBar extends StatefulWidget {
  final int currentIndex;

  NavigationBottomBar({this.currentIndex});

  @override
  _NavigationBottomBarState createState() => _NavigationBottomBarState();
}

class _NavigationBottomBarState extends State<NavigationBottomBar> {
  PostStore postStore = PostStore();

  static List<CameraDescription> cameras;

  Future<void> initCamera() async {
    cameras = await availableCameras();
  }

  int currentIndex = 0;

  static List<Widget> _screenNavigator = <Widget>[
    Home(),
    SearchScreen(),
    CameraScreen(cameras),
    ActivityScreen(),
    ProfileScreen(
      currentUserNickname,
    ),
  ];

  @override
  void initState() {
    super.initState();
    initCamera().then(
      (onInitialize) => print("Cameras was initialized"),
    );
  }

  @override
  void dispose() {
    super.dispose();
    initCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Home(),
              ));
            },
            child: Container(
              child: CustomIcon(
                icon: "home",
                width: 23,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => SearchScreen(),
              ));
            },
            child: Container(
              child: CustomIcon(
                icon: "search",
                width: 22,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => CameraScreen(cameras),
              ));
            },
            child: Container(
              child: CustomIcon(
                icon: "post",
                width: 22,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => ActivityScreen(),
              ));
            },
            child: Observer(
              builder: (_) {
                return postStore.activityListGetter.length > 0
                    ? Container(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              child: CustomIcon(
                                icon: "post",
                                width: 22,
                              ),
                            ),
                            Container(
                              child: Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    postStore.activityListGetter.length.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 9),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : CustomIcon(
                        icon: "like",
                        width: 22,
                      );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => ProfileScreen(currentUserNickname),
              ));
            },
            child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(currentUserImage), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
