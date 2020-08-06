import 'package:instaclone/models/post.dart';

class Profile {
  final String name;
  final String nickname;
  final String image;
  String bio;
  final String website;
  final bool isProfessional;
  final bool isPrivate;
  final String posts;
  String followers;
  String following;
  final List<String> followedBy;
  final List<Post> postList;

  Profile({
    this.name,
    this.nickname,
    this.image,
    this.bio,
    this.website,
    this.isProfessional,
    this.isPrivate,
    this.posts,
    this.followers,
    this.following,
    this.followedBy,
    this.postList,
  });
}
