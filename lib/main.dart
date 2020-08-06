import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instaclone/stores/user_store.dart';
import 'package:instaclone/ui/home.dart';

String currentUserNickname;
String currentUserImage;

Future<void> main() async {WidgetsFlutterBinding.ensureInitialized();
  String email = "andre@andre.com";
  await Firestore.instance.collection("users").getDocuments().then((docs) {
    docs.documents.forEach((data) {
      if(email == data.data["email"]) {
        currentUserNickname = data.data["nickname"];
        currentUserImage = data.data["image"];
      } else print("Error.");
    });
  });
  UserStore userStore = UserStore();
  //userStore.registerUser();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      theme: ThemeData(
//        primaryColor: Colors.deepPurpleAccent,
//        cursorColor: Colors.deepPurpleAccent,
//        scaffoldBackgroundColor: Colors.deepPurpleAccent,
//      ),
      home: Home(),
    );
  }
}
