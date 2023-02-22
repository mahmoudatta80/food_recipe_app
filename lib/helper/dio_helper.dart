import 'package:dio/dio.dart';

//Food Recipe
//https://api.spoonacular.com/recipes/complexSearch?apiKey=031595a21d0e4864a9a766fe0ca38276&query=pasta

//Food Recipe Details
//https://api.spoonacular.com/recipes/654959/information?query=pasta&apiKey=031595a21d0e4864a9a766fe0ca38276

class DioHelper {
  static late Dio dio;
  static late Dio dioDetails;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.spoonacular.com/',
        receiveDataWhenStatusError: true,
      ),
    );
    dioDetails = Dio(
      BaseOptions(
        baseUrl: 'https://api.spoonacular.com/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getFoodRecipe() async{
    return await dio.get(
      'recipes/complexSearch',
      queryParameters: {
        'apiKey':'a68349fc14574d3eb07067130ae6bd07',
        'query':'pasta',
      }
    );
  }

  static Future<Response> getFoodRecipeDetails(int id) async{
    return await dio.get(
        'recipes/$id/information',
        queryParameters: {
          'apiKey':'a68349fc14574d3eb07067130ae6bd07',
          'query':'pasta',
        }
    );
  }
}