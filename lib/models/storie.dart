class Storie {
  final String storieUserNickname;
  final String storieUserImage;
  bool storieWatched = false;
  List<StorieItem> storieItemList;

  Storie({this.storieUserNickname, this.storieUserImage, this.storieWatched, this.storieItemList});
}

class StorieItem extends Storie{
  final String storieImage;
  final DateTime storieDate;

  StorieItem({this.storieImage, this.storieDate});
}
