import 'package:instaclone/models/user.dart';

class Answer{
  final String userNickname;
  final String image;
  final String comment;
  final int likes;
  final List<String> answers;

  Answer({this.userNickname, this.image, this.comment, this.likes, this.answers});
}