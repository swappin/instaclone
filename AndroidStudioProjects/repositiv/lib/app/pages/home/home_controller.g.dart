// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$gitRepoAtom = Atom(name: '_HomeControllerBase.gitRepo');

  @override
  ObservableFuture<dynamic> get gitRepo {
    _$gitRepoAtom.reportRead();
    return super.gitRepo;
  }

  @override
  set gitRepo(ObservableFuture<dynamic> value) {
    _$gitRepoAtom.reportWrite(value, super.gitRepo, () {
      super.gitRepo = value;
    });
  }

  final _$totalFavoriteAtom = Atom(name: '_HomeControllerBase.totalFavorite');

  @override
  int get totalFavorite {
    _$totalFavoriteAtom.reportRead();
    return super.totalFavorite;
  }

  @override
  set totalFavorite(int value) {
    _$totalFavoriteAtom.reportWrite(value, super.totalFavorite, () {
      super.totalFavorite = value;
    });
  }

  final _$isTotalIncreasedAtom =
      Atom(name: '_HomeControllerBase.isTotalIncreased');

  @override
  bool get isTotalIncreased {
    _$isTotalIncreasedAtom.reportRead();
    return super.isTotalIncreased;
  }

  @override
  set isTotalIncreased(bool value) {
    _$isTotalIncreasedAtom.reportWrite(value, super.isTotalIncreased, () {
      super.isTotalIncreased = value;
    });
  }

  final _$getTotalFavoriteAsyncAction =
      AsyncAction('_HomeControllerBase.getTotalFavorite');

  @override
  Future<int> getTotalFavorite() {
    return _$getTotalFavoriteAsyncAction.run(() => super.getTotalFavorite());
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  dynamic fetchGitRepos() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.fetchGitRepos');
    try {
      return super.fetchGitRepos();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void saveRepo(GitRepoModel model) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.saveRepo');
    try {
      return super.saveRepo(model);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
gitRepo: ${gitRepo},
totalFavorite: ${totalFavorite},
isTotalIncreased: ${isTotalIncreased}
    ''';
  }
}
