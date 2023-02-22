import 'package:food_recipe_app/models/recipe/results_model.dart';

class RecipeModel {
  late final List<Results> results;

  RecipeModel({required this.results});

  factory RecipeModel.fromJson(Map<String,dynamic> json) {
    return RecipeModel(
      results: List<Results>.from(json['results'].map((e)=>Results.fromJson(e))),
    );
  }

  Map<String,dynamic> toMap()=> {'results':results};
}