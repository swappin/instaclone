// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_item_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PostItemStore on _PostItemStore, Store {
  final _$isLikedAtom = Atom(name: '_PostItemStore.isLiked');

  @override
  bool get isLiked {
    _$isLikedAtom.context.enforceReadPolicy(_$isLikedAtom);
    _$isLikedAtom.reportObserved();
    return super.isLiked;
  }

  @override
  set isLiked(bool value) {
    _$isLikedAtom.context.conditionallyRunInAction(() {
      super.isLiked = value;
      _$isLikedAtom.reportChanged();
    }, _$isLikedAtom, name: '${_$isLikedAtom.name}_set');
  }

  final _$totalLikesAtom = Atom(name: '_PostItemStore.totalLikes');

  @override
  int get totalLikes {
    _$totalLikesAtom.context.enforceReadPolicy(_$totalLikesAtom);
    _$totalLikesAtom.reportObserved();
    return super.totalLikes;
  }

  @override
  set totalLikes(int value) {
    _$totalLikesAtom.context.conditionallyRunInAction(() {
      super.totalLikes = value;
      _$totalLikesAtom.reportChanged();
    }, _$totalLikesAtom, name: '${_$totalLikesAtom.name}_set');
  }

  final _$randomLikeAtom = Atom(name: '_PostItemStore.randomLike');

  @override
  String get randomLike {
    _$randomLikeAtom.context.enforceReadPolicy(_$randomLikeAtom);
    _$randomLikeAtom.reportObserved();
    return super.randomLike;
  }

  @override
  set randomLike(String value) {
    _$randomLikeAtom.context.conditionallyRunInAction(() {
      super.randomLike = value;
      _$randomLikeAtom.reportChanged();
    }, _$randomLikeAtom, name: '${_$randomLikeAtom.name}_set');
  }

  final _$_PostItemStoreActionController =
      ActionController(name: '_PostItemStore');

  @override
  void toggleDone() {
    final _$actionInfo = _$_PostItemStoreActionController.startAction();
    try {
      return super.toggleDone();
    } finally {
      _$_PostItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void incrementLikes() {
    final _$actionInfo = _$_PostItemStoreActionController.startAction();
    try {
      return super.incrementLikes();
    } finally {
      _$_PostItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'isLiked: ${isLiked.toString()},totalLikes: ${totalLikes.toString()},randomLike: ${randomLike.toString()}';
    return '{$string}';
  }
}
