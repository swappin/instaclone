// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storie_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StorieStore on _StorieStore, Store {
  final _$hasStorieAtom = Atom(name: '_StorieStore.hasStorie');

  @override
  bool get hasStorie {
    _$hasStorieAtom.context.enforceReadPolicy(_$hasStorieAtom);
    _$hasStorieAtom.reportObserved();
    return super.hasStorie;
  }

  @override
  set hasStorie(bool value) {
    _$hasStorieAtom.context.conditionallyRunInAction(() {
      super.hasStorie = value;
      _$hasStorieAtom.reportChanged();
    }, _$hasStorieAtom, name: '${_$hasStorieAtom.name}_set');
  }

  final _$storieWatchedAtom = Atom(name: '_StorieStore.storieWatched');

  @override
  bool get storieWatched {
    _$storieWatchedAtom.context.enforceReadPolicy(_$storieWatchedAtom);
    _$storieWatchedAtom.reportObserved();
    return super.storieWatched;
  }

  @override
  set storieWatched(bool value) {
    _$storieWatchedAtom.context.conditionallyRunInAction(() {
      super.storieWatched = value;
      _$storieWatchedAtom.reportChanged();
    }, _$storieWatchedAtom, name: '${_$storieWatchedAtom.name}_set');
  }

  final _$storieActiveAtom = Atom(name: '_StorieStore.storieActive');

  @override
  bool get storieActive {
    _$storieActiveAtom.context.enforceReadPolicy(_$storieActiveAtom);
    _$storieActiveAtom.reportObserved();
    return super.storieActive;
  }

  @override
  set storieActive(bool value) {
    _$storieActiveAtom.context.conditionallyRunInAction(() {
      super.storieActive = value;
      _$storieActiveAtom.reportChanged();
    }, _$storieActiveAtom, name: '${_$storieActiveAtom.name}_set');
  }

  final _$initStorieTimerAsyncAction = AsyncAction('initStorieTimer');

  @override
  Future initStorieTimer(BuildContext context) {
    return _$initStorieTimerAsyncAction
        .run(() => super.initStorieTimer(context));
  }

  final _$getFollowingStoriesAsyncAction = AsyncAction('getFollowingStories');

  @override
  Future getFollowingStories() {
    return _$getFollowingStoriesAsyncAction
        .run(() => super.getFollowingStories());
  }

  final _$getStoriesAsyncAction = AsyncAction('getStories');

  @override
  Future getStories(String nickname) {
    return _$getStoriesAsyncAction.run(() => super.getStories(nickname));
  }

  @override
  String toString() {
    final string =
        'hasStorie: ${hasStorie.toString()},storieWatched: ${storieWatched.toString()},storieActive: ${storieActive.toString()}';
    return '{$string}';
  }
}
