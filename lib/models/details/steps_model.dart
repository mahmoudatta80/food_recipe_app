import 'package:food_recipe_app/models/details/ingredients_model.dart';

class Steps {
  List<Ingredients>? ingredients;

  Steps({this.ingredients});

  factory Steps.fromJson(Map<String,dynamic> json) {
    return Steps(
      ingredients: List<Ingredients>.from(json['ingredients'].map((e)=>Ingredients.fromJson(e))),
    );
  }
}