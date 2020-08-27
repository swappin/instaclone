import 'package:flutter/material.dart';
import 'package:repositiv/app/shared/repositories/favorite_repository.dart';
import 'package:repositiv/app/shared/models/git_repo_model.dart';
import 'package:mobx/mobx.dart';

part 'favorite_controller.g.dart';

class FavoriteController = _FavoriteControllerBase with _$FavoriteController;

abstract class _FavoriteControllerBase with Store {
  final FavoriteRepository repository;

  @observable
  ObservableStream<List<GitRepoModel>> favoriteList;

  _FavoriteControllerBase({@required this.repository}) {
    getList();
  }

  @action
  void getList() {
    favoriteList = repository.get().asObservable();
  }

  @action
  void delete(GitRepoModel model) {
    repository.delete(model);
  }
}
