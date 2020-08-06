import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:instaclone/stores/activity_store.dart';
import 'package:instaclone/stores/post_store.dart';
import 'package:instaclone/ui/widgets/custom_icon.dart';
import 'package:instaclone/ui/widgets/navigation_bottom_bar.dart';
import 'package:instaclone/ui/widgets/storie_avatar.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  ActivityStore activityStore = ActivityStore();
  PostStore postStore = PostStore();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postStore.getActivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF3F4F5),
        elevation: 3,
        title: Text(
          "Atividade",
          style: TextStyle(color: Colors.black,
            fontSize: 16
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFE0E0E0),
                    width: 1,
                  ),
                ),
              ),
              padding: EdgeInsets.all(15),
              child: Row(
                children: <Widget>[
                  Text(
                    "Solicitações para seguir",
                    style: TextStyle(fontSize: 16),
                  ),
                  postStore.friendRequest.length != 0
                      ? Expanded(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 12),
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                Container(
                                  child: Text(
                                    postStore.friendRequest.length.toString(),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
            Expanded(child: Observer(builder: (_) {
              return ListView.builder(
                itemCount: postStore.activityListGetter.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 78,
                    child: Row(
                      children: <Widget>[
                        StorieAvatar(
                          nickname: postStore.activityListGetter[index].userNickname,
                          image: postStore.activityListGetter[index].userImage,
                          borderSize: 2.5,
                          size: 48,
                          canPost: false,
                        ),
                        Expanded(
                          child: Observer(
                            builder: (_) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 6),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(bottom: 5),
                                      width: double.infinity,
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: postStore
                                                  .activityListGetter[index]
                                                  .userNickname,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(text: " "),
                                            TextSpan(
                                                text:
                                                    postStore.activityListGetter[index].type == "like" ? " curtiu sua foto." : " comentou: ${postStore.activityListGetter[index].comment}"),
                                            TextSpan(
                                                text:
                                                    " ${postStore.formatDateTimeActivity(postStore.activityListGetter[index].date)}",
                                              style: TextStyle(
                                                color: Color(0xFF888888)
                                              )
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    postStore.activityListGetter[index].type != "like" ? Row(
                                      children: <Widget>[
                                        CustomIcon(
                                          icon: "like",
                                          width: 11,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 12),
                                          child: GestureDetector(
                                            onTap: () {
                                              print("Responder comentário.");
                                            },
                                            child: Text(
                                              "Responder",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xFF999999)
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ) : Container(),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(
                              postStore.activityListGetter[index].image,
                            ),),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            })),
          ],
        ),
      ),
    );
  }
}
