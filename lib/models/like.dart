
class Like{
  final String _nickname;
  final String _image;
  final DateTime _date;
  //final List<Answer> _answers;

  Like(this._nickname, this._image, this._date, /*this._answers*/);

  String get nickname => _nickname;
  String get image => _image;
  DateTime get date => _date;
//List<Answer> get answers => _answers;
}