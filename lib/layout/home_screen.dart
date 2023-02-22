import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_recipe_app/helper/dio_helper.dart';
import 'package:food_recipe_app/models/recipe/recipe_model.dart';
import 'package:food_recipe_app/modules/favourites.dart';
import 'package:food_recipe_app/modules/recipe.dart';

class HomeScreen extends StatefulWidget {
  int? currentIndex;
  HomeScreen({this.currentIndex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static RecipeModel? recipeModel;
  Map<int,bool> favourites = {};
  List<String> titles = ['Food List', 'Favourite Recipe', 'Hello World', 'Hello World', 'Hello World',];
  Future<int> getData() async{
    return await 2;
  }
  @override
  void initState() {
    super.initState();
    DioHelper.getFoodRecipe().then((value) {
      setState(() {
        recipeModel = RecipeModel.fromJson(value.data);
        recipeModel!.results.forEach((element) {
          favourites.addAll({
            element.id!:false,
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.menu_outlined,
            color: Colors.teal,
          ),
        ),
        title: Text(
          titles[widget.currentIndex!],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Colors.teal,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future:getData(),
        builder: (context, snapshot) {
          if(recipeModel==null||favourites=={}) {
            return Center(child: CircularProgressIndicator());
          }else {
            List<Widget> screens = [RecipeScreen(recipeModel: recipeModel!,), const FavouritesScreen(), const Center(child: Text('Hello World',style: TextStyle(color: Colors.teal,fontSize: 30,fontWeight: FontWeight.w600,),),), const Center(child: Text('Hello World',style: TextStyle(color: Colors.teal,fontSize: 30,fontWeight: FontWeight.w600,),),), const Center(child: Text('Hello World',style: TextStyle(color: Colors.teal,fontSize: 30,fontWeight: FontWeight.w600,),),),];
            return screens[widget.currentIndex!];
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(

        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: Colors.teal,
        selectedIconTheme:const IconThemeData(
          color: Colors.teal,
        ),
        unselectedIconTheme:const IconThemeData(
          color: Colors.black,
        ),
        elevation: 15,
        currentIndex: widget.currentIndex!,
        onTap: (index) {
          setState(() {
            widget.currentIndex = index;
          });
        },
        items:const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 28,
            ),
            label: '_____',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_outline,
              size: 25,
            ),
            label: '_____',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart_outlined,
              size: 25,
            ),
            label: '_____',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.info_outline_rounded,
              size: 25,
            ),
            label: '_____',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline_outlined,
              size: 28,
            ),
            label: '_____',
          ),
        ],
      ),
    );
  }
}
