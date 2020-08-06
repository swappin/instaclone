import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:instaclone/models/storie.dart';
import 'package:instaclone/stores/chat_store.dart';
import 'package:instaclone/stores/post_store.dart';
import 'package:instaclone/stores/storie_store.dart';
import 'package:instaclone/stores/user_store.dart';
import 'package:instaclone/ui/home.dart';
import 'package:instaclone/ui/profile_screen.dart';
import 'package:instaclone/ui/widgets/swiper.dart';

class StorieWatchScreen extends StatefulWidget {
  final String storieUserNickname;
  final String storieUserImage;
  final List<Storie> storieList;

  StorieWatchScreen(this.storieList, this.storieUserNickname, this.storieUserImage);

  @override
  _StorieWatchScreenState createState() => _StorieWatchScreenState();
}

class _StorieWatchScreenState extends State<StorieWatchScreen> {
  PostStore postStore = PostStore();
  UserStore userStore = UserStore();
  ChatStore chatStore = ChatStore();
  StorieStore storieStore = StorieStore();
  TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    storieStore.initStorieTimer(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.storieList.length,
                itemBuilder: (context, index) {
                  return SwipeDetector(
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Image.network(
                            widget.storieList[index].storieItemList[0].storieImage,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                    onSwipeLeft: () {
                      index--;
                      if (index > 0) {}
                    },
                    onSwipeRight: () {},
                    swipeConfiguration: SwipeConfiguration(
                        verticalSwipeMinVelocity: 100.0,
                        verticalSwipeMinDisplacement: 50.0,
                        verticalSwipeMaxWidthThreshold: 100.0,
                        horizontalSwipeMaxHeightThreshold: 50.0,
                        horizontalSwipeMinDisplacement: 50.0,
                        horizontalSwipeMinVelocity: 100.0),
                  );
                },
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: <Widget>[
                    Container(
                        height: 23,
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Stack(
                          children: <Widget>[
                            Opacity(
                              opacity: 0.5,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 6,
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                            Observer(builder: (_) {
                              return AnimatedContainer(
                                width: storieStore.storieActive
                                    ? MediaQuery.of(context).size.width
                                    : 0,
                                height: 6,
                                padding: EdgeInsets.all(2),
                                duration: Duration(seconds: 10),
                                curve: Curves.fastOutSlowIn,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                              );
                            }),
                          ],
                        )),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  userStore.onItemTapped(4);
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => Home(currentIndex: 4,),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              widget.storieUserImage),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 5),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.storieUserNickname,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0, 0),
                                              blurRadius: 10,
                                              color:
                                                  Color.fromARGB(100, 0, 0, 0),
                                            ),
                                            Shadow(
                                              offset: Offset(0, 0),
                                              blurRadius: 10,
                                              color: Color.fromARGB(
                                                  100, 0, 0, 255),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 5),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  postStore.formatDateTimeActivity(
                                      widget.storieList[0].storieItemList[0].storieDate),
                                  style: TextStyle(
                                    color: Color(0xFFEEEEEE),
                                    shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(0, 0),
                                        blurRadius: 10,
                                        color: Color.fromARGB(100, 0, 0, 0),
                                      ),
                                      Shadow(
                                        offset: Offset(0, 0),
                                        blurRadius: 10,
                                        color: Color.fromARGB(100, 0, 0, 255),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 40,
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        width: double.infinity,
        height: 80,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: SizedBox(
                height: 48,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: Color(0xFFCCCCCC),
                      )),
                  child: Observer(
                    builder: (_) {
                      return TextFormField(
                        focusNode: _focusNode,
                        controller: _controller,
                        onChanged: chatStore.setMessage,
                        onFieldSubmitted: (value) {},
                        decoration: InputDecoration(
                          prefixIcon: GestureDetector(
                            onTap: () {
                              print("Clicou pra enviar uma foto no Suffix.");
                            },
                            child: Container(
                              width: 40,
                              height: 32,
                              margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(48),
                                color: Color(0xFF555555),
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          hintText: "Enviar mensagem",
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 110,
                height: 44,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(left: 4),
                        child: Icon(
                          Icons.airplanemode_active,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(left: 4),
                        child: Icon(
                          Icons.more_horiz,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
