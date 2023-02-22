class FavouriteModel {
  String? image;
  String? title;
  int? itemId;

  FavouriteModel(dynamic obj) {
    image = obj['image'];
    title = obj['title'];
    itemId = obj['itemId'];
  }

  FavouriteModel.fromMap(Map<String , dynamic> map)
  {
    image = map['image'];
    title = map['title'];
    itemId = map['itemId'];
  }

  Map<String,dynamic> toMap() => {'image':image,'title':title,'itemId':itemId};
}