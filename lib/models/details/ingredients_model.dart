class Ingredients {
  String? name;

  Ingredients({this.name});

  factory Ingredients.fromJson(Map<String,dynamic> json) {
    return Ingredients(
      name: json['name'],
    );
  }
}