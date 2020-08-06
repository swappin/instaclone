import 'package:instaclone/models/like.dart';

class Post{
  final String _postID;
  final String _postUserNickname;
  final String _postUserImage;
  final String _postImage;
  final String _postDescription;
  final String _postLocation;
  final DateTime _postDate;
  bool isLiked;
  final int likes;
  final int comments;
  final String randomLike;

  Post(this._postID, this._postUserNickname, this._postUserImage, this._postImage, this._postDescription, this._postLocation, this._postDate, {this.isLiked, this.likes, this.comments, this.randomLike});

 String get postID => _postID;

 String get postUserNickname => _postUserNickname;

 String get postUserImage => _postUserImage;

  String get postImage => _postImage;

  String get postDescription => _postDescription;

  String get postLocation => _postLocation;

  DateTime get postDate => _postDate;

  //int get totalLikes => _totalLikes;

  //int get totalComments => _totalComments;
}