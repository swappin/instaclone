// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PostStore on _PostStore, Store {
  Computed<List<Activity>> _$activityListGetterComputed;

  @override
  List<Activity> get activityListGetter => (_$activityListGetterComputed ??=
          Computed<List<Activity>>(() => super.activityListGetter))
      .value;
  Computed<bool> _$isCommentFormValidComputed;

  @override
  bool get isCommentFormValid => (_$isCommentFormValidComputed ??=
          Computed<bool>(() => super.isCommentFormValid))
      .value;
  Computed<List<Comment>> _$commentFromFirestoreComputed;

  @override
  List<Comment> get commentFromFirestore => (_$commentFromFirestoreComputed ??=
          Computed<List<Comment>>(() => super.commentFromFirestore))
      .value;

  final _$postDescriptionAtom = Atom(name: '_PostStore.postDescription');

  @override
  String get postDescription {
    _$postDescriptionAtom.context.enforceReadPolicy(_$postDescriptionAtom);
    _$postDescriptionAtom.reportObserved();
    return super.postDescription;
  }

  @override
  set postDescription(String value) {
    _$postDescriptionAtom.context.conditionallyRunInAction(() {
      super.postDescription = value;
      _$postDescriptionAtom.reportChanged();
    }, _$postDescriptionAtom, name: '${_$postDescriptionAtom.name}_set');
  }

  final _$postLocationAtom = Atom(name: '_PostStore.postLocation');

  @override
  String get postLocation {
    _$postLocationAtom.context.enforceReadPolicy(_$postLocationAtom);
    _$postLocationAtom.reportObserved();
    return super.postLocation;
  }

  @override
  set postLocation(String value) {
    _$postLocationAtom.context.conditionallyRunInAction(() {
      super.postLocation = value;
      _$postLocationAtom.reportChanged();
    }, _$postLocationAtom, name: '${_$postLocationAtom.name}_set');
  }

  final _$isPrivateAtom = Atom(name: '_PostStore.isPrivate');

  @override
  bool get isPrivate {
    _$isPrivateAtom.context.enforceReadPolicy(_$isPrivateAtom);
    _$isPrivateAtom.reportObserved();
    return super.isPrivate;
  }

  @override
  set isPrivate(bool value) {
    _$isPrivateAtom.context.conditionallyRunInAction(() {
      super.isPrivate = value;
      _$isPrivateAtom.reportChanged();
    }, _$isPrivateAtom, name: '${_$isPrivateAtom.name}_set');
  }

  final _$searchAtom = Atom(name: '_PostStore.search');

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

  final _$favoriteAtom = Atom(name: '_PostStore.favorite');

  @override
  bool get favorite {
    _$favoriteAtom.context.enforceReadPolicy(_$favoriteAtom);
    _$favoriteAtom.reportObserved();
    return super.favorite;
  }

  @override
  set favorite(bool value) {
    _$favoriteAtom.context.conditionallyRunInAction(() {
      super.favorite = value;
      _$favoriteAtom.reportChanged();
    }, _$favoriteAtom, name: '${_$favoriteAtom.name}_set');
  }

  final _$shareOnFacebookAtom = Atom(name: '_PostStore.shareOnFacebook');

  @override
  bool get shareOnFacebook {
    _$shareOnFacebookAtom.context.enforceReadPolicy(_$shareOnFacebookAtom);
    _$shareOnFacebookAtom.reportObserved();
    return super.shareOnFacebook;
  }

  @override
  set shareOnFacebook(bool value) {
    _$shareOnFacebookAtom.context.conditionallyRunInAction(() {
      super.shareOnFacebook = value;
      _$shareOnFacebookAtom.reportChanged();
    }, _$shareOnFacebookAtom, name: '${_$shareOnFacebookAtom.name}_set');
  }

  final _$shareOnTwitterAtom = Atom(name: '_PostStore.shareOnTwitter');

  @override
  bool get shareOnTwitter {
    _$shareOnTwitterAtom.context.enforceReadPolicy(_$shareOnTwitterAtom);
    _$shareOnTwitterAtom.reportObserved();
    return super.shareOnTwitter;
  }

  @override
  set shareOnTwitter(bool value) {
    _$shareOnTwitterAtom.context.conditionallyRunInAction(() {
      super.shareOnTwitter = value;
      _$shareOnTwitterAtom.reportChanged();
    }, _$shareOnTwitterAtom, name: '${_$shareOnTwitterAtom.name}_set');
  }

  final _$shareOnTumblrAtom = Atom(name: '_PostStore.shareOnTumblr');

  @override
  bool get shareOnTumblr {
    _$shareOnTumblrAtom.context.enforceReadPolicy(_$shareOnTumblrAtom);
    _$shareOnTumblrAtom.reportObserved();
    return super.shareOnTumblr;
  }

  @override
  set shareOnTumblr(bool value) {
    _$shareOnTumblrAtom.context.conditionallyRunInAction(() {
      super.shareOnTumblr = value;
      _$shareOnTumblrAtom.reportChanged();
    }, _$shareOnTumblrAtom, name: '${_$shareOnTumblrAtom.name}_set');
  }

  final _$focusAtom = Atom(name: '_PostStore.focus');

  @override
  FocusNode get focus {
    _$focusAtom.context.enforceReadPolicy(_$focusAtom);
    _$focusAtom.reportObserved();
    return super.focus;
  }

  @override
  set focus(FocusNode value) {
    _$focusAtom.context.conditionallyRunInAction(() {
      super.focus = value;
      _$focusAtom.reportChanged();
    }, _$focusAtom, name: '${_$focusAtom.name}_set');
  }

  final _$hasFocusAtom = Atom(name: '_PostStore.hasFocus');

  @override
  bool get hasFocus {
    _$hasFocusAtom.context.enforceReadPolicy(_$hasFocusAtom);
    _$hasFocusAtom.reportObserved();
    return super.hasFocus;
  }

  @override
  set hasFocus(bool value) {
    _$hasFocusAtom.context.conditionallyRunInAction(() {
      super.hasFocus = value;
      _$hasFocusAtom.reportChanged();
    }, _$hasFocusAtom, name: '${_$hasFocusAtom.name}_set');
  }

  final _$activityListAtom = Atom(name: '_PostStore.activityList');

  @override
  ObservableFuture<List<Activity>> get activityList {
    _$activityListAtom.context.enforceReadPolicy(_$activityListAtom);
    _$activityListAtom.reportObserved();
    return super.activityList;
  }

  @override
  set activityList(ObservableFuture<List<Activity>> value) {
    _$activityListAtom.context.conditionallyRunInAction(() {
      super.activityList = value;
      _$activityListAtom.reportChanged();
    }, _$activityListAtom, name: '${_$activityListAtom.name}_set');
  }

  final _$commentAtom = Atom(name: '_PostStore.comment');

  @override
  String get comment {
    _$commentAtom.context.enforceReadPolicy(_$commentAtom);
    _$commentAtom.reportObserved();
    return super.comment;
  }

  @override
  set comment(String value) {
    _$commentAtom.context.conditionallyRunInAction(() {
      super.comment = value;
      _$commentAtom.reportChanged();
    }, _$commentAtom, name: '${_$commentAtom.name}_set');
  }

  final _$commentListAtom = Atom(name: '_PostStore.commentList');

  @override
  ObservableFuture<List<Comment>> get commentList {
    _$commentListAtom.context.enforceReadPolicy(_$commentListAtom);
    _$commentListAtom.reportObserved();
    return super.commentList;
  }

  @override
  set commentList(ObservableFuture<List<Comment>> value) {
    _$commentListAtom.context.conditionallyRunInAction(() {
      super.commentList = value;
      _$commentListAtom.reportChanged();
    }, _$commentListAtom, name: '${_$commentListAtom.name}_set');
  }

  final _$descriptionAtom = Atom(name: '_PostStore.description');

  @override
  String get description {
    _$descriptionAtom.context.enforceReadPolicy(_$descriptionAtom);
    _$descriptionAtom.reportObserved();
    return super.description;
  }

  @override
  set description(String value) {
    _$descriptionAtom.context.conditionallyRunInAction(() {
      super.description = value;
      _$descriptionAtom.reportChanged();
    }, _$descriptionAtom, name: '${_$descriptionAtom.name}_set');
  }

  final _$isForeignLanguageAtom = Atom(name: '_PostStore.isForeignLanguage');

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

  final _$isTranslatedAtom = Atom(name: '_PostStore.isTranslated');

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

  final _$buildTimelineAsyncAction = AsyncAction('buildTimeline');

  @override
  Future<Stream<DocumentSnapshot>> buildTimeline() {
    return _$buildTimelineAsyncAction.run(() => super.buildTimeline());
  }

  final _$uploadFileAsyncAction = AsyncAction('uploadFile');

  @override
  Future<void> uploadFile(File effectFile) {
    return _$uploadFileAsyncAction.run(() => super.uploadFile(effectFile));
  }

  final _$uploadStorieAsyncAction = AsyncAction('uploadStorie');

  @override
  Future<void> uploadStorie(File effectFile) {
    return _$uploadStorieAsyncAction.run(() => super.uploadStorie(effectFile));
  }

  final _$deleteUserLikeAsyncAction = AsyncAction('deleteUserLike');

  @override
  Future deleteUserLike(String userNickname, String postID, {int index}) {
    return _$deleteUserLikeAsyncAction
        .run(() => super.deleteUserLike(userNickname, postID, index: index));
  }

  final _$getActivityAsyncAction = AsyncAction('getActivity');

  @override
  Future<bool> getActivity() {
    return _$getActivityAsyncAction.run(() => super.getActivity());
  }

  final _$getCommentListAsyncAction = AsyncAction('getCommentList');

  @override
  Future<bool> getCommentList(String userNickname, String postID) {
    return _$getCommentListAsyncAction
        .run(() => super.getCommentList(userNickname, postID));
  }

  final _$_PostStoreActionController = ActionController(name: '_PostStore');

  @override
  void setSearch(dynamic value) {
    final _$actionInfo = _$_PostStoreActionController.startAction();
    try {
      return super.setSearch(value);
    } finally {
      _$_PostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleFavorite() {
    final _$actionInfo = _$_PostStoreActionController.startAction();
    try {
      return super.toggleFavorite();
    } finally {
      _$_PostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleShareOnFacebook() {
    final _$actionInfo = _$_PostStoreActionController.startAction();
    try {
      return super.toggleShareOnFacebook();
    } finally {
      _$_PostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleShareOnTwitter() {
    final _$actionInfo = _$_PostStoreActionController.startAction();
    try {
      return super.toggleShareOnTwitter();
    } finally {
      _$_PostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleShareOnTumblr() {
    final _$actionInfo = _$_PostStoreActionController.startAction();
    try {
      return super.toggleShareOnTumblr();
    } finally {
      _$_PostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPostDescription(dynamic value) {
    final _$actionInfo = _$_PostStoreActionController.startAction();
    try {
      return super.setPostDescription(value);
    } finally {
      _$_PostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPostLocation(dynamic value) {
    final _$actionInfo = _$_PostStoreActionController.startAction();
    try {
      return super.setPostLocation(value);
    } finally {
      _$_PostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setFocus(dynamic value) {
    final _$actionInfo = _$_PostStoreActionController.startAction();
    try {
      return super.setFocus(value);
    } finally {
      _$_PostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setUnfocusNode() {
    final _$actionInfo = _$_PostStoreActionController.startAction();
    try {
      return super.setUnfocusNode();
    } finally {
      _$_PostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String formatDateTime(DateTime datetime) {
    final _$actionInfo = _$_PostStoreActionController.startAction();
    try {
      return super.formatDateTime(datetime);
    } finally {
      _$_PostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String formatDateTimeActivity(DateTime datetime) {
    final _$actionInfo = _$_PostStoreActionController.startAction();
    try {
      return super.formatDateTimeActivity(datetime);
    } finally {
      _$_PostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic togglePostItemLike(int index) {
    final _$actionInfo = _$_PostStoreActionController.startAction();
    try {
      return super.togglePostItemLike(index);
    } finally {
      _$_PostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setUserPost(String postImageURL) {
    final _$actionInfo = _$_PostStoreActionController.startAction();
    try {
      return super.setUserPost(postImageURL);
    } finally {
      _$_PostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setUserStorie(String postImageURL) {
    final _$actionInfo = _$_PostStoreActionController.startAction();
    try {
      return super.setUserStorie(postImageURL);
    } finally {
      _$_PostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setUserLike(String userNickname, String postID, {int index}) {
    final _$actionInfo = _$_PostStoreActionController.startAction();
    try {
      return super.setUserLike(userNickname, postID, index: index);
    } finally {
      _$_PostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setUserLikedPost(String postID, {int index}) {
    final _$actionInfo = _$_PostStoreActionController.startAction();
    try {
      return super.setUserLikedPost(postID, index: index);
    } finally {
      _$_PostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setActivity(
      String userNickname, String postID, String postImage, String type,
      {String comment}) {
    final _$actionInfo = _$_PostStoreActionController.startAction();
    try {
      return super
          .setActivity(userNickname, postID, postImage, type, comment: comment);
    } finally {
      _$_PostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic verifyLikedPosts(String postID) {
    final _$actionInfo = _$_PostStoreActionController.startAction();
    try {
      return super.verifyLikedPosts(postID);
    } finally {
      _$_PostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setComment(dynamic value) {
    final _$actionInfo = _$_PostStoreActionController.startAction();
    try {
      return super.setComment(value);
    } finally {
      _$_PostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPostComment(String userNickname, String postID) {
    final _$actionInfo = _$_PostStoreActionController.startAction();
    try {
      return super.setPostComment(userNickname, postID);
    } finally {
      _$_PostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getDescriptionLanguage() {
    final _$actionInfo = _$_PostStoreActionController.startAction();
    try {
      return super.getDescriptionLanguage();
    } finally {
      _$_PostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void translateToUserNativeLanguage(String bio) {
    final _$actionInfo = _$_PostStoreActionController.startAction();
    try {
      return super.translateToUserNativeLanguage(bio);
    } finally {
      _$_PostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void translateToOriginalLanguage() {
    final _$actionInfo = _$_PostStoreActionController.startAction();
    try {
      return super.translateToOriginalLanguage();
    } finally {
      _$_PostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'postDescription: ${postDescription.toString()},postLocation: ${postLocation.toString()},isPrivate: ${isPrivate.toString()},search: ${search.toString()},favorite: ${favorite.toString()},shareOnFacebook: ${shareOnFacebook.toString()},shareOnTwitter: ${shareOnTwitter.toString()},shareOnTumblr: ${shareOnTumblr.toString()},focus: ${focus.toString()},hasFocus: ${hasFocus.toString()},activityList: ${activityList.toString()},comment: ${comment.toString()},commentList: ${commentList.toString()},description: ${description.toString()},isForeignLanguage: ${isForeignLanguage.toString()},isTranslated: ${isTranslated.toString()},activityListGetter: ${activityListGetter.toString()},isCommentFormValid: ${isCommentFormValid.toString()},commentFromFirestore: ${commentFromFirestore.toString()}';
    return '{$string}';
  }
}
