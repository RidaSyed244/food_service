// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:food_service/Payment%20Screens/AddPaymentMethod.dart';
import 'package:food_service/Search%20screens/Search_Food.dart';
import 'package:food_service/UserModel.dart';

import '../Search screens/search_PriceRange.dart';
import '../featuredItems.dart';
import '../filtertest.dart';

int selectedpriceRange = 0;
List<String> selectedCategoryNames = []; // Holds the selected category names
List<Map<String, dynamic>> matchingRestaurants = [];
final sc = '';
// class ButtonState extends StateNotifier<List<String>> {
//   ButtonState() : super(List.generate(, (index) => ""));
//   void clearData() {
//     state = List.generate(9, (index) => "");
//   }

//   void updateButton(int index, String data) {
//     state[index] = data;
//   }
// }

// final buttonStateProvider = StateNotifierProvider((ref) => ButtonState());
// final itemListProvider =
//     StateProvider<FilterButtons>((ref) => FilterButtons(text: ""));

// class ItemListNotifier extends StateNotifier {
//   ItemListNotifier() : super("");
//   void clear() {
//     state = FilterButtons(text: "");
//   }
// }
class ProductPrices {
  final int productPrice;
  final String? uid;

  ProductPrices({required this.productPrice, this.uid});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productPrice': productPrice,
      'uid': uid,
    };
  }

  factory ProductPrices.fromMap(Map<String, dynamic> map) {
    return ProductPrices(
      productPrice: map['productPrice'] as int,
      uid: map['uid'] != null ? map['uid'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductPrices.fromJson(String source) =>
      ProductPrices.fromMap(json.decode(source) as Map<String, dynamic>);
}

late Menu items = Menu(
  title: "Chicken Burger",
  price: 200,
  selectedSideItemId: '',
  sideItemsIds: '',
  sideItems: [],
  i: 0,
  sideItemNames: '',
  allSideItemssInMenu: [],
  sideItemsPrice: 0,
  image: "assets/images/burger.png",
  description: "Chicken Burger",
);
// final itemListNotifierProvider =
//     StateNotifierProvider((ref) => ItemListNotifier());

class Filters extends ConsumerStatefulWidget {
  const Filters({
    Key? key,
  }) : super(key: key);
  @override
  ConsumerState<Filters> createState() => _FiltersState();
}

class _FiltersState extends ConsumerState<Filters> {
// Holds the fetched restaurant information
  // fetchMatchingRestaurants() {
  //   // Step 2: Query the "Categories" collection to get matching documents
  //   final categoryQuery =
  //       FirebaseFirestore.instance.collectionGroup('Category');

  //   categoryQuery.get().then((querySnapshot) {
  //     final matchingCategories = querySnapshot.docs.where((doc) {
  //       final categoryData = doc.data();
  //       final categoryName = categoryData['CategoryName'];

  //       return selectedCategoryNames.contains(categoryName);
  //     });
  //     final matchingRestaurantDocIds = matchingCategories.map((doc) {
  //       final categoryData = doc.data();
  //       final restaurantDocId = categoryData['uid'];
  //       return restaurantDocId;
  //     }).toList();
  //     final restaurantQuery =
  //         FirebaseFirestore.instance.collection('All_Restraunts');

  //     restaurantQuery.get().then((querySnapshot) {
  //       final fetchedRestaurants = querySnapshot.docs.where((doc) {
  //         final restaurantDocId = doc.id;
  //         return matchingRestaurantDocIds.contains(restaurantDocId);
  //       }).map((doc) {
  //         final restaurantData = doc.data();
  //         return restaurantData;
  //       }).toList();
  //       setState(() {
  //         matchingRestaurants = fetchedRestaurants;
  //       });
  //     }).catchError((error) {
  //       print('Error fetching matching restaurants: $error');
  //     });
  //   }).catchError((error) {
  //     print('Error fetching matching categories: $error');
  //   });
  // }

  void toggleCategorySelection(String category) {
    setState(() {
      if (selectedCategoryNames.contains(category)) {
        selectedCategoryNames.remove(category);
      } else {
        selectedCategoryNames.add(category);
      }
    });
  }

  void addPriceRange(int priceRange) {
    setState(() {
      selectedpriceRange = priceRange;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Filters",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          // leading: IconButton(
          //   color: Colors.black,
          //   onPressed: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => AddPayementMethod(
          //                   i: 0,
          //                   itemsss: items,
          //                   subtotalForPayment: 0.0,
          //                 )));
          //   },
          //   icon: Icon(Icons.arrow_back_ios),
          // ),
        ),
        body: Container(
          // height: 900,
          padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "CATEGORIES",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                )
              ],
            ),
            // Container(
            //   height: 300,

            //   child: StaggeredGridView.countBuilder(
            //     crossAxisCount: 3,
            //     itemCount: filterText.length,
            //     itemBuilder: ((context, index) {
            //       return Column(
            //         children: [
            //           Container(
            //               height: 60,
            //               width: 10,
            //               color: Colors.grey,
            //               child: Center(
            //                   child: Text(
            //                 "${filterText[index].text}",
            //                 style: TextStyle(color: Colors.black),
            //               ))),
            //         ],
            //       );
            //     }),
            //     staggeredTileBuilder: (index) => index % 1 == 0
            //         ? StaggeredTile.count(2, 1)
            //         : StaggeredTile.count(1, 1),
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 400,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collectionGroup('Category')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  // if (snapshot.connectionState == ConnectionState.waiting) {
                  //   return Center(child: CircularProgressIndicator());
                  // }

                  if (snapshot.hasData) {
                    List<Category> categories = snapshot.data!.docs.map((doc) {
                      return Category(
                        uid: doc['uid'],
                        CategoryName: doc['CategoryName'],
                      );
                    }).toList();

                    return GridView.builder(
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisExtent: 60,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        ;

                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await categoryChangeColor(index);
                                print(firstContainerColor[index]);
                                toggleCategorySelection(
                                    category.CategoryName.toString());

                                print(selectedCategoryNames);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: firstContainerColor[
                                      index], // Use the color from the list

                                  borderRadius: BorderRadius.circular(8),
                                ),
                                height: 40,
                                width: 100,
                                child: Center(
                                  child: Text(
                                    category.CategoryName.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return Center(child: Text("  "));
                  }
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "PRICE RANGE",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                )
              ],
            ),
            Container(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: priceText.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  priceRangeChangeColor(index);
                                  addPriceRange(priceText[index].text);
                                  print(selectedpriceRange);
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => SearchFoods(
                                  //             productPrice: '',
                                  //             priceFilters:
                                  //                 priceText[index].text,
                                  //             filterCategories: [])));
                                  //             print(priceText[index].text);
                                },
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  child: CircleAvatar(
                                    radius: 35,
                                    backgroundColor: thirdContainerColor[index],
                                    child: Text(
                                      "${priceText[index].text}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      );
                    })),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Material(
                color: Color.fromRGBO(238, 167, 52, 1),
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
                child: MaterialButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchFoods(
                                  filterCategories: selectedCategoryNames,
                                  filterPriceRange: selectedpriceRange,
                                )));
                  },
                  minWidth: 330.0,
                  height: 10.0,
                  child: Text('APPLY FILTERS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                ),
              )
            ]),
          ]),
        ));
  }

  List<Color> thirdContainerColor =
      List.filled(priceText.length, Color.fromRGBO(241, 241, 241, 1));

  // void changeColor(index, _containerColor) {
  //   setState(() {
  //     if (_containerColor[index] == Color.fromRGBO(241, 241, 241, 1)) {
  //       _containerColor[index] = Color.fromRGBO(238, 167, 52, 1);
  //     } else {
  //       _containerColor[index] = Color.fromRGBO(241, 241, 241, 1);
  //     }
  //     ;
  //   });
  // }
  List<Color> firstContainerColor =
      List.filled(10000, Color.fromRGBO(241, 241, 241, 1));
  categoryChangeColor(
    int index,
    // List<Color> firstContainerColor
  ) {
    setState(() {
      if (firstContainerColor[index] == Color.fromRGBO(241, 241, 241, 1)) {
        firstContainerColor[index] = Color.fromRGBO(238, 167, 52, 1);
      } else {
        firstContainerColor[index] = Color.fromRGBO(241, 241, 241, 1);
      }
      ;
    });
  }

  void priceRangeChangeColor(int index) {
    setState(() {
      if (thirdContainerColor[index] == Color.fromRGBO(241, 241, 241, 1)) {
        thirdContainerColor[index] = Color.fromRGBO(238, 167, 52, 1);
      } else {
        thirdContainerColor[index] = Color.fromRGBO(241, 241, 241, 1);
      }
      ;
    });
  }

  bool isVisible1 = true;
  bool isVisible2 = true;
  bool isVisible3 = true;
  bool isClear1 = false;
  void toggleButtonText1() {
    setState(() {
      isClear1 = !isClear1;
    });
  }

  bool isClear2 = false;
  void toggleButtonText2() {
    setState(() {
      isClear2 = !isClear2;
    });
  }

  bool isClear3 = false;
  void toggleButtonText3() {
    setState(() {
      isClear3 = !isClear3;
    });
  }
}
