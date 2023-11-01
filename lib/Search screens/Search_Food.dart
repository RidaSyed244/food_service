// // ignore_for_file: unused_element

// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// import 'package:food_service/Search%20screens/Browse_food.dart';
// import 'package:food_service/Search%20screens/Searching_food.dart';
// import 'package:rxdart/rxdart.dart';

// import '../UserModel.dart';

// class Products {
//   final int productPrice;
//   final String? uid;

//   Products({required this.productPrice, this.uid});

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'productPrice': productPrice,
//       'uid': uid,
//     };
//   }

//   factory Products.fromMap(Map<String, dynamic> map) {
//     return Products(
//       productPrice: map['productPrice'] as int,
//       uid: map['uid'] != null ? map['uid'] as String : null,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Products.fromJson(String source) =>
//       Products.fromMap(json.decode(source) as Map<String, dynamic>);
// }

// class SearchFoods extends ConsumerStatefulWidget {
//   const SearchFoods({
//     Key? key,
//     required this.filterCategories,
//     required this.productPrice,
//     required this.priceFilters,
//   }) : super(key: key);
//   final List filterCategories;
//   final priceFilters;
//   final productPrice;

//   @override
//   ConsumerState<SearchFoods> createState() => _SearchFoodsState();
// }

// class _SearchFoodsState extends ConsumerState<SearchFoods> {
//   int bottomNavIndex = 0;
//   Future<List<AllRestraunts>> filterAndSortRestaurants(
//       double minPrice, double maxPrice) async {
//     List<AllRestraunts> restaurants = [];

//     // Filter by category
//     QuerySnapshot categorySnapshot = await FirebaseFirestore.instance
//         .collection('All_Restraunts')
//         .where('uid', isEqualTo: widget.filterCategories)
//         .orderBy('status')
//         .get();

//     for (QueryDocumentSnapshot categoryDoc in categorySnapshot.docs) {
//       String restaurantUid = categoryDoc['uid'];

//       // Filter by price range
//       QuerySnapshot productSnapshot = await FirebaseFirestore.instance
//           .collection('Products')
//           .where('uid', isEqualTo: restaurantUid)
//           .get();

//       List<int> productPrices = productSnapshot.docs
//           .map((doc) =>
//               Products.fromMap(doc.data() as Map<String, dynamic>).productPrice)
//           .toList();

//       double averagePrice = productPrices.isNotEmpty
//           ? productPrices.reduce((a, b) => a + b) / productPrices.length
//           : 0;

//       if (averagePrice >= minPrice && averagePrice <= maxPrice) {
//         QuerySnapshot restaurantSnapshot = await FirebaseFirestore.instance
//             .collection('All_Restraunts')
//             .where('uid', isEqualTo: restaurantUid)
//             .get();

//         for (QueryDocumentSnapshot restaurantDoc in restaurantSnapshot.docs) {
//           String restaurantName = restaurantDoc['restaurant_name'];
//           restaurants.add(AllRestraunts(
//               uid: restaurantUid, restaurant_name: restaurantName));
//         }
//       }
//     }

//     return restaurants;
//   }

//   // calculateAveragePrice(List<Products> products, restaurantUid) async {
//   //   double totalPrice = 0;
//   //   for (var product in products) {
//   //     List<int> productPrices = await fetchProductPrices(restaurantUid);
//   //     double averagePrice = productPrices.isNotEmpty
//   //         ? productPrices.reduce((a, b) => a + b) / productPrices.length
//   //         : 0;
//   //     sortedRestaurants
//   //         .add(AllRestraunts(uid: restaurantUid, averagePrice: averagePrice));
//   //   }
//   //   return totalPrice / products.length;
//   // }

//   fetchProductPrices(String restaurantUid) async {
//     QuerySnapshot<Map<String, dynamic>> productSnapshot =
//         await FirebaseFirestore.instance
//             .collection('Products')
//             .where('uid', isEqualTo: restaurantUid)
//             .get();
//     List<int> productPrices = productSnapshot.docs
//         .map((doc) => Products.fromMap(doc.data()).productPrice)
//         .toList();
//     return productPrices;
//   }

//   Stream<List<QuerySnapshot>> _getRestaurantsStream(List<String> uids) {
//     final streamControllers = uids
//         .map((uid) => FirebaseFirestore.instance
//             .collection('All_Restraunts')
//             .where('uid', isEqualTo: uid)
//             .snapshots())
//         .toList();
//     return CombineLatestStream.list<QuerySnapshot>(streamControllers);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.white,
//           leading: IconButton(
//             color: Colors.black,
//             onPressed: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => SearchingFood()));
//             },
//             icon: Icon(Icons.search),
//           ),
//           title: Text(
//             "Search",
//             style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 25.0,
//                 fontWeight: FontWeight.w500),
//           ),
//         ),
//         body: Container(
//           padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
//           child: ListView(children: [
//             Text(
//               "Top Categories",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 19,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Column(mainAxisAlignment: MainAxisAlignment.start, children: [
//               Container(
//                   height: 620,
//                   child: StreamBuilder(
//                       stream: FirebaseFirestore.instance
//                           .collectionGroup('Category')
//                           .where('CategoryName',
//                               whereIn: widget.filterCategories)
//                           .snapshots(),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return Center(
//                             child: CircularProgressIndicator(),
//                           );
//                         }

//                         if (snapshot.hasError) {
//                           print(snapshot.error);

//                           return Center(
//                             child: Text(
//                               "${snapshot.error}",
//                             ), // Replace with your preferred loading indicator
//                           );
//                         }
//                         if (snapshot.hasData) {
//                           final extractedUids = snapshot.data!.docs
//                               .map<String>((doc) => doc.data()['uid'])
//                               .toList();

//                           return StreamBuilder(
//                             stream: _getRestaurantsStream(extractedUids),
//                             builder: (context, snapshot) {
//                               if (snapshot.connectionState ==
//                                   ConnectionState.waiting) {
//                                 return Center(
//                                   child: CircularProgressIndicator(),
//                                 );
//                               }

//                               if (snapshot.hasData) {
//                                 final restaurantDataList = [];
//                                 for (final snapshot
//                                     in snapshot.data as List<QuerySnapshot>) {
//                                   restaurantDataList.addAll(snapshot.docs.map(
//                                       (doc) =>
//                                           doc.data() as Map<String, dynamic>));
//                                 }
//                                 // final filteredRestaurantDataList =
//                                 //     restaurantDataList.where((restaurantData) {
//                                 //   // Calculate average price of products for the restaurant
//                                 //   QuerySnapshot productSnapshot = FirebaseFirestore
//                                 //           .instance
//                                 //           .collectionGroup('Products')
//                                 //           .where('uid',
//                                 //               isEqualTo: restaurantData['uid'])
//                                 //           .get()
//                                 //       as QuerySnapshot<Map<String, dynamic>>;
//                                 //   List<int> productPrices = productSnapshot.docs
//                                 //       .map((doc) => Products.fromMap(
//                                 //               doc.data() as Map<String, dynamic>)
//                                 //           .productPrice)
//                                 //       .toList();

//                                 //   double averagePrice = productPrices.isNotEmpty
//                                 //       ? productPrices
//                                 //               .toList()
//                                 //               .reduce((a, b) => a + b) /
//                                 //           productPrices.length
//                                 //       : 0;

//                                 //   return averagePrice >= widget.priceFilters;
//                                 // }).toList();
//                                 // if (filteredRestaurantDataList.isEmpty) {
//                                 //   return Text(
//                                 //       'No restaurant data found for the selected categories and price range.');
//                                 // }
//                                 return Column(
//                                   children: [
//                                     Container(
//                                       height: 600,
//                                       child: Padding(
//                                         padding: EdgeInsets.all(5.0),
//                                         child: GridView.builder(
//                                           gridDelegate:
//                                               SliverGridDelegateWithFixedCrossAxisCount(
//                                             crossAxisCount: 2,
//                                             crossAxisSpacing: 5,
//                                             mainAxisExtent: 90,
//                                           ),
//                                           itemCount: restaurantDataList.length,
//                                           itemBuilder: (context, index) {
//                                             // AllRestraunts filterRestraunt =
//                                             //     AllRestraunts.fromMap(restaurantDataList[index]
//                                             //         );
//                                             final restaurantData =
//                                                 restaurantDataList[index];

//                                             if (restaurantData["status"] ==
//                                                 "Approved") {
//                                               print(restaurantData["uid"]);
//                                               print(restaurantData[
//                                                   "restaurant_name"]);
//                                               return Container(
//                                                 height: 170,
//                                                 child: ClipRRect(
//                                                   borderRadius:
//                                                       BorderRadius.circular(20),
//                                                   child: GestureDetector(
//                                                     onTap: () {
//                                                       Navigator.push(
//                                                         context,
//                                                         MaterialPageRoute(
//                                                           builder: (context) =>
//                                                               BrowseFood(),
//                                                         ),
//                                                       );
//                                                     },
//                                                     child: Container(
//                                                       decoration: BoxDecoration(
//                                                         image: DecorationImage(
//                                                           image: NetworkImage(
//                                                               restaurantData[
//                                                                       "restraunt_logo"]
//                                                                   .toString()),
//                                                           colorFilter:
//                                                               ColorFilter.mode(
//                                                             Colors.black
//                                                                 .withOpacity(
//                                                                     0.4),
//                                                             BlendMode.darken,
//                                                           ),
//                                                           fit: BoxFit.cover,
//                                                         ),
//                                                       ),
//                                                       child: Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .center,
//                                                         children: [
//                                                           Text(
//                                                             "${restaurantData["restaurant_name"]}",
//                                                             style: TextStyle(
//                                                               color:
//                                                                   Colors.white,
//                                                               fontSize: 15,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w500,
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               );
//                                             } else {
//                                               return Center(
//                                                 child: Container(
//                                                   child: Text(
//                                                       "No approved restaurant"),
//                                                 ),
//                                               );
//                                             }

//                                             // QuerySnapshot<Map<String, dynamic>> productSnapshot =
//                                             //     snapshot.data!
//                                             //         as QuerySnapshot<Map<String, dynamic>>;
//                                             // List<QueryDocumentSnapshot<Map<String, dynamic>>>
//                                             //     filteredData = productSnapshot.docs
//                                             //         .where((doc) =>
//                                             //             doc['productPrice'] == widget.priceFilters)
//                                             //         .toList();
//                                             // List<AllRestraunts> sortedRestaurants = [];
//                                             // for (var doc in filteredData) {
//                                             //   String restaurantUid = doc['uid'];
//                                             //   Future<List<int>> productPrices =
//                                             //       fetchProductPrices(restaurantUid);
//                                             //  var averagePrice = productPrices.then((data) {
//                                             //     if (data.isEmpty) {
//                                             //       double averagePrice = 0;
//                                             //       return averagePrice;
//                                             //     } else {
//                                             //       double averagePrice =
//                                             //           data.reduce((a, b) => a + b) / data.length;
//                                             //           return averagePrice;
//                                             //     }
//                                             //   });

//                                             //   sortedRestaurants.add(AllRestraunts(
//                                             //       uid: restaurantUid, averagePrice: averagePrice as double));
//                                             // }
//                                             // sortedRestaurants.sort((a, b) =>
//                                             //     a.averagePrice!.compareTo(b.averagePrice as num));
//                                             // final productSnapshoot = FirebaseFirestore.instance
//                                             //     .collection('Products')
//                                             //     .snapshots();
//                                             // List filteredData = productSnapshoot.docs
//                                             //     .where((doc) =>
//                                             //         doc['productPrice'] == widget.priceFilters)
//                                             //     .toList();
//                                             // List<AllRestraunts> sortedRestaurants = [];
//                                             // for (var doc in filteredData) {
//                                             //   // String restaurantUid = doc['uid'];
//                                             //   List<int> productPrices =
//                                             // fetchProductPrices(restaurantUid) as List<int>;
//                                             //   double averagePrice = productPrices.isNotEmpty
//                                             //       ? productPrices.reduce((a, b) => a + b) /
//                                             //           productPrices.length
//                                             //       : 0;
//                                             //   sortedRestaurants.add(AllRestraunts(
//                                             //       uid: restaurantUid, averagePrice: averagePrice));
//                                             // }
//                                             // sortedRestaurants.sort((a, b) =>
//                                             //     a.averagePrice!.compareTo(b.averagePrice as num));
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 );
//                               } else {
//                                 return Center(
//                                     child: CircularProgressIndicator());
//                               }
//                             },
//                           );
//                         } else {
//                           return Center(child: Text("No Data Found"));
//                         }
//                       })),
//             ])
//           ]),
//         ));
//   }
// }
