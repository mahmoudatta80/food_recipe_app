import 'package:food_recipe_app/models/favourites_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Database? database;

  Future<Database?> createDatabase() async{
    if(database!=null) {
      return database;
    }else {
      String path = join(await getDatabasesPath(),'food.db');
      Database database = await openDatabase(
          path,
          version: 1,
          onCreate:(db,v) {
            return db.execute('CREATE TABLE favourites(image TEXT, itemId INTEGER, title Text)');
          }
      );
      return database;
    }
  }

  Future<int> insertToDatabase(FavouriteModel favouriteModel) async{
    Database? database = await createDatabase();
    return database!.insert('favourites', favouriteModel.toMap());
  }

  Future<List> readDatabase() async{
    Database? database = await createDatabase();
    return database!.query('favourites');
  }

  Future<int> deleteFromDatabase(int itemId) async{
    Database? database = await createDatabase();
    return database!.delete('favourites',where: 'itemId = ?',whereArgs: [itemId]);
  }
}