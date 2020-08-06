class Comment{
  final String _nickname;
  final String _image;
  final String _content;
  final DateTime _date;
  final int _likes;
  //final List<Answer> _answers;

  Comment(this._nickname, this._image, this._content, this._date, this._likes, /*this._answers*/);
  
  String get nickname => _nickname; 
  String get image => _image; 
  String get content => _content;
  DateTime get date => _date;
  int get likes => _likes;
  //List<Answer> get answers => _answers;
}