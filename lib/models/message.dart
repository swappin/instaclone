class Message {
  final String _messageNickname;
  final String _messageContent;
  final DateTime _messageDate;

  Message(this._messageNickname, this._messageContent, this._messageDate);

  String get messageNickname => _messageNickname;
  String get messageContent => _messageContent;
  DateTime get messageDate => _messageDate;
}