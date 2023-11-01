import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:food_service/Home%20Screens/Single_Restraunt.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:food_service/Search%20screens/Browse_food.dart';
import 'package:food_service/Search%20screens/Searching_food.dart';
import '../UserModel.dart';
import '../user.dart';

class Products {
  final int productPrice;
  final String? uid;

  Products({required this.productPrice, this.uid});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productPrice': productPrice,
      'uid': uid,
    };
  }

  factory Products.fromMap(Map<String, dynamic> map) {
    return Products(
      productPrice: map['productPrice'] as int,
      uid: map['uid'] != null ? map['uid'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Products.fromJson(String source) =>
      Products.fromMap(json.decode(source) as Map<String, dynamic>);
}

class SearchFoods extends ConsumerStatefulWidget {
  const SearchFoods({
    Key? key,
    required this.filterCategories,
    required this.filterPriceRange,
  }) : super(key: key);
  final List<String> filterCategories;
  final int filterPriceRange;

  @override
  ConsumerState<SearchFoods> createState() => _SearchFoodsState();
}

class _SearchFoodsState extends ConsumerState<SearchFoods> {
  int bottomNavIndex = 0;
  Stream? _stream;
  Stream? _resultStream;

  @override
  void initState() {
    super.initState();
    _resultStream = getFilteredRestaurantsStream();

    _stream = getFilteredRestaurantsStream();
  }

  Stream getFilteredRestaurantsStream() async* {
    try {
      QuerySnapshot productsSnapshot =
          await FirebaseFirestore.instance.collectionGroup('Products').get();
      QuerySnapshot restaurantsSnapshot =
          await FirebaseFirestore.instance.collection('All_Restraunts').get();
      QuerySnapshot categoriesSnapshot =
          await FirebaseFirestore.instance.collectionGroup('Category').get();

      List<String> filteredRestaurantUids = [];

      if (productsSnapshot.docs.isNotEmpty) {
        productsSnapshot.docs.forEach((productDoc) {
          String restaurantUid = productDoc['uid'];
          // int productPrice = productDoc['productPrice'];

          if (!filteredRestaurantUids.contains(restaurantUid)) {
            filteredRestaurantUids.add(restaurantUid);
          }
        });
      }

      filteredRestaurantUids.removeWhere((restaurantUid) {
        bool hasSelectedCategories = false;
        categoriesSnapshot.docs.forEach((categoryDoc) {
          if (categoryDoc['uid'] == restaurantUid &&
              widget.filterCategories.contains(categoryDoc['CategoryName'])) {
            hasSelectedCategories = true;
          }
        });

        // Calculate total price and product count for the current restaurant
        num totalPrice = 0;
        int productCount = 0;

        productsSnapshot.docs.forEach((productDoc) {
          if (productDoc['uid'] == restaurantUid) {
            totalPrice += productDoc['productPrice'];
            productCount++;
          }
        });

        num averagePrice = totalPrice / productCount;

        if ((!widget.filterCategories.isEmpty && !hasSelectedCategories) ||
            (widget.filterPriceRange > 0 &&
                averagePrice > widget.filterPriceRange)) {
          return true; // Remove restaurant if it doesn't have selected categories or its average price is higher than the selected price range
        }

        return false;
      });

      List<QueryDocumentSnapshot> filteredRestaurants =
          restaurantsSnapshot.docs.where((restaurantDoc) {
        return filteredRestaurantUids.contains(restaurantDoc.id);
      }).toList();

      yield filteredRestaurants.isEmpty ? null : filteredRestaurants;
    } catch (error) {
      // Handle the error
      print('Error: $error');
      yield null;
    }
  }

  @override
  void dispose() {
    _stream;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fetchCategories = ref.watch(providerrr);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 01,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Results",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Column(
            children: [
              StreamBuilder(
                  stream: _resultStream,
                  builder: (context, snapshot) {
                    List<QueryDocumentSnapshot>? restaurants =
                        snapshot.data as List<QueryDocumentSnapshot>?;
                    return Text(
                      "We have found ${restaurants?.length ?? 0} results according\nto your choice. ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500),
                    );
                  }),
              SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  StreamBuilder(
                    stream: _stream,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.hasError) {
                        print(snapshot.error);

                        return Center(
                          child: Text(
                            "${snapshot.error}",
                          ),
                        );
                      }
                      if (!snapshot.hasData || snapshot.data == null) {
                        // Handle the case when snapshot.data is null
                        return Center(
                          child: Text(
                            "No data found",
                          ),
                        );
                      }

                      List<QueryDocumentSnapshot>? restaurants =
                          snapshot.data as List<QueryDocumentSnapshot>?;

                      if (snapshot.hasData) {
                        return fetchCategories.when(data: (data) {
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                GridView.builder(
                                  shrinkWrap: true, // Important
                                  physics:
                                      NeverScrollableScrollPhysics(), // Important

                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: 340,
                                    mainAxisSpacing: 5,
                                    crossAxisSpacing: 3,
                                  ),
                                  itemCount: restaurants!.length,
                                  itemBuilder: (context, index) {
                                    QueryDocumentSnapshot restaurantDoc =
                                        restaurants[index];
                                    final restrauntDocId = restaurants[index];
                                    // AllRestraunts categories =
                                    //     AllRestraunts.fromMap(
                                    //         data.docs[index].data());
                                    return Container(
                                      height: 350,
                                      child: Column(
                                        children: [
                                          Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Container(
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                SingleRestraunt(
                                                              time: restaurantDoc[
                                                                      "deliver_time"]
                                                                  .toString(),
                                                              free: restaurantDoc[
                                                                      "deliver_charges"]
                                                                  .toString(),
                                                              token: restaurantDoc[
                                                                      "token"]
                                                                  .toString(),

                                                              categories:
                                                                  restaurantDoc[
                                                                          "CategoryName"]
                                                                      .toString(),
                                                              latitude:
                                                                  restaurantDoc[
                                                                      "latitude"],
                                                              longitude:
                                                                  restaurantDoc[
                                                                      "longitude"],
                                                              orderType:
                                                                  restaurantDoc[
                                                                          "OrderType"]
                                                                      .toString(),
                                                              storeIndexId: 0,
                                                              // g  categories: categories
                                                              //       .CategoryName.toStrin(),
                                                              title: restaurantDoc[
                                                                      "restaurant_name"]
                                                                  .toString(),
                                                              image: restaurantDoc[
                                                                      "restraunt_logo"]
                                                                  .toString(),
                                                              // time:
                                                              //     restaurantDoc["deliver_time"]
                                                              //         .toString(),
                                                              // free: restaurantDoc[
                                                              //         "deliver_charges"]
                                                              //     .toString(),
                                                              currency: restaurantDoc[
                                                                      "restraunt_currency"]
                                                                  .toString(),
                                                              storeId:
                                                                  restrauntDocId
                                                                      .id,
                                                              restrauntLocation:
                                                                  restaurantDoc[
                                                                          "restaurant_address"]
                                                                      .toString(),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        height: 280,
                                                        // width: 300,
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image: NetworkImage(
                                                              restaurantDoc[
                                                                      "restraunt_logo"]
                                                                  .toString(),
                                                            ),
                                                            colorFilter:
                                                                ColorFilter
                                                                    .mode(
                                                              Colors.black
                                                                  .withOpacity(
                                                                      0.4),
                                                              BlendMode.darken,
                                                            ),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                                  10, 0, 0, 20),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .lock_clock,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Text(
                                                                    "${restaurantDoc["deliver_time"] == null ? "" : restaurantDoc["deliver_time"]}",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            11),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 3,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Icon(
                                                                          Icons
                                                                              .donut_small_sharp,
                                                                          color:
                                                                              Colors.white),
                                                                      SizedBox(
                                                                        width:
                                                                            4,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            "${restaurantDoc["deliver_charges"] == null ? "" : restaurantDoc["deliver_charges"]}",
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontSize: 11),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      // SizedBox(
                                                                      //   width: 60,
                                                                      // ),
                                                                      // Row(
                                                                      //   children: [
                                                                      //     Container(
                                                                      //         height: 23,
                                                                      //         width: 35,
                                                                      //         decoration:
                                                                      //             BoxDecoration(
                                                                      //           color: Color
                                                                      //               .fromRGBO(
                                                                      //                   238,
                                                                      //                   167,
                                                                      //                   52,
                                                                      //                   1),
                                                                      //           borderRadius:
                                                                      //               BorderRadius
                                                                      //                   .circular(4),
                                                                      //         ),
                                                                      //         child: Center(
                                                                      //             child: Text(
                                                                      //                 "4.5",
                                                                      //                 style: TextStyle(
                                                                      //                     color: Colors.white,
                                                                      //                     fontSize: 13)))),
                                                                      //   ],
                                                                      // ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 10.0),
                                                        child: Text(
                                                          "${restaurantDoc["restaurant_name"]}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  // SizedBox(
                                                  //   height: 5,
                                                  // ),
                                                  // Row(
                                                  //   children: [
                                                  //     Row(
                                                  //       mainAxisAlignment:
                                                  //           MainAxisAlignment.start,
                                                  //       children: [
                                                  //         if (restaurantDoc[
                                                  //                     "restraunt_About"] !=
                                                  //                 null)
                                                  //         Padding(
                                                  //           padding:
                                                  //               const EdgeInsets.only(
                                                  //                   left: 10.0),
                                                  //           child: Text(
                                                  //             "${restaurantDoc["restraunt_About"]==null?"":restaurantDoc["restraunt_About"]}",
                                                  //             style: TextStyle(
                                                  //               color: Colors.grey,
                                                  //               fontSize: 15,
                                                  //             ),
                                                  //           ),
                                                  //         ),
                                                  //       ],
                                                  //     ),
                                                  // SizedBox(
                                                  //   width: 20,
                                                  // ),
                                                  // Row(
                                                  //   children: [
                                                  //     Icon(
                                                  //       Icons.circle,
                                                  //       color: Colors.grey,
                                                  //       size: 4,
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                  // Row(
                                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                                  //   children: [
                                                  //     Padding(
                                                  //       padding:
                                                  //           const EdgeInsets.only(left: 10.0),
                                                  //       child: Text(
                                                  //         "${browseFood[index].area}",
                                                  //         style: TextStyle(
                                                  //           color: Colors.grey,
                                                  //           fontSize: 15,
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                  //   ],
                                                  // ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        }, error: (error, stackTrace) {
                          return Center(
                            child: Text(
                              "Error: $error",
                            ),
                          );
                        }, loading: () {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                      } else {
                        return Center(child: Text("No data found"));
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
