import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instaclone/main.dart';
import 'package:instaclone/models/post.dart';
import 'package:instaclone/models/profile.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:translator/translator.dart';

part 'profile_store.g.dart';

class ProfileStore = _ProfileStore with _$ProfileStore;

abstract class _ProfileStore with Store {
  CollectionReference userRef = Firestore.instance.collection("users");

  @observable
  bool isFollowing = false;

  @observable
  Profile profile = Profile();

  @observable
  var followers = 0;

  final translator = GoogleTranslator();

  @observable
  bool isForeignLanguage = false;

  @observable
  bool isTranslated = false;

  @action
  builtUserProfile(String nickname) async {
    List<Post> postList = [];
    await userRef.where("nickname", isEqualTo: nickname).getDocuments().then(
      (user) async {
        var posts = await userRef
            .document(nickname)
            .collection("posts")
            .getDocuments()
            .then((posts) {
          posts.documents.forEach((post) {
            DateTime datetime = post["postDate"].toDate();
            postList.add(Post(
                post["postID"],
                post["postUserNickname"],
                post["postUserImage"],
                post["postImage"],
                post["postDescription"],
                post["postLocation"],
                datetime));
            postList.sort((a, b) => b.postDate.compareTo(a.postDate));

          });
          return posts.documents.length;
        });
        var following = await userRef
            .document(nickname)
            .collection("following")
            .getDocuments()
            .then((following) {
          return following.documents.length;
        });
        followers = await userRef
            .document(nickname)
            .collection("followers")
            .getDocuments()
            .then((followers) {
          return followers.documents.length;
        });
        profile = Profile(
          name: user.documents[0]["name"],
          nickname: user.documents[0]["nickname"],
          image: user.documents[0]["image"],
          bio: user.documents[0]["bio"],
          website: user.documents[0]["website"],
          isProfessional: user.documents[0]["isProfessional"],
          isPrivate: user.documents[0]["isPrivate"],
          posts: posts.toString(),
          following: formatNumber(following),
          followers: user.documents[0]["nickname"] == "andrejvnior"
              ? formatNumber(986000000)
              : formatNumber(followers),
          followedBy: [],
          postList: postList,
        );
        getDescriptionLanguage(user.documents[0]["bio"]);
      },
    ).whenComplete(() {
      isFollowingUser(nickname);
    });
  }

  @action
  isFollowingUser(String nickname) async {
    await userRef
        .document(currentUserNickname)
        .collection("following")
        .getDocuments()
        .then((docs) {
      docs.documents.forEach((following) {
        if (following["followingNickname"] == nickname) isFollowing = true;
      });
    });
  }

  @action
  getDescriptionLanguage(String bio) async {
    await translator.translate(bio, to: 'pt').then((translation) {
      if (translation != bio) {
        isForeignLanguage = true;
      }
    });
  }

  @action
  void translateToUserNativeLanguage(String bio) {
    translator.translate(bio, to: 'pt').then((translation) {
      profile.bio = translation;
      print("Meu profile ${profile.bio}");
      isTranslated = true;
    });
  }

  @action
  void translateToOriginalLanguage(String bio) {
    translator.translate(bio, to: 'en').then((translation) {
      profile.bio = translation;
      isTranslated = false;
    });
  }

  static String formatNumber(int number) {
    var _formattedNumber = NumberFormat.compact().format(number);
    return _formattedNumber;
  }

  @action
  followUser(String nickname) async {
    await Firestore.instance
        .collection("users")
        .document(currentUserNickname)
        .collection("following")
        .document(nickname)
        .setData({
      "followingNickname": nickname,
      "followingDate": DateTime.now(),
    }).whenComplete(() => Firestore.instance
                .collection("users")
                .document(nickname)
                .collection("followers")
                .document(currentUserNickname)
                .setData({
              "followingNickname": currentUserNickname,
              "followingDate": DateTime.now(),
            }).whenComplete(() async {
              followers = await userRef
                  .document(nickname)
                  .collection("followers")
                  .getDocuments()
                  .then((followers) {
                return followers.documents.length;
              });
              profile.followers = followers.toString();
              isFollowing = true;
            }));

  }

  @action
  unfollowUser(String nickname) async {
    await Firestore.instance
        .collection("users")
        .document(currentUserNickname)
        .collection("following")
        .document(nickname)
        .delete()
        .whenComplete(() => Firestore.instance
                .collection("users")
                .document(nickname)
                .collection("followers")
                .document(currentUserNickname)
                .delete()
                .whenComplete(() async {
              var followers = await userRef
                  .document(nickname)
                  .collection("followers")
                  .getDocuments()
                  .then((followers) {
                return followers.documents.length;
              });
              profile.followers = followers.toString();
              isFollowing = false;
            }));
  }
}
