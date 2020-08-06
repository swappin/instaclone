// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatStore on _ChatStore, Store {
  Computed<bool> _$isCommentFormValidComputed;

  @override
  bool get isCommentFormValid => (_$isCommentFormValidComputed ??=
          Computed<bool>(() => super.isCommentFormValid))
      .value;
  Computed<List<Chat>> _$chatListGetterComputed;

  @override
  List<Chat> get chatListGetter => (_$chatListGetterComputed ??=
          Computed<List<Chat>>(() => super.chatListGetter))
      .value;
  Computed<List<Message>> _$messageListGetterComputed;

  @override
  List<Message> get messageListGetter => (_$messageListGetterComputed ??=
          Computed<List<Message>>(() => super.messageListGetter))
      .value;
  Computed<bool> _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid)).value;

  final _$messageAtom = Atom(name: '_ChatStore.message');

  @override
  String get message {
    _$messageAtom.context.enforceReadPolicy(_$messageAtom);
    _$messageAtom.reportObserved();
    return super.message;
  }

  @override
  set message(String value) {
    _$messageAtom.context.conditionallyRunInAction(() {
      super.message = value;
      _$messageAtom.reportChanged();
    }, _$messageAtom, name: '${_$messageAtom.name}_set');
  }

  final _$_chatListAtom = Atom(name: '_ChatStore._chatList');

  @override
  ObservableList<Chat> get _chatList {
    _$_chatListAtom.context.enforceReadPolicy(_$_chatListAtom);
    _$_chatListAtom.reportObserved();
    return super._chatList;
  }

  @override
  set _chatList(ObservableList<Chat> value) {
    _$_chatListAtom.context.conditionallyRunInAction(() {
      super._chatList = value;
      _$_chatListAtom.reportChanged();
    }, _$_chatListAtom, name: '${_$_chatListAtom.name}_set');
  }

  final _$_messageListAtom = Atom(name: '_ChatStore._messageList');

  @override
  ObservableList<Message> get _messageList {
    _$_messageListAtom.context.enforceReadPolicy(_$_messageListAtom);
    _$_messageListAtom.reportObserved();
    return super._messageList;
  }

  @override
  set _messageList(ObservableList<Message> value) {
    _$_messageListAtom.context.conditionallyRunInAction(() {
      super._messageList = value;
      _$_messageListAtom.reportChanged();
    }, _$_messageListAtom, name: '${_$_messageListAtom.name}_set');
  }

  final _$addMessageAsyncAction = AsyncAction('addMessage');

  @override
  Future addMessage(String targetUserNickname, String userImage) {
    return _$addMessageAsyncAction
        .run(() => super.addMessage(targetUserNickname, userImage));
  }

  final _$_ChatStoreActionController = ActionController(name: '_ChatStore');

  @override
  void setMessage(String value) {
    final _$actionInfo = _$_ChatStoreActionController.startAction();
    try {
      return super.setMessage(value);
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic buildChatList() {
    final _$actionInfo = _$_ChatStoreActionController.startAction();
    try {
      return super.buildChatList();
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getChatMessages(String userNickname) {
    final _$actionInfo = _$_ChatStoreActionController.startAction();
    try {
      return super.getChatMessages(userNickname);
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'message: ${message.toString()},isCommentFormValid: ${isCommentFormValid.toString()},chatListGetter: ${chatListGetter.toString()},messageListGetter: ${messageListGetter.toString()},isFormValid: ${isFormValid.toString()}';
    return '{$string}';
  }
}
