import 'package:flutter/material.dart';
import 'package:repositiv/app/shared/models/git_repo_model.dart';
import 'package:repositiv/app/shared/repositories/git_repo_repository.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final GitRepoRepository repository;

  @observable
  ObservableFuture gitRepo;

  @observable
  int totalFavorite = 0;

  @observable
  bool isTotalIncreased;

  _HomeControllerBase({@required this.repository}) {
    getTotalFavorite();
    fetchGitRepos();
  }

  @action
  fetchGitRepos() {
    gitRepo = repository.getGitRepo().asObservable();
  }

  @action
  void saveRepo(GitRepoModel model) {
    repository.saveGitRepo(model).whenComplete(() => getTotalFavorite());
  }

  @action
  Future<int> getTotalFavorite() async {
    print("Não alterou $totalFavorite");
    int verifyFavorites = totalFavorite;
    totalFavorite = await repository.countFavorite();
    print(totalFavorite);
    if(totalFavorite == verifyFavorites){
      print("Não alterou");
      isTotalIncreased = false;
    }else{
      isTotalIncreased = true;
      print("alterou hehehehe");
    }
  }
}
