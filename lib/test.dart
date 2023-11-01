// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:hive_flutter/adapters.dart';

// // List hiveItems = [];
// // bool isChecked = false;

// // class HiveTest extends StatefulWidget {
// //   const HiveTest({super.key});

// //   @override
// //   State<HiveTest> createState() => _HiveTestState();
// // }

// // class _HiveTestState extends State<HiveTest> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         body: Center(
// //       child: Container(
// //         height: 180,
// //         child: ValueListenableBuilder(
// //             valueListenable: Hive.box("SideItemsIsCheck").listenable(),
// //             builder: (context, box, child) {
// //               return StreamBuilder(
// //                   stream:
// //                       FirebaseFirestore.instance.collection("Hive").snapshots(),
// //                   builder: (context, snapshot) {
// //                     if (snapshot.hasData) {
// //                       return ListView.builder(
// //                         itemCount: snapshot.data?.docs.length,
// //                         itemBuilder: (context, indexx) {
// //                           final sideItemId = snapshot.data?.docs[indexx];
// //                           final isTick = box.get(indexx) != null;
// //                           return Column(
// //                             children: [
// //                               ListTile(
// //                                 trailing: Text("${sideItemId?["hiveName"]}"),
// //                                 leading: Checkbox(
// //                                   value: isChecked,
// //                                   onChanged: (bool? value) {
// //                                     setState(() async {

// //                                       await box.put(indexx, value);
// //                                         await isChecked == value!;
// //                                       ScaffoldMessenger.of(context)
// //                                           .clearSnackBars();
// //                                       ScaffoldMessenger.of(context)
// //                                           .showSnackBar(SnackBar(
// //                                               backgroundColor: Theme.of(context)
// //                                                   .primaryColor,
// //                                               content: const Text(
// //                                                   'Side Item Added')));
// //                                       //update the value of the checkboxin firestore
// //                                       await FirebaseFirestore.instance
// //                                           .collection("HiveIsChecked")
// //                                           .add({"hivename":  sideItemId?["hiveName"],
// //                                           "hiveNameIsCheck": value}).then((value) => box.delete(indexx));
// //                                     });
// //                                   },
// //                                 ),
// //                                 title: Text("${sideItemId?["hiveName"]}"),
// //                               )
// //                             ],
// //                           );
// //                         },
// //                       );
// //                     } else {
// //                       return Center(child: CircularProgressIndicator());
// //                     }
// //                   });
// //             }),
// //       ),
// //     ));
// //   }
// // }
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';

// // class SubcollectionScreen extends StatefulWidget {
// //   @override
// //   _SubcollectionScreenState createState() => _SubcollectionScreenState();
// // }

// // class _SubcollectionScreenState extends State<SubcollectionScreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Subcollection'),
// //       ),
// //       body: _buildSubcollectionList(),
// //     );
// //   }

// //   Widget _buildSubcollectionList() {
// //     return FutureBuilder(
// //       future: FirebaseFirestore.instance.collection('Categories').doc(
// //           "1"
// //       ).collection("Category").get(),
// //       builder: (BuildContext context, AsyncSnapshot snapshot) {
// //         if (snapshot.hasData) {

// //                     return Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         ListView.builder(

// //                           itemCount:snapshot.data!.docs .length,
// //                           itemBuilder: (BuildContext context, int index) {
// //                             final restaurant = snapshot.data.data()[index];
// //                             return ListTile(
// //                               title: Text("${restaurant['CategoryName'] }",
// //                               style: TextStyle(color: Colors.black),),
// //                             );
// //                           },
// //                         ),
// //                       ],
// //                     );
// //                   }

// //                   return SizedBox.shrink();

// //             } );

// //   }}
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// // class Category {
// //   final String categoryName;

// //   Category({required this.categoryName});
// // }

// // class CategoryScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Categories'),
// //       ),
// //       body: StreamBuilder(
// //         stream: FirebaseFirestore.instance.collection("books").where("author", isEqualTo: "Arumugam").getDocuments().then((value) {
// //   value.documents.forEach((result) {
// //    var id = result.documentID;
// //    Firestore.instance.collection("books").document(id).collection("enquiries").getDocuments().then((querySnapshot) {
// //     querySnapshot.documents.forEach((result) {
// //       print(result.data);
// //     });
// //         builder: (context, snapshot) {
// //           if (snapshot.hasError) {
// //             return Text('Error: ${snapshot.error}');
// //           }

// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return CircularProgressIndicator();
// //           }

// //           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// //             return Text('No data found.');
// //           }

// //           final categoryDocs = snapshot.data!.docs;

// //           return ListView.builder(
// //             itemCount: categoryDocs.length,
// //             itemBuilder: (context, index) {
// //               final categoryDoc = categoryDocs[index];

// //               return StreamBuilder<QuerySnapshot>(
// //                 stream: categoryDoc.reference.collection('Category').snapshots(),
// //                 builder: (context, subSnapshot) {
// //                   if (subSnapshot.hasError) {
// //                     return Text('Error: ${subSnapshot.error}');
// //                   }

// //                   if (subSnapshot.connectionState == ConnectionState.waiting) {
// //                     return CircularProgressIndicator();
// //                   }

// //                   if (!subSnapshot.hasData || subSnapshot.data!.docs.isEmpty) {
// //                     return SizedBox.shrink();
// //                   }

// //                   final categories = subSnapshot.data!.docs.map((doc) {
// //                     final categoryName = doc['CategoryName'];
// //                     return Category(categoryName: categoryName);
// //                   }).toList();

// //                   return Column(
// //                     children: categories.map((category) => ListTile(
// //                       title: Text(category.categoryName),
// //                     )).toList(),
// //                   );
// //                 },
// //               );
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// // class Category {
// //   final String CategoryName;

// //   Category({required this.CategoryName});
// // }

// // class OrderScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Orders'),
// //       ),
// //       body: StreamBuilder<QuerySnapshot>(
// //         stream: FirebaseFirestore.instance.collection('Categories').snapshots(),
// //         builder: (context, snapshot) {
// //           if (snapshot.hasError) {
// //             return Text('Error: ${snapshot.error}');
// //           }

// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return CircularProgressIndicator();
// //           }

// //           if (snapshot.hasData) {
// //             final customers = snapshot.data!.docs;

// //             return ListView.builder(
// //               itemCount: customers.length,
// //               itemBuilder: (context, index) {
// //                 final customer = customers[index];

// //                 return StreamBuilder<QuerySnapshot>(
// //                   stream: FirebaseFirestore.instance
// //                       .collection('Categories')
// //                       .doc(customer.id)
// //                       .collection('Category')
// //                       .snapshots(),
// //                   builder: (context, orderSnapshot) {
// //                     if (orderSnapshot.hasError) {
// //                       return Text('Error: ${orderSnapshot.error}');
// //                     }

// //                     if (orderSnapshot.connectionState == ConnectionState.waiting) {
// //                       return CircularProgressIndicator();
// //                     }

// //                     if (orderSnapshot.hasData) {
// //                       final orders = orderSnapshot.data!.docs.map((orderDoc) {
// //                         // final orderId = orderDoc.id;
// //                         final orderDetails = orderDoc['CategoryName'];
// //                         return Category(CategoryName:orderDetails , );
// //                       }).toList();

// //                       return ListView.builder(

// //                         itemCount: orders.length,
// //                         itemBuilder: (context, index) {
// //                           final order = orders[index];

// //                           return ListTile(
// //                             title: Text('CategoryName: ${order.CategoryName}', style: TextStyle(color: Colors.black),)
// //                           );
// //                         },
// //                       );
// //                     }

// //                     return SizedBox.shrink();
// //                   },
// //                 );
// //               },
// //             );
// //           }

// //           return Text('No data found.');
// //         },
// //       ),
// //     );
// //   }
// // }

// class CategoryScreen extends StatefulWidget {
//   const CategoryScreen({super.key});

//   @override
//   State<CategoryScreen> createState() => _CategoryScreenState();
// }

// class _CategoryScreenState extends State<CategoryScreen> {
//   var date='';
//    getCategories() {
//     FirebaseFirestore.instance
//         .collection("Categories")
//         .where("CategoryId", isEqualTo: "ID")
//         .get()
//         .then((value) {
//       value.docs.forEach((result) {
//         var id = result.id;
//         FirebaseFirestore.instance
//             .collection("Categories")
//             .doc(id)
//             .collection("Category")
//             .get()
//             .then((querySnapshot) {
//           querySnapshot.docs.forEach((result) {
//             print(result.data);
//           });

//         });
//       });
//     });
    
//   }
// @override
//   void initState() {
//     date=getCategories();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//         stream: ,
//         builder: (context, AsyncSnapshot snapshot) {
//           return Container(
//             height: 600,
//             child: ListView.builder(
//               itemCount: snapshot.data?.docs.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(snapshot.data[index]["CategoryName"]),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
