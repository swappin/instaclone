import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:instaclone/main.dart';
import 'package:instaclone/models/activity.dart';
import 'package:instaclone/models/comment.dart';
import 'package:instaclone/stores/comment_store.dart';
import 'package:instaclone/stores/like_store.dart';
import 'package:instaclone/stores/post_item_store.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instaclone/stores/user_store.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:translator/translator.dart';
import 'package:url_launcher/url_launcher.dart';

part 'post_store.g.dart';

class PostStore = _PostStore with _$PostStore;

const String kTestString = 'Hello world!';

abstract class _PostStore with Store {
  LikeStore likeStore = LikeStore();
  CommentStore commentStore = CommentStore();

  _PostStore() {
    autorun((_) {
      print(postDescription);
    });
  }

  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://instaclone-bea12.appspot.com');

  CollectionReference postCollection = UserStore()
      .userColletion
      .document(currentUserNickname)
      .collection('posts');

  @observable
  String postDescription = "";

  @observable
  String postLocation = "";

  @observable
  bool isPrivate = false;

  @observable
  String search;

  @observable
  bool favorite = false;

  @observable
  bool shareOnFacebook = false;

  @observable
  bool shareOnTwitter = false;

  @observable
  bool shareOnTumblr = false;

  @observable
  FocusNode focus = FocusNode();

  @observable
  bool hasFocus = false;

  @action
  void setSearch(value) => search = value;

  @action
  void toggleFavorite() => favorite = !favorite;

  @action
  void toggleShareOnFacebook() => shareOnFacebook = !shareOnFacebook;

  @action
  void toggleShareOnTwitter() => shareOnTwitter = !shareOnTwitter;

  @action
  void toggleShareOnTumblr() => shareOnTumblr = !shareOnTumblr;

  @action
  setPostDescription(value) => postDescription = value;

  @action
  setPostLocation(value) => postLocation = value;

  @action
  setFocus(value) => hasFocus = value;

  @action
  setUnfocusNode() => focus.unfocus();

  ObservableList<PostItemStore> postSnapshot = ObservableList();

  List<StorageUploadTask> _tasks = <StorageUploadTask>[];

  @action
  Future<Stream<DocumentSnapshot>> buildTimeline() async {
    var _firestore = Firestore.instance.collection("users");
    List<String> followingList = [];
    followingList.add(currentUserNickname);
    await _firestore
        .document(currentUserNickname)
        .collection("following")
        .getDocuments()
        .then((followingDocs) {
      followingDocs.documents.forEach((following) {
        followingList.add(following["followingNickname"]);
      });
      //Juntar essa função com a função do profile
      followingList.forEach((nickname) async {
        await Firestore.instance
            .collectionGroup("posts")
            .where("postUserNickname", isEqualTo: nickname)
            .getDocuments()
            .then((posts) {
          posts.documents.forEach((postDoc) async {
            String randomLike;
            var likes = await postDoc.reference
                .collection("likes")
                .getDocuments()
                .then((like) {
              like.documents.forEach((random) async {
                randomLike = random["likeNickname"];
              });
              return like.documents.length;
            });
            var comments = await postDoc.reference
                .collection("comments")
                .getDocuments()
                .then((comment) {
              return comment.documents.length;
            });
            List<String> likedPostList = [];
            await _firestore
                .document(currentUserNickname)
                .collection("liked")
                .getDocuments()
                .then(
              (docs) {
                docs.documents.forEach((data) {
                  likedPostList.add(data.data["postID"]);
                });
              },
            );
            DateTime dateTime = postDoc.data["postDate"].toDate();
            postSnapshot.add(
              PostItemStore(
                  postDoc["postID"],
                  postDoc["postUserNickname"],
                  postDoc["postUserImage"],
                  postDoc["postImage"],
                  postDoc["postDescription"],
                  postDoc["postLocation"],
                  dateTime,
                  isLiked:
                      likedPostList.contains(postDoc["postID"]) ? true : false,
                  totalLikes: likes != null ? likes : 0,
                  comments: comments != null ? comments : 0,
                  randomLike: likes != null ? randomLike : ""),
            );
            postSnapshot.sort((a, b) => b.postDate.compareTo(a.postDate));
            print(
                "Posts criados com sucesso - ${postDoc["postUserNickname"]}: ${postSnapshot.length}");
          });
        }).whenComplete(() {
          print("Posts criados com sucesso: ${postSnapshot.length}");
        });
      });
    }).catchError((error) => print("Instaclone Error: $error"));
  }

  @action
  String formatDateTime(DateTime datetime) {
    if (DateTime.now().difference(datetime).inMinutes < 1) {
      return "Há ${DateTime.now().difference(datetime).inSeconds} segundos";
    } else if (DateTime.now().difference(datetime).inMinutes == 1) {
      return "Há ${DateTime.now().difference(datetime).inMinutes} minuto";
    } else if (DateTime.now().difference(datetime).inMinutes > 1 &&
        DateTime.now().difference(datetime).inMinutes < 60) {
      return "Há ${DateTime.now().difference(datetime).inMinutes} minutos";
    } else if (DateTime.now().difference(datetime).inMinutes >= 59 &&
        DateTime.now().difference(datetime).inMinutes < 119) {
      return "Há ${DateTime.now().difference(datetime).inHours} hora";
    } else if (DateTime.now().difference(datetime).inMinutes >= 120 &&
        DateTime.now().difference(datetime).inMinutes < 1439) {
      return "Há ${DateTime.now().difference(datetime).inHours} horas";
    } else if (DateTime.now().difference(datetime).inMinutes >= 1440 &&
        DateTime.now().difference(datetime).inMinutes < 2879) {
      return "Há ${DateTime.now().difference(datetime).inDays} dia";
    } else if (DateTime.now().difference(datetime).inMinutes >= 2880 &&
        DateTime.now().difference(datetime).inMinutes < 10079) {
      return "Há ${DateTime.now().difference(datetime).inDays} dias";
    } else if (DateTime.now().difference(datetime).inMinutes >= 10080 &&
        DateTime.now().difference(datetime).inMinutes < 40319) {
      return "Há ${(DateTime.now().difference(datetime).inDays / 4).floor()} semanas";
    } else {
      return "${DateFormat.yMMMMd("pt_BR").format(datetime)}";
    }
  }

  @action
  String formatDateTimeActivity(DateTime datetime) {
    if (DateTime.now().difference(datetime).inMinutes < 1) {
      return "${DateTime.now().difference(datetime).inSeconds}s";
    } else if (DateTime.now().difference(datetime).inMinutes == 1) {
      return "${DateTime.now().difference(datetime).inMinutes}m";
    } else if (DateTime.now().difference(datetime).inMinutes > 1 &&
        DateTime.now().difference(datetime).inMinutes < 60) {
      return "${DateTime.now().difference(datetime).inMinutes}m";
    } else if (DateTime.now().difference(datetime).inMinutes >= 59 &&
        DateTime.now().difference(datetime).inMinutes < 119) {
      return "${DateTime.now().difference(datetime).inHours}h";
    } else if (DateTime.now().difference(datetime).inMinutes >= 120 &&
        DateTime.now().difference(datetime).inMinutes < 1439) {
      return "${DateTime.now().difference(datetime).inHours}h";
    } else if (DateTime.now().difference(datetime).inMinutes >= 1440 &&
        DateTime.now().difference(datetime).inMinutes < 2879) {
      return "${DateTime.now().difference(datetime).inDays}d";
    } else if (DateTime.now().difference(datetime).inMinutes >= 2880 &&
        DateTime.now().difference(datetime).inMinutes < 10079) {
      return "${DateTime.now().difference(datetime).inDays}d";
    } else if (DateTime.now().difference(datetime).inMinutes >= 10080 &&
        DateTime.now().difference(datetime).inMinutes < 40319) {
      return "${(DateTime.now().difference(datetime).inMinutes / 4).floor()}w";
    } else {
      return "${DateFormat.yMMMMd("pt_BR").format(datetime)}";
    }
  }

  @action
  togglePostItemLike(int index) {
    postSnapshot[index].isLiked
        ? deleteUserLike(
            postSnapshot[index].postUserNickname,
            postSnapshot[index].postID,
            index: index,
          )
        : setUserLike(
            postSnapshot[index].postUserNickname,
            postSnapshot[index].postID,
            index: index,
          );
  }

  @action
  Future<void> uploadFile(File effectFile) async {
    final String uuid = Uuid().v1();
    final StorageReference ref =
        _storage.ref().child('posts').child('foo$uuid.jpg');
    final StorageUploadTask _uploadTask = ref.putFile(effectFile);
    await (await _uploadTask.onComplete)
        .ref
        .getDownloadURL()
        .then((storageValue) {
      setUserPost(storageValue.toString());
    }).catchError((onError) => print(onError.toString()));
    _tasks.add(_uploadTask);
  }

  @action
  Future<void> uploadStorie(File effectFile) async {
    final String uuid = Uuid().v1();
    final StorageReference ref =
        _storage.ref().child('posts').child('foo$uuid.jpg');
    final StorageUploadTask _uploadTask = ref.putFile(effectFile);
    await (await _uploadTask.onComplete)
        .ref
        .getDownloadURL()
        .then((storageValue) {
      setUserStorie(storageValue.toString());
    }).catchError((onError) => print(onError.toString()));
    _tasks.add(_uploadTask);
  }

  @action
  setUserPost(String postImageURL) {
    String docID = postCollection.document().documentID;
    postCollection.document(docID).setData({
      'postID': docID,
      'postUserNickname': currentUserNickname,
      'postUserImage': currentUserImage,
      'postImage': postImageURL,
      'postDescription': postDescription,
      'postLocation': postLocation,
      'postDate': DateTime.now(),
    }).catchError((e) => print(e));
  }

  @action
  setUserStorie(String postImageURL) {
    CollectionReference storieRef = Firestore.instance
        .collection("users")
        .document(currentUserNickname)
        .collection("stories");
    String docID = storieRef.document().documentID;
    storieRef.document(docID).setData({
      'storieID': docID,
      'storieNickname': currentUserNickname,
      'storieImage': postImageURL,
      'storieDate': DateTime.now(),
    }).catchError((e) => print(e));

//    UserStore()
//        .userColletion
//        .document("felipemaximo")
//        .collection("posts")
//        .document(docID)
//        .setData({
//      'postID': docID,
//      'postNickname': "felipemaximo",
//      'postImage': postImageURL,
//      'postDescription': postDescription,
//      'postLocation': postLocation,
//      'postDate': DateTime.now(),
//    }).catchError((e) => print(e));
  }

  @action
  setUserLike(String userNickname, String postID, {int index}) {
    DocumentReference postRef = UserStore()
        .userColletion
        .document(userNickname)
        .collection('posts')
        .document(postID);
    postRef.collection('likes').document(currentUserNickname).setData({
      'likeNickname': currentUserNickname,
      'likeDate': DateTime.now(),
    }).then((success) {
      postRef.get().then((post) {
        setActivity(userNickname, postID, post["postImage"], "like");
        setUserLikedPost(postID, index: index);
      });
    }).catchError((error) => print("Instaclone Error. $error"));
  }

  @action
  deleteUserLike(String userNickname, String postID, {int index}) async {
    CollectionReference postLikedRef = UserStore()
        .userColletion
        .document(userNickname)
        .collection('posts')
        .document(postID)
        .collection("likes");

    DocumentReference userLikedRef = UserStore()
        .userColletion
        .document(currentUserNickname)
        .collection("liked")
        .document(postID);
    postLikedRef.document(currentUserNickname).delete().whenComplete(() async {
      userLikedRef.delete().whenComplete(() async {
        postSnapshot[index].isLiked = !postSnapshot[index].isLiked;
        postSnapshot[index].totalLikes =
            await postLikedRef.getDocuments().then((like) {
          like.documents.forEach((random) async {
            postSnapshot[index].randomLike = random["likeNickname"];
          });
          return like.documents.length;
        });
        getActivity();
      });
    });
  }

  @action
  setUserLikedPost(String postID, {int index}) {
    CollectionReference postLikedRef = UserStore()
        .userColletion
        .document(postSnapshot[index].postUserNickname)
        .collection('posts')
        .document(postID)
        .collection("likes");
    DocumentReference userRef =
        UserStore().userColletion.document(currentUserNickname);
    userRef.collection('liked').document(postID).setData({
      'postID': postID,
      'likeDate': DateTime.now(),
    }).then((success) async {
      postSnapshot[index].isLiked = !postSnapshot[index].isLiked;

      postSnapshot[index].totalLikes =
          await postLikedRef.getDocuments().then((like) {
        like.documents.forEach((random) async {
          postSnapshot[index].randomLike = random["likeNickname"];
        });
        return like.documents.length;
      });
      getActivity();
    }).catchError((error) => print("Error. $error"));
  }

  @action
  setActivity(String userNickname, String postID, String postImage, String type,
      {String comment}) {
    CollectionReference activityRef =
        UserStore().userColletion.document(userNickname).collection('activity');
    activityRef.document(type == "like" ? postID : null).setData({
      'activityNickname': currentUserNickname,
      'activityUserImage': currentUserImage,
      'activityImage': postImage,
      'activityDate': DateTime.now(),
      'activityType': type,
      'activityComment': type != "like" ? comment : "",
    }).then((success) {
      getActivity();
      print("Gravou atividade com sucesso.");
    }).catchError((error) => print("Instaclone Error. $error"));
  }

  @action
  verifyLikedPosts(String postID) {
    UserStore()
        .userColletion
        .document(currentUserNickname)
        .collection("liked")
        .getDocuments()
        .then(
      (docs) {
        docs.documents.forEach((data) {
          if (data.data["postID"] == postID && data.data["postID"] != null) {
            return true;
          } else {
            return false;
          }
        });
      },
    );
  }

  @observable
  ObservableFuture<List<Activity>> activityList =
      ObservableFuture<List<Activity>>.value([]);

  @computed
  List<Activity> get activityListGetter => activityList.value;

  @action
  Future<bool> getActivity() async {
    List<Activity> activityDataList = List();
    Firestore.instance
        .collection('users')
        .document(currentUserNickname)
        .collection("activity")
        .getDocuments()
        .then((activities) async {
      /// VERIFICAR A NECESSIDADE DA COLEÇÃO "ACTIVITY".
      if (activities.documents.length > 0) {

        activities.documents.forEach((activityDoc) {
          DateTime dateTime = activityDoc["activityDate"].toDate();
          activityDataList.add(Activity(
            activityDoc["activityNickname"],
            activityDoc["activityUserImage"],
            activityDoc["activityImage"],
            dateTime,
            activityDoc["activityType"],
            activityDoc["activityComment"],
          ));
        });
        activityDataList.sort((a, b) => b.date.compareTo(a.date));
        activityList = ObservableFuture<List<Activity>>.value(activityDataList);
        print("HSAUHSAUAHSUAS AH SE FUDER ${activityList.value.length}");
      }
    });
    return Future.value(true);
  }

  @observable
  String comment = "";

  @computed
  bool get isCommentFormValid => comment.length > 0;

  @observable
  ObservableFuture<List<Comment>> commentList =
      ObservableFuture<List<Comment>>.value([]);

  @computed
  List<Comment> get commentFromFirestore => commentList.value;

  @action
  void setComment(value) => comment = value;

  @action
  setPostComment(String userNickname, String postID) {
    DocumentReference postRef = UserStore()
        .userColletion
        .document(userNickname)
        .collection('posts')
        .document(postID);
    String docID = postRef.collection("comments").document().documentID;
    postRef.collection('comments').document(docID).setData({
      'commentID': docID,
      'commentNickname': currentUserNickname,
      'commentContent': comment,
      'commentDate': DateTime.now(),
    }).then((success) {
      postRef.get().then((post) {
        setActivity(userNickname, postID, post["postImage"], "comment",
            comment: comment);
        getCommentList(userNickname, postID);
      });
      print("Sucess $currentUserImage");
    }).catchError((error) => print("Error. $error"));
  }

  @action
  Future<bool> getCommentList(String userNickname, String postID) async {
    List<Comment> commentDataList = List();
    await Firestore.instance
        .collection('users')
        .document(userNickname)
        .collection("posts")
        .document(postID)
        .collection("comments")
        .getDocuments()
        .then((comment) async {
      String userImage = await Firestore.instance
          .collection("users")
          .where("nickname", isEqualTo: userNickname)
          .getDocuments()
          .then((user) {
        return user.documents[0]["image"];
      });
      if (comment.documents.length > 0) {
        for (var doc in comment.documents) {
          DateTime dateTime = doc.data["commentDate"].toDate();
          commentDataList.add(Comment(
            doc.data["commentNickname"],
            userImage,
            doc.data["commentContent"],
            dateTime,
            5,
          ));
        }
        commentList = ObservableFuture<List<Comment>>.value(commentDataList);
      }
    });

    return Future.value(true);
  }

  List<String> userCommentPhotoList = [
    "https://upload.wikimedia.org/wikipedia/commons/0/03/Kevin_Systrom_2018_%2840980041741%29_%28cropped%29.jpg",
    "https://pbs.twimg.com/profile_images/1134143877340946433/bP-CEOxG_400x400.png",
    "https://upload.wikimedia.org/wikipedia/commons/b/b2/Mike_Krieger.png",
    "https://upload.wikimedia.org/wikipedia/commons/e/ed/Elon_Musk_Royal_Society.jpg",
    "https://images.squarespace-cdn.com/content/v1/581f68acbebafba66ba09de9/1489621179008-A5G1U40VMCTEFF7S7PU0/ke17ZwdGBToddI8pDm48kGH5ZXhYWvzlcjzIftfN1BhZw-zPPgdn4jUwVcJE1ZvWEtT5uBSRWt4vQZAgTJucoTqqXjS3CfNDSuuf31e0tVGL4dsDp7mXJyattb4-lE_ORBdfruqg1dfjJaxBp8ahyUVVf71ZOeo6G_jHo2vWZxg/image-asset.jpeg",
    "https://upload.wikimedia.org/wikipedia/commons/f/f5/Steve_Jobs_Headshot_2010-CROP2.jpg",
    "https://pbs.twimg.com/profile_images/1225464393988804609/OptNrtcD_400x400.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/7/7e/Jack_Ma_Yun%2C_Tianjin%2C_2008_%28cropped%29.jpg",
    "https://forumsaudedigital.com.br/wp-content/uploads/2020/02/Bill_Gates_2014.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/1/14/Mark_Zuckerberg_F8_2018_Keynote_%28cropped_2%29.jpg",
  ];

  List<DateTime> userCommentDateList = [
    DateTime.now(),
    DateTime.now(),
    DateTime.now(),
    DateTime.now(),
    DateTime.now(),
    DateTime.now(),
    DateTime.now(),
    DateTime.now(),
    DateTime.now(),
    DateTime.now(),
  ];

  List<int> userCommentLikeList = [
    0,
    1,
    0,
    1,
    4,
    5,
    0,
    0,
    9,
    12,
  ];

//  @action
//  getCommentList(String userNickname, String postID) {
//    UserStore()
//        .userColletion
//        .document(userNickname)
//        .collection("posts")
//        .document(postID)
//        .collection("comments")
//        .getDocuments()
//        .then((data) {
//      data.documents.forEach((doc) async {
//        DateTime dateTime = doc.data["commentDate"].toDate();
//        UserStore()
//            .userColletion
//            .document(doc.data["commentNickname"])
//            .get()
//            .then((user) {
//          commentList.add(Comment(
//            doc.data["commentNickname"],
//            user.data["image"],
//            doc.data["commentContent"],
//            dateTime,
//            5,
//          ));
//        });
//      });
//    });
//  }

//  @action
//  getLikeList(String userNickname, String postID) {
//    UserStore()
//        .userColletion
//        .document(userNickname)
//        .collection("posts")
//        .document(postID)
//        .collection("likes")
//        .getDocuments()
//        .then((data) {
//      data.documents.forEach((doc) async {
//        DateTime dateTime = doc.data["likeDate"].toDate();
//        UserStore()
//            .userColletion
//            .document(doc.data["likeNickname"])
//            .get()
//            .then((user) {
//          likeList.add(Like(
//            doc.data["likeID"],
//            doc.data["likeNickname"],
//            user.data["image"],
//            dateTime,
//          ));
//        });
//      });
//    });
//  }

  //APAGAR DEPOIS

  String nickname = "fabiaizawa";
  String name = "Fabiana Aizawa ♡";
  String photo =
      "https://instagram.fsjk1-1.fna.fbcdn.net/v/t51.2885-19/s320x320/83886793_163342818412705_5846387278057832448_n.jpg?_nc_ht=instagram.fsjk1-1.fna.fbcdn.net&_nc_ohc=u-P3QxPyNZYAX9ar7w8&oh=b1769fa28bc48a4f6c9be540d94b363e&oe=5EB97457";

  @observable
  String description = "⚫︎ 𝚂𝙿 ⚬ 𝙱𝚁 𖡡\n⚫︎ 𝐸𝓈𝒸𝑜𝓇𝓅𝒾𝒶𝓃𝒶 ♏︎";

  String website = "swappin.io";
  String followers = formatNumber(12050);

  int following = 1;
  int posts = 120;

  final translator = GoogleTranslator();
  @observable
  bool isForeignLanguage = false;
  @observable
  bool isTranslated = false;

  @action
  void getDescriptionLanguage() {
    translator.translate(description, to: 'pt').then((translation) {
      if (translation != description) {
        isForeignLanguage = true;
      }
    });
  }

  @action
  void translateToUserNativeLanguage(String bio) {
    translator.translate(bio, to: 'pt').then((translation) {
      bio = translation;
      isTranslated = true;
    });
  }

  @action
  void translateToOriginalLanguage() {
    translator.translate(description, to: 'en').then((translation) {
      description = translation;
      isTranslated = false;
    });
  }

  static String formatNumber(int number) {
    var _formattedNumber = NumberFormat.compact().format(number);
    return _formattedNumber;
  }

  launchURL() async {
    if (await canLaunch("http://www.$website")) {
      await launch("http://www.$website");
    } else {
      throw 'Could not launch $website';
    }
  }

  List<String> friendRequest = [
    "Nome do User",
    "Nome do User 2",
    "Nome do User 3"
  ];

  List<bool> userChatWatched = [
    false,
    true,
    false,
    false,
    false,
    true,
    false,
    true,
    true,
    true
  ];

  List<bool> isLikedList = [
    true,
    true,
    false,
    true,
    true,
    false,
    true,
    false,
    false,
    true,
  ];

  List<double> likeNumberList = [
    9,
    2,
    0,
    2.3,
    1.5,
    9,
    8,
    1.5,
    6.8,
    0.7,
  ];
}
