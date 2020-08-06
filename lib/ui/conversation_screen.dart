import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:instaclone/main.dart';
import 'package:instaclone/stores/chat_store.dart';
import 'package:instaclone/stores/post_store.dart';
import 'package:instaclone/ui/widgets/custom_icon.dart';
import 'package:instaclone/ui/widgets/storie_avatar.dart';

class ConversationScreen extends StatefulWidget {
  final String userNickname;
  final String userImage;

  ConversationScreen(this.userNickname, this.userImage);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  PostStore postStore = PostStore();
  ChatStore chatStore = ChatStore();
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = new ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    chatStore.getChatMessages(widget.userNickname);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: SafeArea(
          child: Container(
            child: Row(
              children: <Widget>[
                GestureDetector(
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
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        print("Clicou no Profile do Usuário");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          StorieAvatar(
                            nickname: widget.userNickname,
                            image: widget.userImage,
                            size: 36,
                            borderSize: 2,
                            canPost: false,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  widget.userNickname,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "Online há ${DateTime.now().minute}m",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
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
                    print("Clicou para ver informação do usuário");
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: CustomIcon(
                      icon: "files",
                      width: 23,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Observer(
                  builder: (_) {
                    return ListView.builder(
                      controller: _scrollController,
                      reverse: true,
                      shrinkWrap: true,
                      itemCount: chatStore.messageListGetter.length,
                      itemBuilder: (BuildContext context, int index) {
                        return chatStore
                                    .messageListGetter[index].messageNickname ==
                                currentUserNickname
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFE4E4E2),
                                      borderRadius: BorderRadius.circular(28),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x22444444),
                                          blurRadius: 7,
                                          // has the effect of softening the shadow
                                          spreadRadius: 0,
                                          // has the effect of extending the shadow
                                          offset: Offset(
                                            0, // horizontal, move right 10
                                            1, // vertical, move down 10
                                          ),
                                        ),
                                      ],
                                    ),
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.75),
                                    child: Text(
                                      chatStore.messageListGetter[index]
                                          .messageContent,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFFFFFF),
                                      borderRadius: BorderRadius.circular(28),
                                      border: Border.all(
                                          color: Color(0x556666666), width: 1),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x11444444),
                                          blurRadius: 5,
                                          // has the effect of softening the shadow
                                          spreadRadius: 0,
                                          // has the effect of extending the shadow
                                          offset: Offset(
                                            0, // horizontal, move right 10
                                            1, // vertical, move down 10
                                          ),
                                        ),
                                      ],
                                    ),
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.75),
                                    child: Text(
                                      chatStore.messageListGetter[index]
                                          .messageContent,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              );
                      },
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              height: 80,
              child: SafeArea(
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 50,
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
                                  print(
                                      "Clicou pra enviar uma foto no Suffix");
                                },
                                child: Container(
                                  width: 42,
                                  height: 42,
                                  margin: EdgeInsets.all(4),
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(48),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.lightBlueAccent,
                                        Colors.blueAccent
                                      ],
                                      stops: [0.1, 0.9],
                                    ),
                                  ),
                                  child: Container(
                                    child: CustomIcon(
                                      icon: "camera_bold",
                                    ),
                                  ),
                                ),
                              ),
                              hintText: "Mensagem",
                              suffixIcon: chatStore.isFormValid
                                  ? GestureDetector(
                                      onTap: () {
                                        chatStore.addMessage(
                                            widget.userNickname,
                                            currentUserImage);
                                        WidgetsBinding.instance
                                            .addPostFrameCallback(
                                          (_) => _controller.clear(),
                                        );
                                        //_scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                                        _focusNode.unfocus();
                                      },
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        width: 122,
                                        padding: EdgeInsets.only(right: 14),
                                        child: Text(
                                          "Enviar",
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: 122,
                                      padding: EdgeInsets.only(right: 12),
                                      child: Row(
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {
                                              print(
                                                  "Clicou n o Microfone do Chat");
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 6),
                                              child: CustomIcon(
                                                icon: "microphone",
                                                width: 24,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              print(
                                                  "Clicou pra enviar uma image");
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 6),
                                              child: CustomIcon(
                                                icon: "post",
                                                width: 22,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              print(
                                                  "Clicou n o em GIF com formInvalid");
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 6),
                                              child: CustomIcon(
                                                icon: "fav",
                                                width: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                              border: InputBorder.none,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
