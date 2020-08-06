class Chat {
  final String _chatNickname;
  final String _chatImage;
  final String _chatLastMessage;
  final DateTime _chatLastSeen;

  Chat(this._chatNickname, this._chatImage, this._chatLastMessage, this._chatLastSeen);

  String get chatNickname => _chatNickname;
  String get chatImage => _chatImage;
  String get chatLastMessage => _chatLastMessage;
  DateTime get chatLastSeen => _chatLastSeen;
}