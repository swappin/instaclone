import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instaclone/main.dart';
import 'package:instaclone/models/profile.dart';
import 'package:mobx/mobx.dart';
import 'package:diacritic/diacritic.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  _UserStore() {
    autorun((_) {});
  }

  //https://instagram.fsjk1-1.fna.fbcdn.net/v/t51.2885-19/s320x320/83886793_163342818412705_5846387278057832448_n.jpg?_nc_ht=instagram.fsjk1-1.fna.fbcdn.net&_nc_ohc=u-P3QxPyNZYAX9ar7w8&oh=b1769fa28bc48a4f6c9be540d94b363e&oe=5EB97457

  String email = "andre@andre.com";
  String name = "André Jr.";
  String nickname = "andrejvnior";
  String image =
"https://instagram.fgru6-1.fna.fbcdn.net/v/t51.2885-19/s320x320/92962920_263846964634123_7299091035999698944_n.jpg?_nc_ht=instagram.fgru6-1.fna.fbcdn.net&_nc_ohc=WpgU8Frr5voAX-qsEbC&oh=6942b75935f29554e08a9aff1b6c23a3&oe=5EE75DB4";
  DateTime birthday = DateTime.now();
  String bio = "Coder. Founder. Dreamer.";
  String phone = "1199000-0000";
  String genre = "Masculino";
  String website = "swappin.io";

  static Firestore firestore = Firestore.instance;
  CollectionReference userColletion = firestore.collection('users');

  @observable
  String search;

  @observable
  ObservableList<Profile> _userList = ObservableList<Profile>();

  @computed
  List<Profile> get userListGetter => _userList;

  @action
  void setSearch(value) => search = value;

  @observable
  bool hasUser = false;

  @action
  registerUser() {
    String nickname = removeDiacritics(name
        .replaceAll(RegExp(r"\s+\b|\b\s"), "")
        .replaceAll(".", "")
        .toLowerCase());
    userColletion.getDocuments().then((data) {
      data.documents.forEach((docs) async {
        if (docs['nickname'] == nickname) {
          var randomNumber = new Random();
          nickname = nickname + randomNumber.nextInt(1000).toString();
        }
      });
    }).then(
      (onVerification) => userColletion.document(this.nickname).setData(
        {
          'email': this.email,
          'nickname': this.nickname,
          'name': this.name,
          'image': this.image,
          'birthday': this.birthday,
          'bio': this.bio,
          'phone': this.phone,
          'genre': this.genre,
          'website': this.website,
          'isPrivate': false,
          'isProfessional': false,
          'isVerified': true,
          'saveInfo': false,
          'registrationDate': DateTime.now(),
        },
      ),
    );
  }

  @action
  buildUserList() {
    Firestore.instance.collectionGroup("users").getDocuments().then((users) {
      users.documents.forEach((user) {
        _userList.add(Profile(
          name: user["name"],
          nickname: user["nickname"],
          image: user["image"],
        ));
      });
    });
  }

  @action
  searchUser() {
    _userList.forEach((user) {
      if (user.nickname.contains(search)) {
        hasUser = true;
      } else
        hasUser = false;
    });
  }

//  @action
//  searchUser(){
//    _userList.clear();
//    Firestore.instance.collectionGroup("users").getDocuments().then((users){
//      String userName;
//      users.documents.forEach((user){
//        userName = user["nickname"];
//      });
//
//      print("se liga v $userName");
//      if(userName.contains(search)){
//        hasUser = true;
//        _userList.add(Profile(
//          nickname: userName,
//          image: currentUserImage,
//        ));
//
//
//        print("ah maluco se liga v ${_userList.length}");
//      } else hasUser = false;
//    });
//  }


  @observable
  int selectedIndex;

  @action
  void onItemTapped(int index){
    selectedIndex = index;
  }
}
