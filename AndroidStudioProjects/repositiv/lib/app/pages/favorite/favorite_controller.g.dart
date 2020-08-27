// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FavoriteController on _FavoriteControllerBase, Store {
  final _$favoriteListAtom = Atom(name: '_FavoriteControllerBase.favoriteList');

  @override
  ObservableStream<List<GitRepoModel>> get favoriteList {
    _$favoriteListAtom.reportRead();
    return super.favoriteList;
  }

  @override
  set favoriteList(ObservableStream<List<GitRepoModel>> value) {
    _$favoriteListAtom.reportWrite(value, super.favoriteList, () {
      super.favoriteList = value;
    });
  }

  final _$_FavoriteControllerBaseActionController =
      ActionController(name: '_FavoriteControllerBase');

  @override
  void getList() {
    final _$actionInfo = _$_FavoriteControllerBaseActionController.startAction(
        name: '_FavoriteControllerBase.getList');
    try {
      return super.getList();
    } finally {
      _$_FavoriteControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void delete(GitRepoModel model) {
    final _$actionInfo = _$_FavoriteControllerBaseActionController.startAction(
        name: '_FavoriteControllerBase.delete');
    try {
      return super.delete(model);
    } finally {
      _$_FavoriteControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
favoriteList: ${favoriteList}
    ''';
  }
}
