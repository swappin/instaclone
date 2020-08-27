import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:repositiv/app/shared/models/git_repo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FavoriteRepository extends Disposable {
  final FirebaseFirestore firestore;

  FavoriteRepository({@required this.firestore});

  @override
  void dispose() {}


  @override
  Stream<List<GitRepoModel>> get() {
    return firestore.collection('favorite').orderBy('id').snapshots().map(
        (query) =>
            query.docs.map((doc) => GitRepoModel.fromDocument(doc)).toList());
  }

  @override
  Future<Stream<GitRepoModel>> getByDocumentId(String documentId) async {
    return firestore
        .collection('favorite')
        .doc(documentId)
        .snapshots()
        .map((doc) => GitRepoModel.fromDocument(doc));
  }

  Future delete(GitRepoModel model) {
    return model.reference.delete();
  }
}
