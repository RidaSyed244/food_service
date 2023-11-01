// ignore_for_file: must_be_immutable
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_service/Home%20Screens/Featured_Partners.dart';
import 'package:food_service/Order%20Screens/Special_InstructionScreen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import '../Map Screens/Ratings_Reviews.dart';
import '../Order Screens/AddToOrder.dart';
import '../featuredItems.dart';
import '../homeCards.dart';

class SideItem {
  final String sideItemName;
  final int sideItemPrice;

  SideItem({
    required this.sideItemName,
    required this.sideItemPrice,
  });
}

List<SideItem> selectedSideItems = [];

class SingleRestraunt extends ConsumerStatefulWidget {
  final title;
  final image;
  final discription;
  final time;
  final latitude;
  final longitude;
  final free;
  final currency;
  final storeId;
  final categories;
  final orderType;
  final storeIndexId;
  final restrauntLocation;
  final token;

  SingleRestraunt({
    this.title,
    this.image,
    this.discription,
    this.restrauntLocation,
    this.time,
    this.free,
    this.token,
    this.currency,
    this.storeId,
    this.categories,
    this.latitude,
    this.longitude,
    this.orderType,
    this.storeIndexId,
  });

  @override
  ConsumerState<SingleRestraunt> createState() => _SingleRestrauntState();
}

class _SingleRestrauntState extends ConsumerState<SingleRestraunt> {
  CarouselController newController = CarouselController();
  int selectedCategoryIndex = 0;
  int currentIndex = 0;
  final scrollController = ScrollController();
  @override
  void initState() {
    createBreakPoints();
    scrollController.addListener(() {
      updateCategoryIndexOnScroll(scrollController.offset);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  List sideItems1 = [];

  void scrollToCategory(int index) {
    if (selectedCategoryIndex != index) {
      num totalItems = 0;
      for (var i = 0; i < widget.categories!.length; i++) {
        totalItems += widget.categories!.length;
      }
      //116 = 100 Menu items height + 16 padding bottom of each item
      //500 = 18 title font size +32(16 vertical padding on title)
      scrollController.animateTo(
          restrauntInfoHeight + (70 * totalItems) + (350 * index),
          duration: Duration(milliseconds: 500),
          curve: Curves.ease);
    }
    setState(() {
      selectedCategoryIndex = index;
    });
  }

  double restrauntInfoHeight = 200 //App bar expandedHeight
      +
      170 -
      kToolbarHeight; //Restraunt info height
  List<double> breakpoints = [];
  void createBreakPoints() {
    double firstBreakPoint =
        restrauntInfoHeight + 50 + (116 * widget.categories!.length);
    breakpoints.add(firstBreakPoint);
    for (var i = 1; i < widget.categories!.length; i++) {
      double nextBreakPoint =
          breakpoints.last + 50 + (116 * widget.categories!.length);
      breakpoints.add(nextBreakPoint);
    }
  }

  void updateCategoryIndexOnScroll(double offset) {
    //fetch categories length
    for (var i = 0; i < widget.categories!.length; i++) {
      if (i == 0) {
        if ((offset < breakpoints.first) & (selectedCategoryIndex != 0)) {
          setState(() {
            selectedCategoryIndex = 0;
          });
        } else if ((offset >= breakpoints[i]) & (offset < breakpoints[i + 1])) {
          if (selectedCategoryIndex != i) {
            setState(() {
              selectedCategoryIndex = i;
            });
          }
        }
      } else if (i == widget.categories!.length - 1) {
        if ((offset >= breakpoints[i]) & (selectedCategoryIndex != i)) {
          setState(() {
            selectedCategoryIndex = i;
          });
        }
      } else {
        if ((offset >= breakpoints[i]) & (offset < breakpoints[i + 1])) {
          if (selectedCategoryIndex != i) {
            setState(() {
              selectedCategoryIndex = i;
            });
          }
        }
      }
    }
  }

  List<String> tokensss = [];
  tokenSelection(String token) {
    setState(() {
      tokensss.add(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          RestrauntAppBar(widget: widget),
          SliverToBoxAdapter(
              child: RestrauntInfo(
            widget: widget,
            storeId: widget.storeId,
          )),
          SliverToBoxAdapter(
            child: FeaturedItems(storeId: widget.storeId),
          ),
          SliverPersistentHeader(
            delegate: RestrauntCategories(
                onChanged: scrollToCategory,
                selectedIndex: selectedCategoryIndex,
                storeId: widget.storeId),
            pinned: true,
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Categories')
                  .doc(widget.storeId)
                  .collection('Category')
                  .snapshots(),
              builder: (context, snapshot) {
                return SliverList(
                    delegate: SliverChildBuilderDelegate(
                  childCount: snapshot.data?.docs.length,
                  (context, int categoryindex) {
                    if (snapshot.hasData) {
                      final categoryName =
                          snapshot.data?.docs[categoryindex]["CategoryName"];
                      final category = snapshot.data?.docs[categoryindex];
                      // List<QueryDocumentSnapshot> categoryDocs = snapshot.data!.docs;
                      return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('Categories')
                                .doc(widget.storeId)
                                .collection('Category')
                                .doc(category?.id)
                                .collection('Products')
                                .snapshots(),
                            builder: (context, snapshot) {
                              // if (snapshot.connectionState ==
                              //     ConnectionState.waiting) {
                              //   return Center(
                              //     child: CircularProgressIndicator(),
                              //   );
                              // }
                              if (snapshot.hasData) {
                                return MenuCategoryItem(
                                  title: '${categoryName ?? ''}',
                                  items: List.generate(
                                    snapshot.data!.docs.length,
                                    (int index) {
                                      final allSideItems =
                                          snapshot.data!.docs[index].data();
                                      final sideItemId =
                                          snapshot.data!.docs[index];
                                      // final sideItemDoc = snapshot.data!.docs[categoryindex].reference;

                                      List<dynamic> sideItems =
                                          allSideItems["SideItems"] ?? [];

                                      final productiD =
                                          snapshot.data!.docs[index].id;
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 16),
                                        child: GestureDetector(
                                          onTap: () {
                                            // String selectedRestaurantToken = widget
                                            //     .token; // Get the restaurant's token

                                            // tokenSelection(
                                            //   selectedRestaurantToken,
                                            // );
                                            // print(tokensss);
                                            // print(widget.latitude);
                                            // print(widget.longitude);

                                            // for (var allSideItemss
                                            //     in sideItems1) {
                                            // setState(() {
                                            //   var sideItem = SideItem(
                                            //     sideItemName: allSideItemss[
                                            //         'sideItemName'],
                                            //     sideItemPrice: allSideItemss[
                                            //         'sideItemPrice'],
                                            //   );

                                            //   // Add the selected side item to the list
                                            //   selectedSideItems.add(sideItem);
                                            // });
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AddToOrder(
                                                  token: widget.token,
                                                  sideItemList: sideItems,
                                                  productID: productiD,
                                                  currency: widget.currency,
                                                  i: 0,
                                                  title:
                                                      snapshot.data!.docs[index]
                                                          ['productName'],
                                                  productId: snapshot
                                                      .data!.docs[index].id,
                                                  restrauntName:
                                                      widget.title.toString(),
                                                  restrauntLocation:
                                                      widget.restrauntLocation,
                                                  categoryId: category?.id,
                                                  storeId: widget.storeId,
                                                  sideItemsIds: sideItemId.id,
                                                  storeIndexId:
                                                      widget.storeIndexId,
                                                  itemsss: Menu(
                                                    specialInstructions: '',
                                                    // token:widget.token,
                                                    storeLocation: widget
                                                        .restrauntLocation,
                                                    selectedSideItemId:
                                                        sideItemId.id,
                                                    storeId: widget.storeId,
                                                    restrauntName: widget.title,
                                                    title: snapshot
                                                            .data!.docs[index]
                                                        ['productName'],
                                                    sideItemsPrice: 0,
                                                    latitude: widget.latitude,
                                                    longitude: widget.longitude,
                                                    sideItems: allSideItems[
                                                            'SideItems'] ??
                                                        [],
                                                    cartSideItems:
                                                        cartSideItems,
                                                    sideItemsIds: sideItemId.id,
                                                    sideItemNames: '',
                                                    allSideItemssInMenu:
                                                        allSideItems[
                                                                'SideItems'] ??
                                                            [],
                                                    image: snapshot
                                                            .data!.docs[index]
                                                        ['productImage'],
                                                    counter: 0,
                                                    totalPrice: 0,
                                                    description: snapshot
                                                            .data!.docs[index]
                                                        ['productDescription'],
                                                    price: snapshot
                                                            .data!.docs[index]
                                                        ['productPrice'],
                                                  ),
                                                  indexx: index,
                                                  counter: 0,
                                                  totalPrice: 0,
                                                  length: snapshot
                                                      .data!.docs.length,
                                                  description: snapshot
                                                          .data!.docs[index]
                                                      ['productDescription'],
                                                  image:
                                                      snapshot.data!.docs[index]
                                                          ['productImage'],
                                                  price:
                                                      snapshot.data!.docs[index]
                                                          ['productPrice'],
                                                ),
                                              ),
                                            );
                                            // }
                                          },
                                          child: MenuCard(
                                            title: snapshot.data!.docs[index]
                                                ['productName'],
                                            description:
                                                snapshot.data!.docs[index]
                                                    ['productDescription'],
                                            image: snapshot.data!.docs[index]
                                                ['productImage'],
                                            price: snapshot.data!.docs[index]
                                                ['productPrice'],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }

                              // if (snapshot.hasError) {
                              //   return Text('Error: ${snapshot.error}');
                              // }

                              // if (!snapshot.hasData || snapshot.data == null) {
                              //   return Text(
                              //     'No Added Items yet!!!',
                              //     style: TextStyle(
                              //       color: Colors.black,
                              //       fontSize: 20,
                              //       fontWeight: FontWeight.bold,
                              //     ),
                              //   );
                              // }
                            },
                          ));
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ));
              }),
        ],
      ),
    );
  }
}

class FeaturedItems extends StatefulWidget {
  const FeaturedItems({Key? key, required this.storeId}) : super(key: key);

  final String storeId;

  @override
  State<FeaturedItems> createState() => _FeaturedItemsState();
}

class _FeaturedItemsState extends State<FeaturedItems> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _stream;

  late List<QueryDocumentSnapshot<Map<String, dynamic>>> _featuredItems;
  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance
        .collectionGroup("Products")
        .where("uid", isEqualTo: widget.storeId)
        .snapshots();

    _featuredItems = [];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Featured Items",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            height: 180,
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: _stream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  _featuredItems = snapshot.data!.docs
                      .where((doc) => doc.data()["Featured_Items"] == "true")
                      .toList();
                }
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _featuredItems.length,
                  itemBuilder: (context, index) {
                    final doc = _featuredItems[index];
                    if (doc.data()["Featured_Items"] == "true") {
                      return Container(
                        width: 140,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 5.1 / 5,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    doc.data()["productImage"],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  
                                  doc.data()["productName"],
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 8),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.start,
                            //     children: [
                            //       Column(
                            //         children: [
                            //           Text(
                            //             "\$\$",
                            //             style: TextStyle(
                            //               color: Colors.grey,
                            //               fontSize: 15,
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //       SizedBox(width: 9),
                            //       Column(
                            //         children: [
                            //           Icon(
                            //             Icons.circle,
                            //             color: Colors.grey,
                            //             size: 5,
                            //           ),
                            //         ],
                            //       ),
                            //       SizedBox(width: 4),
                            //       Column(
                            //         children: [
                            //           Text(
                            //             "Chinese",
                            //             style: TextStyle(
                            //               color: Colors.grey,
                            //               fontSize: 15,
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      );
                    } else {
                      return Center(child: Text('No Data'));
                      // Handle the case when the snapshot is null or has no data
                    }
                  },
                  separatorBuilder: (context, _) {
                    return SizedBox(width: 6);
                  },
                );

                // if (snapshot.hasData && snapshot.data != null) {
                //   final docs = snapshot.data!.docs;
                //   final featuredItems = docs
                //       .where((doc) => doc.data()["Featured_Items"] == true)
                //       .toList();

                //   return

                // } else if (snapshot.hasError) {
                //   print(snapshot.error);
                //   return Text('Error: ${snapshot.error}');
                // } else {
                //   return Center(child: Text('No Data'));
                // }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RestrauntInfo extends StatefulWidget {
  RestrauntInfo({
    Key? key,
    required this.widget,
    required this.storeId,
  }) : super(key: key);

  final widget;
  final storeId;

  @override
  State<RestrauntInfo> createState() => _RestrauntInfoState();
}

class _RestrauntInfoState extends State<RestrauntInfo> {
  int totalReviews = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 2, 12),
        child: Container(
            child: Column(children: [
          Row(
            children: [
              Text(
                "${widget.widget.title}",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
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
                "${widget.widget.currency.toString()}",
                style: TextStyle(
                  color: Color.fromRGBO(179, 170, 179, 1),
                  fontSize: 17,
                ),
              ),
            ],
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('TypesOfCategory')
                  .doc(widget.storeId)
                  .collection('CategoryType')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text('');
                }
                return Container(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, storeIndexId) {
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
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(
                                snapshot.data?.docs[storeIndexId]
                                        .data()["categoryType"] ??
                                    "",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
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
                );
              }),
          SizedBox(
            height: 13,
          ),
          Row(
            children: [
              Container(
                  height: 23,
                  width: 35,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("All_Restraunts")
                          .doc(widget.widget.storeId)
                          .collection("RatingsandReviews")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<double> ratings = [];
                          snapshot.data!.docs.forEach((ratingDoc) {
                            // Assuming each rating document has a field named 'rating'
                            double rating = ratingDoc.data()["Rating"] ?? 0.0;
                            ratings.add(rating);
                          });
                          totalReviews = snapshot.data!.docs.length;

                          // Calculate the average rating
                          double averageRating = ratings.isNotEmpty
                              ? ratings.reduce((a, b) => a + b) / ratings.length
                              : 0.0;

                          return Center(
                            child: Text(
                              '${averageRating.toStringAsFixed(1)}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          );
                        } else {
                          return Center(
                              child: Text(
                            "0.0",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ));
                        }
                      })),
              SizedBox(width: 25),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                    size: 20,
                  ),
                ],
              ),
              SizedBox(width: 8),
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RatingsReviews(
                                      storeId: widget.storeId,
                                    )));
                      },
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("All_Restraunts")
                              .doc(widget.widget.storeId)
                              .collection("RatingsandReviews")
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<double> ratings = [];
                              snapshot.data!.docs.forEach((ratingDoc) {
                                // Assuming each rating document has a field named 'rating'
                                double rating =
                                    ratingDoc.data()["Rating"] ?? 0.0;
                                ratings.add(rating);
                              });
                              int totalReviews = snapshot.data!.docs.length;

                              // Calculate the average rating

                              return Text(
                                '$totalReviews Reviews',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                ),
                              );
                            } else {
                              return Center(
                                  child: Text(
                                "0 Reviews",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                              ));
                            }
                          })),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          // if (widget.widget.orderType != null ||
          //     widget.widget.free != null ||
          //     widget.widget.time != null)
          Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.money,
                    color: Colors.orange,
                    size: 20,
                  ),
                ],
              ),
              SizedBox(
                width: 7,
              ),
              Column(
                children: [
                  Text(
                    "${widget.widget.free ?? "Not Added"}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 15,
              ),
              Row(
                children: [
                  Icon(
                    Icons.time_to_leave,
                    color: Colors.orange,
                    size: 20,
                  ),
                ],
              ),
              SizedBox(
                width: 7,
              ),
              Column(
                children: [
                  Text(
                    "${widget.widget.time ?? "Not Added"}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              if (widget.widget.orderType != null)
                Row(
                  children: [
                    SizedBox(
                      height: 50,
                      width: 80,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                          side:
                              const BorderSide(width: 2, color: Colors.orange),
                        ),
                        onPressed: () {},
                        child: Text(
                          widget.widget.orderType,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.orange, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          // SizedBox(
          //   height: 50,
          // ),
        ])));
  }
}

class RestrauntAppBar extends StatelessWidget {
  const RestrauntAppBar({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final widget;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          widget.image,
          fit: BoxFit.cover,
        ),
      ),
      leading: Padding(
        padding: EdgeInsets.only(left: 16),
        child: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FeaturedPartners(
                            storeDocId: '',
                            resName: resnamee,
                            storeIndexId: 0,
                          )));
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      // actions: [
      //   IconButton(onPressed: () {}, icon: Icon(Icons.share)),
      //   SizedBox(width: 5),
      //   IconButton(onPressed: () {}, icon: Icon(Icons.search)),
      // ],
    );
  }
}
