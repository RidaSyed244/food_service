import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_service/Home%20Screens/Single_Restraunt.dart';
import 'package:food_service/Map%20Screens/Ratings_Reviews.dart';
import 'package:food_service/UserModel.dart';
import 'package:food_service/user.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class BrowseFood extends ConsumerStatefulWidget {
  const BrowseFood({super.key});

  @override
  ConsumerState<BrowseFood> createState() => _BrowseFoodState();
}

class _BrowseFoodState extends ConsumerState<BrowseFood> {
  @override
  Widget build(BuildContext context) {
    final allRestraunts = ref.watch(providerrr);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RatingsReviews()));
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          "Browse Foods",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: allRestraunts.when(
        data: (data) {
          return Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: allRestraunts.when(data: (data) {
                return ListView.builder(
                  itemExtent: 370,
                  scrollDirection: Axis.vertical,
                  itemCount: data.docs.length,
                  itemBuilder: (context, index) {
                    AllRestraunts restraunt =
                        AllRestraunts.fromMap(data.docs[index].data());
                    DocumentSnapshot docId = data.docs[index];
                    if (restraunt.status == "Approved") {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
//

                                  SingleRestraunt(
                                token: restraunt.token,
                                latitude: restraunt.latitude,
                                longitude: restraunt.longitude,
                                title: restraunt.restaurant_name.toString(),
                                restrauntLocation:
                                    restraunt.restaurant_address.toString(),
                                currency:
                                    restraunt.restraunt_currency.toString(),
                                image: restraunt.restraunt_logo.toString(),
                                storeId: docId.id,
                                discription: restraunt.categoryType.toString(),
                                time: restraunt.deliver_time.toString(),
                                free: restraunt.deliver_charges.toString(),
                                // storeIndexId: widget.storeIndexId,
                                categories: restraunt.CategoryName.toString(),
                                orderType: restraunt.OrderType,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    height: 230,
                                    width: double.infinity,
                                    child: Image.network(
                                      restraunt.restraunt_logo.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 20, 10, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${restraunt.restaurant_name.toString()}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                        )),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.circle,
                                          color: Colors.grey,
                                          size: 5,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 9,
                                    ),
                                    Text(
                                      "${restraunt.restraunt_currency.toString()}",
                                      style: TextStyle(
                                        color: Color.fromRGBO(179, 170, 179, 1),
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Padding(
                              //   padding:
                              //       const EdgeInsets.fromLTRB(0, 10, 10, 0),
                              //   child: Row(
                              //     children: [

                              //     ],
                              //   ),
                              // ),

                              if (restraunt.deliver_charges != null &&
                                  restraunt.deliver_time != null)
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(3, 12, 0, 0),
                                  child: Row(
                                    children: [
                                      // Column(
                                      //   children: [
                                      //     Text(
                                      //       "${restraunt.restraunt_type.toString()}",
                                      //       style: TextStyle(
                                      //         color: Colors.grey,
                                      //         fontSize: 15,
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      // SizedBox(
                                      //   width: 12,
                                      // ),

                                      Row(
                                        children: [
                                          Icon(
                                            Icons.time_to_leave,
                                            color: Colors.grey,
                                            size: 22,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "${restraunt.deliver_time}",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.done_all,
                                            color: Colors.grey,
                                            size: 22,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "${restraunt.deliver_charges.toString()}",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Column(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.orange,
                                            size: 22,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Column(
                                        children: [
                                          StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection("All_Restraunts")
                                                  .doc(docId.id)
                                                  .collection(
                                                      "RatingsandReviews")
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  List<double> ratings = [];
                                                  snapshot.data!.docs
                                                      .forEach((ratingDoc) {
                                                    // Assuming each rating document has a field named 'rating'
                                                    double rating = ratingDoc
                                                            .data()["Rating"] ??
                                                        0.0;
                                                    ratings.add(rating);
                                                  });

                                                  // Calculate the average rating
                                                  double averageRating = ratings
                                                          .isNotEmpty
                                                      ? ratings.reduce(
                                                              (a, b) => a + b) /
                                                          ratings.length
                                                      : 0.0;

                                                  return Center(
                                                    child: Text(
                                                      '${averageRating.toStringAsFixed(1)}',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return Center(
                                                      child: Text("No"));
                                                }
                                              }),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("TypesOfCategory")
                                      .doc(docId.id)
                                      .collection("CategoryType")
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 10, 0),
                                        child: Container(
                                          height: 30,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  snapshot.data?.docs.length,
                                              itemBuilder:
                                                  (context, storeIndexId) {
                                                return Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.circle,
                                                          color: Colors.grey,
                                                          size: 5,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 3,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5.0),
                                                      child: Text(
                                                        snapshot
                                                                    .data!
                                                                    .docs[
                                                                        storeIndexId]
                                                                    .data()[
                                                                "categoryType"] ??
                                                            "",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 3,
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                  ],
                                                );
                                              }),
                                        ),
                                      );
                                    } else {
                                      return Center(child: Text("Loading..."));
                                    }
                                  }),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 1,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  },
                );
              }, error: (error, stackTrace) {
                return Center(
                  child: Text("Error"),
                );
              }, loading: () {
                return Center(
                  child: Text(''),
                );
              }));
        },
        error: (e, s) {
          return Center(child: Text("Error"));
        },
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
