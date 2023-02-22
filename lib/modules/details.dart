import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_recipe_app/helper/db_helper.dart';
import 'package:food_recipe_app/helper/dio_helper.dart';
import 'package:food_recipe_app/layout/home_screen.dart';
import 'package:food_recipe_app/models/details/details_model.dart';
import 'package:food_recipe_app/models/favourites_model.dart';

class DetailsScreen extends StatefulWidget {
  late final int itmeId;
  bool? isFavourite;
  int? id;

  DetailsScreen({required this.itmeId,this.isFavourite,this.id});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  DetailsModel? detailsModel;
  DbHelper? helper = DbHelper();
  List? favourite;

  @override
  void initState() {
    super.initState();
    DioHelper.getFoodRecipeDetails(widget.itmeId).then((value) {
      detailsModel = DetailsModel.fromJson(value.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle:const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen(),), (route) => false);
          },
          icon:const Icon(
            Icons.arrow_back_outlined,
            color: Colors.teal,
          ),
        ),
        actions: [
          widget.isFavourite!?IconButton(
            onPressed: () {
              setState(() {
                helper!.deleteFromDatabase(widget.id!);
                widget.isFavourite=false;
              });
            },
            icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 20,
                  ),
          ):IconButton(
            onPressed: () {
              setState(() {
                FavouriteModel favouriteModel = FavouriteModel({'image':detailsModel!.image,'title':detailsModel!.title,'itemId':widget.itmeId});
                helper!.insertToDatabase(favouriteModel);
                widget.isFavourite=true;
              });
            },
            icon:const Icon(
            Icons.favorite_outline,
            color: Colors.black,
            size: 20,
          ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.play_arrow_outlined,
              color: Colors.black,
              size: 26,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black,
              size: 20,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.share_outlined,
              color: Colors.black,
              size: 20,
            ),
          ),
        ],
      ),
      body: FutureBuilder<Response>(
        future: DioHelper.getFoodRecipeDetails(widget.itmeId),
        builder: (context, AsyncSnapshot? snapshot) {
          if (detailsModel == null ) {
            return Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        '${detailsModel!.image}',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${detailsModel!.title}',
                          style: TextStyle(
                            color: Colors.teal,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 1,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  'Easy',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.av_timer_outlined,
                                    size: 20,
                                    color: Colors.teal,
                                  ),
                                  Text(
                                    '${detailsModel!.readyInMinutes} mins',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    '${detailsModel!.analyzedInstructions![0].steps!.length}',
                                    style: TextStyle(
                                      color: Colors.teal,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'ingridients',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 1,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '${detailsModel!.winePairing!.pairingText}',
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 7,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 1,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${detailsModel!.servings} Serving',
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                  border: Border.all(
                                    color: Colors.teal,
                                    width: 1.5,
                                  ),
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.black54,
                                  size: 18,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 14,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                  border: Border.all(
                                    color: Colors.teal,
                                    width: 1.5,
                                  ),
                                ),
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.black54,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Container(
                          height: 1,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Ingridients',
                              style: TextStyle(
                                color: Colors.teal,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                height: 25,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                  border: Border.all(
                                    color: Colors.teal,
                                    width: 1.5,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Add To Grocery ',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 1,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListView.separated(
                          physics: BouncingScrollPhysics(),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 14,
                          ),
                          shrinkWrap: true,
                          itemCount: detailsModel!
                              .analyzedInstructions![0].steps!.length,
                          itemBuilder: (context, index) => Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.teal,
                                ),
                                height: 10,
                                width: 10,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                detailsModel!
                                            .analyzedInstructions![0]
                                            .steps![index]
                                            .ingredients!
                                            .length !=
                                        0
                                    ? '${detailsModel!.analyzedInstructions![0].steps![index].ingredients![0].name}'
                                    : 'Pasta',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
