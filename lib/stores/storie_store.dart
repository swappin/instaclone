import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instaclone/main.dart';
import 'package:instaclone/models/storie.dart';
import 'package:instaclone/ui/home.dart';
import 'package:mobx/mobx.dart';

part 'storie_store.g.dart';

class StorieStore = _StorieStore with _$StorieStore;

abstract class _StorieStore with Store {
  ObservableList<Storie> storieList = ObservableList<Storie>();

  @observable
  bool hasStorie = true;

  @observable
  bool storieWatched = false;

  @observable
  bool storieActive = false;

  @action
  initStorieTimer(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 1)).whenComplete(() async {
      storieActive = !storieActive;
      Future.delayed(Duration(seconds: 8)).whenComplete(() {
        storieWatched = true;
        Navigator.pop(context);
      });
    });
  }

  ObservableList<String> followingList = ObservableList<String>();

  @action
  getFollowingStories() async {
    //Vai pegar a lista de usuários seguidos
    //Verificar quem dessa lista tem storie
    //Criar lista de stories ,

    await Firestore.instance
        .collection("users")
        .document(currentUserNickname)
        .collection("following")
        .getDocuments()
        .then((docs) {
      docs.documents.forEach((doc) {
        followingList.add(doc["followingNickname"]);
      });
      followingList.insert(0, currentUserNickname);
    });

    followingList.forEach((nickname) {
      getStories(nickname);
    });
  }

  @action
  getStories(String nickname) async {
    List<StorieItem> storieItemList = [];
    await Firestore.instance
        .collection("users")
        .document(nickname) //Parar aqui
        .collection("stories")
        .getDocuments()
        .then((stories) {
      if (stories.documents.length > 0) {
        hasStorie = true;
        stories.documents.forEach((storie) {
          DateTime dateTime = storie["storieDate"].toDate();
          storieItemList.add(StorieItem(
              storieImage: storie["storieImage"], storieDate: dateTime));
        });
        storieItemList.sort((a, b) => b.storieDate.compareTo(a.storieDate));
      } else
        hasStorie = false;
    });

    if (storieItemList.isNotEmpty) {
      await Firestore.instance
          .collection("users")
          .document(nickname)
          .get()
          .then(
        (user) {
          storieList.add(
            (Storie(
              storieUserNickname: nickname,
              storieUserImage: user["image"],
              storieWatched: false,
              storieItemList: storieItemList,
            )),
          );
        },
      );
    }

    if(storieList.first.storieUserNickname != currentUserNickname){


      storieList.insert(
        0,
        (Storie(
          storieUserNickname: currentUserNickname,
          storieUserImage: currentUserImage,
          storieWatched: false,
          storieItemList: [],
        )),
      );
    }

  }
}
