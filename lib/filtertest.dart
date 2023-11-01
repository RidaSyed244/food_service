// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_service/Search%20screens/Search_Food.dart';
import 'package:food_service/UserModel.dart';

class Category {
  final String? CategoryName;
  final String? uid;

  Category({this.CategoryName, this.uid});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'CategoryName': CategoryName,
      'uid': uid,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      CategoryName:
          map['CategoryName'] != null ? map['CategoryName'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);
}

class TestFilters extends StatefulWidget {
  final String? storeId;

  const TestFilters({Key? key, this.storeId}) : super(key: key);

  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<TestFilters> {
  void filterRestaurantsByCategory(String restaurantId) {
    FirebaseFirestore.instance
        .collection('All_Restaurants')
        .doc(restaurantId)
        .get()
        .then((doc) {
      if (doc.exists) {
        AllRestraunts restaurant = AllRestraunts(
          uid: doc["uid"],
          restraunt_logo: doc["restraunt_logo"],
          restaurant_name: doc['restaurant_name'],
        );

        return restaurant;

        // Display the restaurant details on the screen
        // showRestaurantDetails(restaurant);
      }
    }).catchError((error) {
      print('Error: $error');

      return error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ...

      body: Container(
        height: 900,
        padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
        child: ListView(
          children: [
            // ...

            Visibility(
              // visible: isVisible1,
              child: Container(
                height: 400,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collectionGroup('Category')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                      List<Category> categories =
                          snapshot.data!.docs.map((doc) {
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
                        // ...

                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];

                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  filterRestaurantsByCategory(
                                      category.uid.toString());
                                  print(category.uid);
                                  // Navigator.push(
                                  //    context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => SearchFoods(
                                  //               filterCategories:
                                  //                    category.uid.toString(),
                                  //             )));
                                },
                                child: Container(
                                  // ...
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
                      return Center(child: Text("No Data Found"));
                    }
                  },
                ),
              ),
            ),

            // ...
          ],
        ),
      ),
    );
  }
}
