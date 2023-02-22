class Results {
  int? id;
  String? title;
  String? image;

  Results({this.id,this.title,this.image});

  factory Results.fromJson(Map<String,dynamic> json) {
    return Results(
      id: json['id'],
      title: json['title'],
      image: json['image'],
    );
  }
}