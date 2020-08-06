import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:instaclone/main.dart';
import 'package:instaclone/stores/chat_store.dart';
import 'package:instaclone/stores/post_store.dart';
import 'package:instaclone/ui/conversation_screen.dart';
import 'package:instaclone/ui/widgets/custom_icon.dart';
import 'package:instaclone/ui/widgets/slide_item.dart';
import 'package:instaclone/ui/widgets/storie_avatar.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  PostStore postStore = PostStore();
  ChatStore chatStore = ChatStore();
  TextEditingController controller = TextEditingController();
  String filter;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    chatStore.buildChatList();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Color(0xFFF3F4F5),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
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
        title: Container(
          padding: EdgeInsets.only(left: 4),
          child: GestureDetector(
              onTap: () {
                print("Clicou no nickname para trocar de conta");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      currentUserNickname,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 2),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ],
              )),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              print("Clicou em começar um bate-papo de vídeo");
            },
            child: Container(
              child: CustomIcon(
                icon: "camera",
                width: 24,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              print("Clicou em compor uma nova mensagem");
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: CustomIcon(
                icon: "message",
                width: 24,
              ),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(12, 12, 12, 6),
              height: 56,
              child: Observer(
                builder: (_) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFFE5E5E4)),
                    child: TextFormField(
                      onChanged: postStore.setSearch,
                      controller: controller,
                      decoration: InputDecoration(
                        icon: Container(
                          padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
                          child: CustomIcon(
                            icon: "search_bold",
                            width: 13,
                            height: 13,
                          ),
                        ),
                        hintText: "Pesquisar",
                        hintStyle: TextStyle(color: Color(0xFF777777)),
                        border: InputBorder.none,
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(child: Observer(builder: (_) {
              return Scrollbar(
                child: ListView.builder(
                  itemCount: chatStore.chatListGetter.length,
                  itemBuilder: (BuildContext context, int index) {
                    return filter == null || filter == ""
                        ? SlideItem(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ConversationScreen(
                                        chatStore
                                            .chatListGetter[index].chatNickname,
                                        chatStore
                                            .chatListGetter[index].chatImage),
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                height: 78,
                                child: Row(
                                  children: <Widget>[
                                    StorieAvatar(
                                      nickname: chatStore
                                          .chatListGetter[index].chatNickname,
                                      image: chatStore
                                          .chatListGetter[index].chatImage,
                                      size: 50,
                                      borderSize: 3,
                                      canPost: false,
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              chatStore.chatListGetter[index]
                                                  .chatNickname,
                                              style: TextStyle(
                                                fontWeight: !postStore
                                                        .userChatWatched[index]
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                chatStore
                                                    .chatListGetter[index]
                                                    .chatLastMessage,
                                                overflow:
                                                TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontWeight: !postStore
                                                      .userChatWatched[
                                                  index]
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                                  color: Color(0xFF666666),
                                                ),
                                              ),
                                                Text(
                                                  " • ",
                                                  style: TextStyle(
                                                    fontSize: 8,
                                                    color: Color(0xFF666666),
                                                  ),
                                                ),
                                                Text(
                                                  postStore.formatDateTimeActivity(chatStore.chatListGetter[index].chatLastSeen),
                                                  style: TextStyle(
                                                    color: Color(0xFF666666),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    !postStore.userChatWatched[index]
                                        ? Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 15),
                                            width: 8,
                                            height: 8,
                                            decoration: BoxDecoration(
                                                color: Colors.blueAccent,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                          )
                                        : Container(),
                                    Container(
                                        child: CustomIcon(
                                      icon: "camera",
                                      width: 23,
                                    ))
                                  ],
                                ),
                              ),
                            ),
                            menuItems: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  print("Clicou para silenciar!");
                                },
                                child: Container(
                                  color: Color(0xFFDDDDDD),
                                  alignment: Alignment.center,
                                  width: 100,
                                  child: Text(
                                    "Silenciar",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print("Clicou para excluir!");
                                },
                                child: Container(
                                  color: Colors.redAccent,
                                  alignment: Alignment.center,
                                  width: 100,
                                  child: Text(
                                    "Excluir",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : chatStore
                        .chatListGetter[index].chatNickname.contains(filter)
                            ? Container(
                                padding: EdgeInsets.all(10),
                                height: 100,
                                child: Row(
                                  children: <Widget>[
                                    StorieAvatar(
                                      nickname: chatStore
                                          .chatListGetter[index].chatNickname,
                                      image: chatStore
                                          .chatListGetter[index].chatImage,
                                      canPost: false,
                                      size: 56,
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              chatStore.chatListGetter[index]
                                                  .chatNickname,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Text(
                                                    chatStore
                                                        .chatListGetter[index]
                                                        .chatLastMessage,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Color(0xFF666666),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    !postStore.userChatWatched[index]
                                        ? Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 12),
                                            width: 8,
                                            height: 8,
                                            decoration: BoxDecoration(
                                                color: Colors.blueAccent,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                          )
                                        : Container(),
                                  ],
                                ),
                              )
                            : Container();
                  },
                ),
              );
            })),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(8),
        width: double.infinity,
        height: 60,
        color: Color(0xFFF2F2F2),
        child: GestureDetector(
          onTap: () {
            print("Clicou na Camera do Chat");
          },
          onLongPress: () {
            print("Segurou aa Camera do Chat");
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 24,
                child: ShaderMask(
                    blendMode: BlendMode.srcATop,
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                          colors: [Colors.blueAccent, Colors.black],
                          stops: [0.1, 0.8]).createShader(bounds);
                    },
                    child: CustomIcon(
                      icon: "camera_change",
                      width: 24,
                    )),
              ),
              Container(
                width: 10,
                height: 0,
              ),
              Text(
                "Câmera",
                style: TextStyle(
                  color: Colors.blueAccent,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
