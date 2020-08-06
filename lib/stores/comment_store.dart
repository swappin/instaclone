import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instaclone/main.dart';
import 'package:instaclone/models/comment.dart';
import 'package:instaclone/stores/user_store.dart';
import 'package:mobx/mobx.dart';

part 'comment_store.g.dart';

class CommentStore = _CommentStore with _$CommentStore;

abstract class _CommentStore with Store{

}