import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_service/Search%20screens/Browse_food.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import '../StateManagement.dart';

class RatingsReviews extends StatefulWidget {
  const RatingsReviews({super.key, this.storeId});
  final String? storeId;
  @override
  State<RatingsReviews> createState() => _RatingsReviewsState();
}

class _RatingsReviewsState extends State<RatingsReviews> {
  List ratingReviewData = [];
//   double calculateAverageRating(List<AllRatingAndReview> ratingsList) {
//   double totalRating = 0.0;

//   if (ratingsList.isEmpty) {
//     return 0.0; // Return 0 if there are no ratings.
//   }

//   for (var rating in ratingsList) {
//     totalRating += rating.Rating ;
//   }

//   return totalRating / ratingsList.length;
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(fit: StackFit.expand, children: [
        OpenStreetMapSearchAndPick(
            center: LatLong(23, 89), onPicked: (pickedData) {}),
        DraggableScrollableSheet(builder: ((context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Stack(
              children: [
                Container(
                  child: Column(
                    children: [
                      // Padding(
                      //     padding: const EdgeInsets.all(20.0),
                      //     child: ListTile(
                      //       leading: Icon(
                      //         Icons.location_on,
                      //         color: Colors.grey,
                      //       ),
                      //       title: Text(),
                      //     )
                      //     //  TextFormField(
                      //     //   decoration: InputDecoration(
                      //     //     hintText: 'Search',
                      //     //     hintStyle: TextStyle(
                      //     //       color: Colors.grey,
                      //     //       fontSize: 15,
                      //     //     ),
                      //     //     prefixIcon: Icon(
                      //     //       Icons.location_pin,
                      //     //       color: Colors.grey,
                      //     //     ),
                      //     //   ),
                      //     // ),

                      //     ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Ratings & Reviews",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 25,
                                  ),
                                )
                              ],
                            ),
                            
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("All_Restraunts")
                              .doc(widget.storeId)
                              .collection("RatingsandReviews")
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1, mainAxisExtent: 170),
                                controller: scrollController,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  AllRatingAndReview ratingsOfFood =
                                      AllRatingAndReview.fromMap(
                                          snapshot.data!.docs[index].data());

                                  final allReviewImages =
                                      snapshot.data!.docs[index];
                                  ratingReviewData =
                                      allReviewImages["imageUrls"] ?? [];
                                  return Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            // Column(children: [
                                            //   // CircleAvatar(
                                            //   //   radius: 15,
                                            //   //   child: Container(
                                            //   //     height: 15,
                                            //   //     width: 15,
                                            //   //     decoration: BoxDecoration(
                                            //   //       shape: BoxShape.circle,
                                            //   //       image: DecorationImage(
                                            //   //         image: AssetImage(ratingsOfFood),
                                            //   //         fit: BoxFit.cover,
                                            //   //       ),
                                            //   //     ),
                                            //   //   ),
                                            //   // ),
                                            // ]),
                                            // SizedBox(
                                            //   width: 13,
                                            // ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  ratingsOfFood.Name.toString(),
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            Container(
                                              height: 25,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    238, 167, 52, 1),
                                                borderRadius:
                                                    BorderRadius.circular(2),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  ratingsOfFood.Rating
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: Text(
                                                ratingsOfFood.Review.toString(),
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          height: 80,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: ratingReviewData.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                // width: 80,
                                                height: 80,
                                                child: AspectRatio(
                                                  aspectRatio: 3.5 / 3,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 5.0),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Image.network(
                                                        ratingReviewData[index]
                                                            ["ImageUrls"],
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }),
                    ),
                  ),
                ),
              ],
            ),
          );
        })),
        Positioned(
          top: 750,
          left: 20,
          right: 30,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Material(
                  color: Color.fromRGBO(238, 167, 52, 1),
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  child: MaterialButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BrowseFood()));
                    },
                    minWidth: 250.0,
                    height: 10.0,
                    child: Text('BROWSE FOOD',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Material(
                  color: Color.fromARGB(255, 209, 209, 209),
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  child: MaterialButton(
                    onPressed: () async {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => BrowseFood()));
                    },
                    minWidth: 60.0,
                    height: 10.0,
                    child: Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ]),
        ),
      ]),
    );
  }

  Ratings(AllRatingAndReview ratingsOfFood) {}
}
