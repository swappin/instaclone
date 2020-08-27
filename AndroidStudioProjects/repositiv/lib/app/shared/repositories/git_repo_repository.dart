import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:repositiv/app/shared/models/git_repo_model.dart';

class GitRepoRepository {
  final Dio dio;
  final FirebaseFirestore firestore;

  GitRepoRepository({@required this.dio, this.firestore});

  Future<List<GitRepoModel>> getGitRepo() async {
    var response = await dio.get('/flutter/repos');
    List<GitRepoModel> list = List<GitRepoModel>();
    for (var item in (response.data as List)) {
      GitRepoModel model = GitRepoModel(
        name: item['name'],
        description: item['description'],
        language: item['language'],
        createdAt: item['created_at'],
        id: item['id'],
        stargazersCount: item['stargazers_count'],
      );
      list.add(model);
    }

    return list;
  }

  @override
  Future saveGitRepo(GitRepoModel model) async {
    var total = (await firestore.collection('favorite').get())
        .docs
        .length;

    if (model.reference == null) {
      CollectionReference collection =
          await firestore.collection('favorite');

      collection.doc(model.name).set({
        'id': model.id,
        'name': model.name,
        'description': model.description,
        'language': model.language,
        'createdAt': model.createdAt,
        'stars': model.stargazersCount,
        'savedAt': DateTime.now(),
      });
    } else {
      model.reference.update({
        'name': model.name,
        'description': model.description,
        'language': model.language,
        'createdAt': model.createdAt,
        'stars': model.stargazersCount,
      });
    }
  }

  @override
  Future<int> countFavorite() async {
    return firestore
        .collection('favorite')
        .get()
        .then((value) => value.docs.length);
  }
}
