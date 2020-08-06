import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instaclone/main.dart';
import 'package:instaclone/stores/user_store.dart';
import 'package:mobx/mobx.dart';

part 'like_store.g.dart';

class LikeStore = _LikeStore with _$LikeStore;

// TODO: Extender Poststore
abstract class _LikeStore with Store {
}
