class Activity {
  final String _userNickname;
  final String _userImage;
  final String _image;
  final DateTime _date;
  final String _type;
  final String _comment;

  Activity(this._userNickname, this._userImage, this._image, this._date, this._type, this._comment);

  String get userNickname => _userNickname;
  String get userImage => _userImage;
  String get image => _image;
  DateTime get date => _date;
  String get type => _type;
  String get comment => _comment;
}
