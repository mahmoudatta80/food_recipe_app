import 'package:food_recipe_app/models/details/analyzedInstructions_model.dart';
import 'package:food_recipe_app/models/details/winepairing_model.dart';

class DetailsModel {
  String? title;
  int? readyInMinutes;
  int? servings;
  String? image;
  List<AnalyzedInstructionsModel>? analyzedInstructions;
  WinePairing? winePairing;

  DetailsModel({this.title,this.readyInMinutes,this.servings,this.image,this.analyzedInstructions,this.winePairing});

  factory DetailsModel.fromJson(Map<String,dynamic> json) {
    return DetailsModel(
      title: json['title'],
      readyInMinutes: json['readyInMinutes'],
      servings: json['servings'],
      image: json['image'],
      analyzedInstructions: List<AnalyzedInstructionsModel>.from(json['analyzedInstructions'].map((e)=>AnalyzedInstructionsModel.fromJson(e))),
      winePairing:json['winePairing']!=null? WinePairing.fromJson(json['winePairing']):null,
    );
  }
}