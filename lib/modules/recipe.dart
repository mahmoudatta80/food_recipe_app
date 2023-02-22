import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_app/helper/db_helper.dart';
import 'package:food_recipe_app/models/recipe/recipe_model.dart';
import 'package:food_recipe_app/modules/details.dart';
import 'package:food_recipe_app/helper/dio_helper.dart';

class RecipeScreen extends StatefulWidget {
  late RecipeModel recipeModel;
  RecipeScreen({required this.recipeModel,});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  bool isFavourite = false;
  DbHelper? helper;
  Map<int,bool> map={};
  @override
  void initState() {
    super.initState();
    helper=DbHelper();
    helper!.readDatabase().then((value) {
      value.forEach((element) {
        map.addAll({
          element['itemId']:true,
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Response>(
      future: DioHelper.getFoodRecipe(),
      builder: (context,AsyncSnapshot? snapshot) {
        if(widget.recipeModel==null||map==null) {
          return const Center(child: CircularProgressIndicator());
        }else {
          return GridView.builder(
            padding: const EdgeInsets.all(12,),
            physics: const BouncingScrollPhysics(),
            itemCount: widget.recipeModel.results.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 5,
            ),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 10,
                end: 10,
              ),
              child: InkWell(
                onTap:() {
                  setState(() {
                    isFavourite = false;
                  });
                  //print(map);
                  map.forEach((key, value) {
                    if(key==widget.recipeModel.results[index].id) {
                      setState(() {
                        isFavourite = true;
                      });
                    }
                  });
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                    builder: (context) => DetailsScreen(itmeId: widget.recipeModel.results[index].id!,isFavourite: isFavourite,id: widget.recipeModel.results[index].id,),
                  ),);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 130,
                      width: double.infinity,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15,),
                      ),
                      child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          '${widget.recipeModel.results[index].image}',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${widget.recipeModel.results[index].title}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
//
// print(favourites);
//.then((value) {

// setState(() {
// favourites[widget.recipeModel.results[index].id!]=true;
// });
// print(favourites[widget.recipeModel.results[index].id]);
// });
