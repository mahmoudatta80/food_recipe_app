import 'package:flutter/material.dart';
import 'package:food_recipe_app/helper/db_helper.dart';
import 'package:food_recipe_app/models/favourites_model.dart';
import 'package:food_recipe_app/modules/details.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);


  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  DbHelper? helper = DbHelper();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: helper!.readDatabase(),
      builder: (context,AsyncSnapshot? snapshot) {
        if(!snapshot!.hasData) {
          return Center(child: CircularProgressIndicator());
        }else {
          return GridView.builder(
            padding: const EdgeInsets.all(12,),
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.data.length,
            gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 5,
            ),
            itemBuilder: (context, index) {
              FavouriteModel favouriteModel = FavouriteModel.fromMap(snapshot.data[index]);
              return Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 10,
                  end: 10,
                ),
                child: InkWell(
                  onTap:() {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                      builder: (context) => DetailsScreen(itmeId: favouriteModel.itemId! , isFavourite: true,id: favouriteModel.itemId,),
                    ),);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            height: 130,
                            width: double.infinity,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10,),
                            ),
                            child:Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                '${favouriteModel.image}',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CircleAvatar(
                              radius: 17,
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: ()
                                {
                                  setState(() {
                                    helper!.deleteFromDatabase(favouriteModel.itemId!);
                                  });
                                },
                                icon:const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${favouriteModel.title}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
