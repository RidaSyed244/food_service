import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_service/Home%20Screens/HomePage.dart';
import 'package:food_service/Home%20Screens/Single_Restraunt.dart';
import 'package:food_service/Order%20Screens/AddToOrder.dart';
import 'package:food_service/Screens/Filters.dart';
import 'package:food_service/cartChangeNotifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../UserModel.dart';
import '../user.dart';

late AllRestraunts resnamee = AllRestraunts(
    restaurant_name: "",
    restaurant_address: "",
    restraunt_currency: "",
    restraunt_logo: "",
    categoryType: "",
    status: "");

class FeaturedPartners extends ConsumerStatefulWidget {
  const FeaturedPartners(
      {super.key,
      required this.storeDocId,
      required this.storeIndexId,
      required this.resName});
  final String? storeDocId;
  final int? storeIndexId;
  final AllRestraunts resName;
  @override
  ConsumerState<FeaturedPartners> createState() => _FeaturedPartnersState();
}

class _FeaturedPartnersState extends ConsumerState<FeaturedPartners> {
  int bottomNavIndex = 0;
  @override
  Widget build(BuildContext context) {
    final featuredRestraunts = ref.watch(providerrr);
    final categoryLength = ref.watch(categoryStream);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            color: Colors.black,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                            address: "",
                          )));
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            "Featured Partners",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22.0,
            ),
          ),
        ),
        body: featuredRestraunts.when(data: (data) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisExtent: 380),
            itemCount: data.docs.length,
            itemBuilder: (context, storeIndexId) {
              AllRestraunts featuredRestraunt =
                  AllRestraunts.fromMap(data.docs[storeIndexId].data());
              AllRestraunts categories =
                  AllRestraunts.fromMap(data.docs[storeIndexId].data());
              DocumentSnapshot docId = data.docs[storeIndexId];
              if (featuredRestraunt.status == "Approved") {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: GestureDetector(
                            onTap: () {
                              print(featuredRestraunt.latitude);
                              print(featuredRestraunt.longitude);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
//

                                      SingleRestraunt(
                                    token: featuredRestraunt.token,
                                    latitude: featuredRestraunt.latitude,
                                    longitude: featuredRestraunt.longitude,
                                    title: featuredRestraunt.restaurant_name
                                        .toString(),
                                    restrauntLocation: featuredRestraunt
                                        .restaurant_address
                                        .toString(),
                                    currency: featuredRestraunt
                                        .restraunt_currency
                                        .toString(),
                                    image: featuredRestraunt.restraunt_logo
                                        .toString(),
                                    storeId: docId.id,
                                    discription: featuredRestraunt.categoryType
                                        .toString(),
                                    time: featuredRestraunt.deliver_time
                                        .toString(),
                                    free: featuredRestraunt.deliver_charges
                                        .toString(),
                                    // storeIndexId: widget.storeIndexId,
                                    categories:
                                        categories.CategoryName.toString(),
                                    orderType: featuredRestraunt.OrderType,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 300,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    featuredRestraunt.restraunt_logo.toString(),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 4, 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          // if (featuredRestraunt.deliver_time !=
                                          //     null)
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.time_to_leave,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  featuredRestraunt
                                                          .deliver_time ??
                                                      "",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // if (featuredRestraunt
                                              //         .deliver_charges !=
                                              //     null)
                                                Row(children: [
                                                  Icon(Icons.money,
                                                      color: Colors.white),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    featuredRestraunt
                                                            .deliver_charges ??
                                                        "",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 11),
                                                  ),
                                                ]),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                      height: 23,
                                                      width: 35,
                                                      decoration: BoxDecoration(
                                                        color: Colors.orange,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                      ),
                                                      child: StreamBuilder(
                                                          stream: FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "All_Restraunts")
                                                              .doc(docId.id)
                                                              .collection(
                                                                  "RatingsandReviews")
                                                              .snapshots(),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                .hasData) {
                                                              List<double>
                                                                  ratings = [];
                                                              snapshot
                                                                  .data!.docs
                                                                  .forEach(
                                                                      (ratingDoc) {
                                                                // Assuming each rating document has a field named 'rating'
                                                                double rating =
                                                                    ratingDoc.data()[
                                                                            "Rating"] ??
                                                                        0.0;
                                                                ratings.add(
                                                                    rating);
                                                              });

                                                              // Calculate the average rating
                                                              double averageRating = ratings
                                                                      .isNotEmpty
                                                                  ? ratings.reduce(
                                                                          (a, b) =>
                                                                              a +
                                                                              b) /
                                                                      ratings
                                                                          .length
                                                                  : 0.0;

                                                              return Center(
                                                                child: Text(
                                                                  '${averageRating.toStringAsFixed(1)}',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                              );
                                                            } else {
                                                              return Center(
                                                                  child: Text(
                                                                "0.0",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12,
                                                                ),
                                                              ));
                                                            }
                                                          })),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "${featuredRestraunt.restaurant_name}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("TypesOfCategory")
                            .doc(docId.id)
                            .collection("CategoryType")
                            .snapshots(),
                        builder: (context, snapshot) {
                          // if (snapshot.hasData) {
                          return Container(
                            height: 24,
                            width: 175,
                            child: ListView.builder(
                              itemBuilder: (context, storeIndexId) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(3, 0, 0, 0),
                                  child: Row(
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
                                        width: 4,
                                      ),
                                      Text(
                                        snapshot.data?.docs[storeIndexId]
                                            .data()["categoryType"],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                    ],
                                  ),
                                );
                              },
                              itemCount: snapshot.data?.docs.length ?? 0,
                              scrollDirection: Axis.horizontal,
                            ),
                          );
                          // } else {
                          //   return Text("");
                          // }
                        })
                  ],
                );
              } else {
                return Center(child: Text(""));
              }
            },
          );
        }, error: (e, s) {
          return Center(
            child: Text("Error"),
          );
        }, loading: () {
          return Center(child: Text(""));
        }));
  }
}
