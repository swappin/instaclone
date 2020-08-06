import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:instaclone/main.dart';
import 'package:instaclone/stores/counter.dart';
import 'package:instaclone/stores/post_store.dart';
import 'package:instaclone/stores/user_store.dart';
import 'package:instaclone/ui/activity_screen.dart';
import 'package:instaclone/ui/camera_screen.dart';
import 'package:instaclone/ui/chat_screen.dart';
import 'package:instaclone/ui/profile_screen.dart';
import 'package:instaclone/ui/search_screen.dart';
import 'package:instaclone/ui/storie_screen.dart';
import 'package:instaclone/ui/widgets/custom_icon.dart';
import 'package:instaclone/ui/widgets/navigation_bottom_bar.dart';
import 'package:instaclone/ui/widgets/post-list.dart';
import 'package:instaclone/ui/widgets/storie_list.dart';

class Home extends StatefulWidget {
  final int currentIndex;

  Home({this.currentIndex});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controller = TextEditingController();
  Counter counter = Counter();
  String userName;
  UserStore userStore = UserStore();
  PostStore postStore = PostStore();
  static List<CameraDescription> cameras;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  Future<void> initCamera() async {
    cameras = await availableCameras();
  }

  @override
  void initState() {
    super.initState();
    initCamera().then(
      (onInitialize) => print("Cameras was initialized"),
    );
    widget.currentIndex != null
        ? userStore.onItemTapped(widget.currentIndex)
        : userStore.onItemTapped(0);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    postStore.getActivity();
  }

  @override
  void dispose() {
    super.dispose();
    initCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Scaffold(
        key: _drawerKey,
        appBar: userStore.selectedIndex == 0
            ? PreferredSize(
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
                              _drawerKey.currentState.openDrawer();
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
        ) : PreferredSize(child: Container(), preferredSize: Size.fromHeight(0)),
        body: userStore.selectedIndex == 0
            ? CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: StorieList(),
                  ),
                  PostList(),
                ],
              )
            : _widgetOptions.elementAt(userStore.selectedIndex),
        bottomNavigationBar: userStore.selectedIndex != 2 ? BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: userStore.selectedIndex == 0
                  ? CustomIcon(
                icon: "home_bold",
                width: 22,
              )
                  : CustomIcon(
                icon: "home",
                width: 22,
              ),
              title: Container(),
            ),
            BottomNavigationBarItem(
              icon: userStore.selectedIndex == 1
                  ? CustomIcon(
                icon: "search_bold",
                width: 22,
              )
                  : CustomIcon(
                icon: "search",
                width: 22,
              ),
              title: Container(),
            ),
            BottomNavigationBarItem(
              icon: userStore.selectedIndex == 2
                  ? CustomIcon(
                icon: "post_bold",
                width: 22,
              )
                  : CustomIcon(
                icon: "post",
                width: 22,
              ),
              title: Container(),
            ),
            BottomNavigationBarItem(
              icon: userStore.selectedIndex == 3
                  ? CustomIcon(
                icon: "like_bold",
                width: 22,
              )
                  : postStore.activityListGetter.length > 0
                  ? CustomIcon(
                icon: "activity",
                width: 22,
              )
                  : CustomIcon(
                icon: "like",
                width: 22,
              ),
              title: Container(
                height: 0,
              ),
            ),
            BottomNavigationBarItem(
              icon: Observer(builder: (_) {
                return userStore.selectedIndex == 4
                    ? Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Container(
                    height: 27,
                    width: 27,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(currentUserImage),
                          fit: BoxFit.cover),
                      color: Colors.grey,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                )
                    : Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(currentUserImage),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(50),
                  ),
                );
              }),
              title: Container(),
            ),
          ],
          currentIndex: userStore.selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: userStore.onItemTapped,
        ) : null,
        drawer: StorieScreen(
          cameras: cameras,
        ),
      );
    });
  }

  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    SearchScreen(),
    CameraScreen(cameras),
    ActivityScreen(),
    ProfileScreen(
      currentUserNickname,
    ),
  ];
}
