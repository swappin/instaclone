import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instaclone/main.dart';
import 'package:instaclone/models/chat.dart';
import 'package:instaclone/models/message.dart';
import 'package:mobx/mobx.dart';

part 'chat_store.g.dart';

class ChatStore = _ChatStore with _$ChatStore;

abstract class _ChatStore with Store {
  _ChatStore() {
    autorun((_) {});
  }

  CollectionReference userCollection = Firestore.instance.collection("users");
  @observable
  String message = "";

  @computed
  bool get isCommentFormValid => message.length > 0;

  @observable
  ObservableList<Chat> _chatList = ObservableList<Chat>();

  @computed
  List<Chat> get chatListGetter => _chatList;

  @observable
  ObservableList<Message> _messageList = ObservableList<Message>();

  @computed
  List<Message> get messageListGetter => _messageList;

  @action
  void setMessage(String value) => message = value;

  @action
  buildChatList() {
    CollectionReference chatCollection =
        userCollection.document(currentUserNickname).collection("chats");
    chatCollection.getDocuments().then((chats) {
      chats.documents.forEach((chat) async {
        String chatNickname = await chat.reference
            .collection("messages")
            .getDocuments()
            .then((message) {
          return message.documents.last.data["messageNickname"];
        });
        String chatImage = await userCollection
            .where("nickname", isEqualTo: chatNickname)
            .getDocuments()
            .then((user) {
          return user.documents[0].data["image"];
        });
        String chatLastMessage = await chat.reference
            .collection("messages")
            .getDocuments()
            .then((message) {
          return message.documents.last.data["messageContent"];
        });
        DateTime chatLastSeen = chat.data["lastSeen"].toDate();
        _chatList.add(Chat(chatNickname, chatImage,
            chatLastMessage, chatLastSeen));
      });
    });
  }

  @action
  addMessage(String targetUserNickname, String userImage) async {
    userCollection
        .document(targetUserNickname)
        .collection("chats").document(currentUserNickname).setData({
      "lastSeen": DateTime.now(),
    }).whenComplete(() {
      userCollection
          .document(targetUserNickname)
          .collection("chats")
          .document(currentUserNickname)
          .collection("messages")
          .document()
          .setData({
        "messageNickname": currentUserNickname,
        "messageContent": message,
        "messageDate": DateTime.now(),
      });
    }).whenComplete((){
      userCollection
          .document(currentUserNickname)
          .collection("chats").document(targetUserNickname).setData({
        "lastSeen": DateTime.now(),
      }).whenComplete(() {
        userCollection
            .document(currentUserNickname)
            .collection("chats")
            .document(targetUserNickname)
            .collection("messages")
            .document()
            .setData({
          "messageNickname": currentUserNickname,
          "messageContent": message,
          "messageDate": DateTime.now(),
        });
      });
    });
  }

  @action
  getChatMessages(String userNickname) {
    CollectionReference chatCollection =
    userCollection.document(currentUserNickname).collection("chats");
    chatCollection
        .document(userNickname)
        .collection("messages")
        .snapshots()
        .listen((messages) {
      _messageList.clear();
      messages.documents.forEach((message) {
        DateTime dateTime = message.data["messageDate"].toDate();
        _messageList.insert(
            0,
            Message(
              message.data["messageNickname"],
              message.data["messageContent"],
              dateTime,
            ));
        _messageList.sort((a, b) => b.messageDate.compareTo(a.messageDate));
      });
    });
  }

  @computed
  bool get isFormValid => message.isNotEmpty;
}
