import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instaclone/stores/post_store.dart';
import 'package:instaclone/ui/comment_screen.dart';
import 'package:instaclone/ui/profile_screen.dart';
import 'package:instaclone/ui/widgets/custom_icon.dart';
import 'package:instaclone/ui/widgets/storie_avatar.dart';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  PostStore postStore = PostStore();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    postStore.buildTimeline();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(4),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      child: StorieAvatar(
                        nickname:
                        postStore.postSnapshot[index].postUserNickname,
                        image: postStore.postSnapshot[index].postUserImage,
                        borderSize: 2,
                        size: 38,
                        canPost: false,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => ProfileScreen(
                                        postStore.postSnapshot[index]
                                            .postUserNickname),
                                  ),
                                );
                              },
                              child: Text(
                                postStore
                                    .postSnapshot[index].postUserNickname,
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto'
                                ),
                              ),
                            ),
                            postStore.postSnapshot[index].postLocation != ""
                                ? Text(postStore
                                .postSnapshot[index].postLocation)
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 46,
                      child: FlatButton(
                        onPressed: () {},
                        child: CustomIcon(
                          icon: "more",
                          width: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                child: Image.network(postStore.postSnapshot[index].postImage),
              ),
              Container(
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        postStore.togglePostItemLike(index);
                      },
                      child: Container(
                          padding: EdgeInsets.all(10),
                          child: Observer(builder: (_) {
                            return postStore.postSnapshot[index].isLiked
                                ? CustomIcon(
                              icon: "like_red",
                              width: 22,
                            )
                                : CustomIcon(
                              icon: "like",
                              width: 22,
                            );
                          })),
                    ),
                    GestureDetector(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child:CustomIcon(
                            icon: "comment",
                            width: 22,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => CommentScreen(
                                postNickname: postStore
                                    .postSnapshot[index].postUserNickname,
                                postID: postStore.postSnapshot[index].postID,
                                postDescription: postStore
                                    .postSnapshot[index].postDescription,
                                postDate:postStore
                                    .postSnapshot[index].postDate,
                              ),
                            ),
                          );
                        }),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: CustomIcon(
                        icon: "message",
                        width: 23,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.centerRight,
                        child: CustomIcon(
                          icon: "fav",
                          width: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Observer(builder: (_) {
                return postStore.postSnapshot[index].totalLikes > 0
                    ? Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Curtido por ",
                        style: TextStyle(
                            fontSize: 13, color: Color(0xFF666666)),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          postStore.postSnapshot[index].randomLike,
                          style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF666666),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      postStore.postSnapshot[index].totalLikes > 1
                          ? Text(
                        " e ",
                        style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF666666)),
                      )
                          : Container(),
                      postStore.postSnapshot[index].totalLikes > 1
                          ? GestureDetector(
                        onTap: () {
                          print("Foi em Like List");
                        },
                        child: Text(
                          postStore.postSnapshot[index]
                              .totalLikes >
                              1
                              ? "outras ${postStore.postSnapshot[index].totalLikes - 1} pessoas"
                              : "outras pessoas",
                          style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF666666),
                              fontWeight: FontWeight.bold),
                        ),
                      )
                          : Container(),
                    ],
                  ),
                )
                    : Container();
              }),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text: postStore.postSnapshot[index].postUserNickname,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: " "),
                      TextSpan(
                          text:
                          postStore.postSnapshot[index].postDescription),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 6),
                child: postStore.postSnapshot[index].comments > 0
                    ? GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => CommentScreen(
                          postNickname: postStore
                              .postSnapshot[index].postUserNickname,
                          postID: postStore.postSnapshot[index].postID,
                          postDescription: postStore
                              .postSnapshot[index].postDescription,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Ver todos os ${postStore.postSnapshot[index].comments} comentários",
                      style: TextStyle(
                          fontSize: 13, color: Color(0xFF888888)),
                    ),
                  ),
                )
                    : null,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                width: double.infinity,
                child: Text(
                  postStore
                      .formatDateTime(postStore.postSnapshot[index].postDate),
                  style: TextStyle(fontSize: 13, color: Color(0xFF888888)),
                ),
              ),
            ],
          );
        },
        childCount: postStore.postSnapshot.length),
      );
    });
  }

  Widget customIcon(String assetURL, double size) {
    return Opacity(
      opacity: 0.65,
      child: SvgPicture.asset(assetURL, semanticsLabel: 'Acme Logo'),
    );
  }
}
