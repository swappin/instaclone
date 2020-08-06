import 'package:mobx/mobx.dart';

part 'post_item_store.g.dart';

class PostItemStore = _PostItemStore with _$PostItemStore;

abstract class _PostItemStore with Store{

  final String _postID;
  final String _postUserNickname;
  final String _postUserImage;
  final String _postImage;
  final String _postDescription;
  final String _postLocation;
  final DateTime _postDate;


  @observable
  bool isLiked = false;

  @action
  void toggleDone() => isLiked = !isLiked;

  @observable
  int totalLikes;

  @action
  void incrementLikes() => totalLikes += totalLikes;

  final int comments;

  @observable
  String randomLike;

  _PostItemStore(this._postID, this._postUserNickname, this._postUserImage, this._postImage, this._postDescription, this._postLocation, this._postDate, {this.isLiked, this.totalLikes, this.comments, this.randomLike});

  String get postID => _postID;

  String get postUserNickname => _postUserNickname;

  String get postUserImage => _postUserImage;

  String get postImage => _postImage;

  String get postDescription => _postDescription;

  String get postLocation => _postLocation;

  DateTime get postDate => _postDate;

//  @computed
//  int get totalLikes => _totalLikes;

//int get totalComments => _totalComments;
}