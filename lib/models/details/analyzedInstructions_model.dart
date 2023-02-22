import 'package:food_recipe_app/models/details/steps_model.dart';

class AnalyzedInstructionsModel {
  List<Steps>? steps;

  AnalyzedInstructionsModel({this.steps});

  factory AnalyzedInstructionsModel.fromJson(Map<String,dynamic> json) {
    return AnalyzedInstructionsModel(
      steps: List<Steps>.from(json['steps'].map((e)=>Steps.fromJson(e))),
    );
  }
}