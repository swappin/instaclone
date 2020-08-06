// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStore, Store {
  Computed<List<Profile>> _$userListGetterComputed;

  @override
  List<Profile> get userListGetter => (_$userListGetterComputed ??=
          Computed<List<Profile>>(() => super.userListGetter))
      .value;

  final _$searchAtom = Atom(name: '_UserStore.search');

  @override
  String get search {
    _$searchAtom.context.enforceReadPolicy(_$searchAtom);
    _$searchAtom.reportObserved();
    return super.search;
  }

  @override
  set search(String value) {
    _$searchAtom.context.conditionallyRunInAction(() {
      super.search = value;
      _$searchAtom.reportChanged();
    }, _$searchAtom, name: '${_$searchAtom.name}_set');
  }

  final _$_userListAtom = Atom(name: '_UserStore._userList');

  @override
  ObservableList<Profile> get _userList {
    _$_userListAtom.context.enforceReadPolicy(_$_userListAtom);
    _$_userListAtom.reportObserved();
    return super._userList;
  }

  @override
  set _userList(ObservableList<Profile> value) {
    _$_userListAtom.context.conditionallyRunInAction(() {
      super._userList = value;
      _$_userListAtom.reportChanged();
    }, _$_userListAtom, name: '${_$_userListAtom.name}_set');
  }

  final _$hasUserAtom = Atom(name: '_UserStore.hasUser');

  @override
  bool get hasUser {
    _$hasUserAtom.context.enforceReadPolicy(_$hasUserAtom);
    _$hasUserAtom.reportObserved();
    return super.hasUser;
  }

  @override
  set hasUser(bool value) {
    _$hasUserAtom.context.conditionallyRunInAction(() {
      super.hasUser = value;
      _$hasUserAtom.reportChanged();
    }, _$hasUserAtom, name: '${_$hasUserAtom.name}_set');
  }

  final _$selectedIndexAtom = Atom(name: '_UserStore.selectedIndex');

  @override
  int get selectedIndex {
    _$selectedIndexAtom.context.enforceReadPolicy(_$selectedIndexAtom);
    _$selectedIndexAtom.reportObserved();
    return super.selectedIndex;
  }

  @override
  set selectedIndex(int value) {
    _$selectedIndexAtom.context.conditionallyRunInAction(() {
      super.selectedIndex = value;
      _$selectedIndexAtom.reportChanged();
    }, _$selectedIndexAtom, name: '${_$selectedIndexAtom.name}_set');
  }

  final _$_UserStoreActionController = ActionController(name: '_UserStore');

  @override
  void setSearch(dynamic value) {
    final _$actionInfo = _$_UserStoreActionController.startAction();
    try {
      return super.setSearch(value);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic registerUser() {
    final _$actionInfo = _$_UserStoreActionController.startAction();
    try {
      return super.registerUser();
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic buildUserList() {
    final _$actionInfo = _$_UserStoreActionController.startAction();
    try {
      return super.buildUserList();
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic searchUser() {
    final _$actionInfo = _$_UserStoreActionController.startAction();
    try {
      return super.searchUser();
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onItemTapped(int index) {
    final _$actionInfo = _$_UserStoreActionController.startAction();
    try {
      return super.onItemTapped(index);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'search: ${search.toString()},hasUser: ${hasUser.toString()},selectedIndex: ${selectedIndex.toString()},userListGetter: ${userListGetter.toString()}';
    return '{$string}';
  }
}
