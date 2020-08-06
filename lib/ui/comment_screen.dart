import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:instaclone/main.dart';
import 'package:instaclone/stores/comment_store.dart';
import 'package:instaclone/stores/post_store.dart';
import 'package:instaclone/ui/home.dart';
import 'package:instaclone/ui/widgets/avatar_image.dart';
import 'package:instaclone/ui/widgets/custom_appbar.dart';
import 'package:instaclone/ui/widgets/custom_icon.dart';

class CommentScreen extends StatefulWidget {
  final String postNickname;
  final String postID;
  final String postDescription;
  final DateTime postDate;

  CommentScreen(
      {this.postNickname, this.postID, this.postDescription, this.postDate});

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  PostStore postStore = PostStore();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postStore.getCommentList(widget.postNickname, widget.postID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
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
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 8),
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 22,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Comentários",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
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
          preferredSize: Size.fromHeight(50)),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AvatarImage(image: currentUserImage),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 7),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: currentUserNickname,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(text: " "),
                                TextSpan(text: widget.postDescription),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            postStore.formatDateTimeActivity(widget.postDate),
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
              Divider(),
              Expanded(child: Observer(
                builder: (_) {
                  return ListView.builder(
                    itemCount: postStore.commentList.value.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          Observer(
                            builder: (_) {
                              print(
                                  "VAI VENDO 3 ${postStore.commentFromFirestore[index].image}");
                              return Container(
                                padding: EdgeInsets.all(12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    AvatarImage(
                                      image: postStore
                                          .commentFromFirestore[index].image,
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(bottom: 7),
                                            width: double.infinity,
                                            child: RichText(
                                              text: TextSpan(
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: postStore
                                                        .commentFromFirestore[
                                                            index]
                                                        .nickname,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  TextSpan(text: " "),
                                                  TextSpan(
                                                    text: postStore
                                                        .commentFromFirestore[
                                                            index]
                                                        .content,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                postStore.formatDateTimeActivity(
                                                    postStore
                                                        .commentFromFirestore[
                                                            index]
                                                        .date),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                              postStore.userCommentLikeList[
                                                          index] >
                                                      0
                                                  ? postStore.userCommentLikeList[
                                                              index] ==
                                                          1
                                                      ? Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 14),
                                                          child: Text(
                                                            "${postStore.userCommentLikeList[index]} curtida",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        )
                                                      : Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 14),
                                                          child: Text(
                                                            "${postStore.userCommentLikeList[index]} curtidas",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        )
                                                  : Container(),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 14),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    print(
                                                        "Responder comentário.");
                                                  },
                                                  child: Text(
                                                    "Responder",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: CustomIcon(
                                        icon: "like",
                                        width: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          Divider(),
                        ],
                      );
                    },
                  );
                },
              )),
              Divider(
                color: Colors.grey,
                height: 0.5,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              postStore.setComment(controller.text + "🤣️");
                              controller.text = controller.text + "🤣";
                            },
                            child: Text(
                              "🤣",
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              postStore.setComment(controller.text + "😂️");
                              controller.text = controller.text + "😂";
                            },
                            child: Text(
                              "😂",
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              postStore.setComment(controller.text + "✊️");
                              controller.text = controller.text + "✊";
                            },
                            child: Text(
                              "✊",
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              postStore.setComment(controller.text + "❤️");
                              controller.text = controller.text + "❤️";
                            },
                            child: Text(
                              "❤️",
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              postStore.setComment(controller.text + "🚀️");
                              controller.text = controller.text + "🚀";
                            },
                            child: Text(
                              "🚀",
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              postStore.setComment(controller.text + "👏️");
                              controller.text = controller.text + "👏";
                            },
                            child: Text(
                              "👏",
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              postStore.setComment(controller.text + "💸️");
                              controller.text = controller.text + "💸";
                            },
                            child: Text(
                              "💸",
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              postStore.setComment(controller.text + "🖕️");
                              controller.text = controller.text + "🖕";
                            },
                            child: Text(
                              "🖕",
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          AvatarImage(
                            image: currentUserImage,
                          ),
                          Expanded(
                            child: Observer(
                              builder: (_) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: Color(0xFFCCCCCC))),
                                    child: TextFormField(
                                      onChanged: postStore.setComment,
                                      controller: controller,
                                      decoration: InputDecoration(
                                        hintText: "Adicione um comentário",
                                        hintStyle: TextStyle(
                                          fontSize: 14,
                                        ),
                                        border: InputBorder.none,
                                        suffixIcon: FlatButton(
                                          onPressed: () {
                                            if (postStore.isCommentFormValid) {
                                              postStore.setPostComment(
                                                  widget.postNickname,
                                                  widget.postID);
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback(
                                                (_) => controller.clear(),
                                              );
                                            }
                                          },
                                          child: Container(
                                            width: postStore.isCommentFormValid ? 70 : 0,
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              "Publicar",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: postStore
                                                          .isCommentFormValid
                                                      ? Colors.blue
                                                      : Colors.white),
                                            ),
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 16, horizontal: 15),
                                      ),
                                    ),
                                  ),
                                );
                              },
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
    );
  }
}
