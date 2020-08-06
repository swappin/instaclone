// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileStore on _ProfileStore, Store {
  final _$isFollowingAtom = Atom(name: '_ProfileStore.isFollowing');

  @override
  bool get isFollowing {
    _$isFollowingAtom.context.enforceReadPolicy(_$isFollowingAtom);
    _$isFollowingAtom.reportObserved();
    return super.isFollowing;
  }

  @override
  set isFollowing(bool value) {
    _$isFollowingAtom.context.conditionallyRunInAction(() {
      super.isFollowing = value;
      _$isFollowingAtom.reportChanged();
    }, _$isFollowingAtom, name: '${_$isFollowingAtom.name}_set');
  }

  final _$profileAtom = Atom(name: '_ProfileStore.profile');

  @override
  Profile get profile {
    _$profileAtom.context.enforceReadPolicy(_$profileAtom);
    _$profileAtom.reportObserved();
    return super.profile;
  }

  @override
  set profile(Profile value) {
    _$profileAtom.context.conditionallyRunInAction(() {
      super.profile = value;
      _$profileAtom.reportChanged();
    }, _$profileAtom, name: '${_$profileAtom.name}_set');
  }

  final _$followersAtom = Atom(name: '_ProfileStore.followers');

  @override
  int get followers {
    _$followersAtom.context.enforceReadPolicy(_$followersAtom);
    _$followersAtom.reportObserved();
    return super.followers;
  }

  @override
  set followers(int value) {
    _$followersAtom.context.conditionallyRunInAction(() {
      super.followers = value;
      _$followersAtom.reportChanged();
    }, _$followersAtom, name: '${_$followersAtom.name}_set');
  }

  final _$isForeignLanguageAtom = Atom(name: '_ProfileStore.isForeignLanguage');

  @override
  bool get isForeignLanguage {
    _$isForeignLanguageAtom.context.enforceReadPolicy(_$isForeignLanguageAtom);
    _$isForeignLanguageAtom.reportObserved();
    return super.isForeignLanguage;
  }

  @override
  set isForeignLanguage(bool value) {
    _$isForeignLanguageAtom.context.conditionallyRunInAction(() {
      super.isForeignLanguage = value;
      _$isForeignLanguageAtom.reportChanged();
    }, _$isForeignLanguageAtom, name: '${_$isForeignLanguageAtom.name}_set');
  }

  final _$isTranslatedAtom = Atom(name: '_ProfileStore.isTranslated');

  @override
  bool get isTranslated {
    _$isTranslatedAtom.context.enforceReadPolicy(_$isTranslatedAtom);
    _$isTranslatedAtom.reportObserved();
    return super.isTranslated;
  }

  @override
  set isTranslated(bool value) {
    _$isTranslatedAtom.context.conditionallyRunInAction(() {
      super.isTranslated = value;
      _$isTranslatedAtom.reportChanged();
    }, _$isTranslatedAtom, name: '${_$isTranslatedAtom.name}_set');
  }

  final _$builtUserProfileAsyncAction = AsyncAction('builtUserProfile');

  @override
  Future builtUserProfile(String nickname) {
    return _$builtUserProfileAsyncAction
        .run(() => super.builtUserProfile(nickname));
  }

  final _$isFollowingUserAsyncAction = AsyncAction('isFollowingUser');

  @override
  Future isFollowingUser(String nickname) {
    return _$isFollowingUserAsyncAction
        .run(() => super.isFollowingUser(nickname));
  }

  final _$getDescriptionLanguageAsyncAction =
      AsyncAction('getDescriptionLanguage');

  @override
  Future getDescriptionLanguage(String bio) {
    return _$getDescriptionLanguageAsyncAction
        .run(() => super.getDescriptionLanguage(bio));
  }

  final _$followUserAsyncAction = AsyncAction('followUser');

  @override
  Future followUser(String nickname) {
    return _$followUserAsyncAction.run(() => super.followUser(nickname));
  }

  final _$unfollowUserAsyncAction = AsyncAction('unfollowUser');

  @override
  Future unfollowUser(String nickname) {
    return _$unfollowUserAsyncAction.run(() => super.unfollowUser(nickname));
  }

  final _$_ProfileStoreActionController =
      ActionController(name: '_ProfileStore');

  @override
  void translateToUserNativeLanguage(String bio) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction();
    try {
      return super.translateToUserNativeLanguage(bio);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void translateToOriginalLanguage(String bio) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction();
    try {
      return super.translateToOriginalLanguage(bio);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'isFollowing: ${isFollowing.toString()},profile: ${profile.toString()},followers: ${followers.toString()},isForeignLanguage: ${isForeignLanguage.toString()},isTranslated: ${isTranslated.toString()}';
    return '{$string}';
  }
}
