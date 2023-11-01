import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:food_service/Home%20Screens/Featured_Partners.dart';
import 'package:food_service/Order%20Screens/Your_Orders.dart';
import 'package:food_service/Search%20screens/Browse_food.dart';
import 'package:food_service/UserModel.dart';
import 'package:food_service/cartChangeNotifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../Order Screens/AddToOrder.dart';
import '../Screens/Filters.dart';
import '../homeCards.dart';
import '../user.dart';
import 'NavBar.dart';

var userLatitude;
var userLongitude;
var userToken;
var username;
  var userEmail;
  var userCurrentLocation;
class HomePage extends ConsumerStatefulWidget {
  final address;
  HomePage({required this.address});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final CarouselController _controller = CarouselController();
  int currentIndex = 0;
  int bottomNavIndex = 0;
  var restrauntStatus = '';

  // Future getStatus() async {
  //   final statuss =
  //       await FirebaseFirestore.instance.collection("All_Restraunrts").orderBy("status").get();
  //       restrauntStatus=  statuss.data()?["status"] ;
  // }

  Future getUserLatitude() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) {
      setState(() {
        userLatitude = value.data()?['UserLatitude'];
        print(userLatitude);
      });
    });
  }

  Future getUserLongitude() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) {
      setState(() {
        userLongitude = value.data()?['UserLongitude'];
        print(userLongitude);
      });
    });
  }

  // Future getUserName() async {
  //   await FirebaseFirestore.instance
  //       .collection("Users")
  //       .doc(FirebaseAuth.instance.currentUser?.uid)
  //       .get()
  //       .then((value) {
  //     setState(() {
  //       Username = value.data()?["UserName"];
  //     });
  //   });
  // }

  // Future getUserEmail() async {
  //   await FirebaseFirestore.instance
  //       .collection("Users")
  //       .doc(FirebaseAuth.instance.currentUser?.uid)
  //       .get()
  //       .then((value) {
  //     setState(() {
  //       UserEmail = value.data()?["UserEmail"];
  //     });
  //   });
  // }

  // Future getUserLocation() async {
  //   await FirebaseFirestore.instance
  //       .collection("Users")
  //       .doc(FirebaseAuth.instance.currentUser?.uid)
  //       .get()
  //       .then((value) {
  //     setState(() {
  //       UserLocation = value.data()?["UserAddress"];
  //     });
  //   });
  // }

  Future getUserToken() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) {
      setState(() {
        userToken = value.data()?['UserToken'];
        print(userToken);
      });
    });
  }
  Future getUserLocation() async {
    final userLocationSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    final userLocationData = userLocationSnapshot.data();
    if (userLocationData != null &&
        userLocationData.containsKey('UserAddress')) {
      userCurrentLocation = userLocationData['UserAddress'];
    } else {
      userCurrentLocation = null; // or provide a default value
    }

    setState(() {
      userCurrentLocation = userLocationData != null
          ? userLocationData['UserAddress']
          : null; // or provide a default value
    });
  }

  Future getUserName() async {
    final userNameSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    final userNameData = userNameSnapshot.data();
    if (userNameData != null && userNameData.containsKey('UserName')) {
      username = userNameData['UserName'];
    } else {
      username = null; // or provide a default value
    }

    setState(() {
      username = userNameData != null
          ? userNameData['UserName']
          : null; // or provide a default value
    });
  }

  Future getUserEmail() async {
    final userNameSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    final userEmailData = userNameSnapshot.data();
    if (userEmailData != null && userEmailData.containsKey('UserEmail')) {
      userEmail = userEmailData['UserEmail'];
    } else {
      userEmail = null; // or provide a default value
    }

    setState(() {
      userEmail = userEmailData != null
          ? userEmailData['UserEmail']
          : null; // or provide a default value
    });
  }

  @override
  void initState() {
    super.initState();
    getUserLatitude();
    getUserLongitude();
    getUserToken();
    getUserLocation();
    getUserName();
    getUserEmail();

    allCartItems.clear();
  }

  @override
  Widget build(BuildContext context) {
    final length = ref.watch(cart);
    final allRestraunts = ref.watch(providerrr);
    return Scaffold(
      drawer: NavBar(),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "DELIVERY TO",
          style: TextStyle(
            color: Color.fromRGBO(240, 178, 77, 1),
            fontSize: 15.0,
          ),
        ),
        //     leading: Builder(
        //   builder: (BuildContext context) {
        //     return IconButton(
        //       icon: const Icon(
        //         Icons.remove_red_eye_sharp,
        //       ),
        //       onPressed: () {
        //         Scaffold.of(context).openDrawer();
        //       },
        //       tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        //     );
        //   },
        // ),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          Badge(
            alignment: AlignmentDirectional.center,
            label: Text(
              "${length.length}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.0,
              ),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => YourOrders(
                              i: 0,
                              itemsss: items,
                            )));
              },
            ),
          ),
          // TextButton(
          //   child: Text(
          //     "Filter",
          //     style: TextStyle(
          //       color: Colors.black,
          //       fontSize: 16.0,
          //     ),
          //   ),
          //   onPressed: () {
          //     Navigator.push(
          //         context, MaterialPageRoute(builder: (context) => Filters()));
          //   },
          // ),
        ],
        bottom: PreferredSize(
            child: Center(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Users")
                      .doc(FirebaseAuth.instance.currentUser?.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        "${snapshot.data?["UserAddress"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17.0,
                        ),
                      );
                    } else {
                      return Text("Loading...");
                    }
                  }),
            ),
            preferredSize: Size.fromHeight(7)),
      ),
      body: Container(
        // padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: ListView(
          children: [
            Stack(
              children: [
                InkWell(
                    child: CarouselSlider(
                  carouselController: _controller,
                  options: CarouselOptions(
                    scrollPhysics: BouncingScrollPhysics(),
                    aspectRatio: 2,
                    viewportFraction: 1,
                    autoPlay: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                  items: imageList
                      .map((item) => Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                item["image_path"],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ))
                      .toList(),
                )),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: imageList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () {
                          _controller.animateToPage(entry.key);
                        },
                        child: Container(
                          width: currentIndex == entry.key ? 7 : 7,
                          height: 7.0,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 3.0,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: currentIndex == entry.key
                                  ? Colors.white
                                  : Colors.grey),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Featured\nPartners",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Text(
                          "See All",
                          style: TextStyle(
                            color: Color.fromRGBO(249, 191, 98, 1),
                            fontSize: 17,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FeaturedPartners(
                                        storeDocId: '',
                                        storeIndexId: 0,
                                        resName: resnamee,
                                      )));
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: allRestraunts.when(data: (data) {
                return Container(
                  // padding: const EdgeInsets.fromLTRB(3, 13, 3, 10),
                  height: 210,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) {
                        AllRestraunts restraunt =
                            AllRestraunts.fromMap(data.docs[index].data());
                        DocumentSnapshot docId = data.docs[index];

                        if (restraunt.status == "Approved") {
                          return Container(
                            width: 210,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: AspectRatio(
                                  aspectRatio: 4.7 / 3,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        restraunt.restraunt_logo.toString(),
                                        fit: BoxFit.cover,
                                      )),
                                )),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(restraunt.restaurant_name.toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                      "${restraunt.restaurant_address.toString()}...",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13,
                                      )),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                // if (restraunt.deliver_charges != null &&
                                //     restraunt.deliver_time != null)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                              height: 23,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    238, 167, 52, 1),
                                                borderRadius:
                                                    BorderRadius.circular(4),
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
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      List<double> ratings = [];
                                                      snapshot.data!.docs
                                                          .forEach((ratingDoc) {
                                                        // Assuming each rating document has a field named 'rating'
                                                        double rating =
                                                            ratingDoc.data()[
                                                                    "Rating"] ??
                                                                0.0;
                                                        ratings.add(rating);
                                                      });

                                                      // Calculate the average rating
                                                      double averageRating =
                                                          ratings.isNotEmpty
                                                              ? ratings.reduce(
                                                                      (a, b) =>
                                                                          a +
                                                                          b) /
                                                                  ratings.length
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
                                        ],
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            restraunt.deliver_time ?? "",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 7,
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
                                        width: 4,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            restraunt.deliver_charges ?? "",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                              ],
                            ),
                          );
                        }
                      }),
                      separatorBuilder: ((context, _) {
                        return SizedBox(
                          width: 4,
                        );
                      }),
                      itemCount: data.docs.length),
                );
              }, error: (error, stackTrace) {
                return Center(child: Text("Error"));
              }, loading: () {
                return Center(
                    child: Container(
                  height: 200,
                ));
              }),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/Bannerrrrrr.png"))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 40, 0, 0),
                        child: Text(
                          "Free Delivery for\n1 Month!",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 27,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 10, 0, 0),
                        child: Text(
                          "You’ve to order at least \$10 for\nusing free delivery for 1 month.",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Best Picks\nRestraunts by\nteam",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Text(
                          "See All",
                          style: TextStyle(
                            color: Color.fromRGBO(249, 191, 98, 1),
                            fontSize: 17,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FeaturedPartners(
                                        storeDocId: "",
                                        storeIndexId: 0,
                                        resName: resnamee,
                                      )));
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: allRestraunts.when(data: (data) {
                return Container(
                  height: 210,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) {
                        AllRestraunts restraunt =
                            AllRestraunts.fromMap(data.docs[index].data());
                        DocumentSnapshot docId = data.docs[index];
                        if (restraunt.status == "Approved") {
                          return Container(
                            width: 210,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: AspectRatio(
                                  aspectRatio: 4.7 / 3,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        restraunt.restraunt_logo.toString(),
                                        fit: BoxFit.cover,
                                      )),
                                )),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(restraunt.restaurant_name.toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                      "${restraunt.restaurant_address.toString()}...",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      )),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                // if (restraunt.deliver_charges != null &&
                                //     restraunt.deliver_time != null)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                              height: 23,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    238, 167, 52, 1),
                                                borderRadius:
                                                    BorderRadius.circular(4),
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
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      List<double> ratings = [];
                                                      snapshot.data!.docs
                                                          .forEach((ratingDoc) {
                                                        // Assuming each rating document has a field named 'rating'
                                                        double rating =
                                                            ratingDoc.data()[
                                                                    "Rating"] ??
                                                                0.0;
                                                        ratings.add(rating);
                                                      });

                                                      // Calculate the average rating
                                                      double averageRating =
                                                          ratings.isNotEmpty
                                                              ? ratings.reduce(
                                                                      (a, b) =>
                                                                          a +
                                                                          b) /
                                                                  ratings.length
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
                                        ],
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            restraunt.deliver_time ?? "",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 7,
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
                                        width: 4,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            restraunt.deliver_charges ?? "",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                              ],
                            ),
                          );
                        } else {
                          return Text("");
                        }
                      }),
                      separatorBuilder: ((context, _) {
                        return SizedBox(
                          width: 4,
                        );
                      }),
                      itemCount: data.docs.length),
                );
              }, error: (error, stackTrace) {
                return Center(child: Text("Error"));
              }, loading: () {
                return Center(
                    child: Container(
                  height: 200,
                ));
              }),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "All Restraunts",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Text(
                          "See All",
                          style: TextStyle(
                            color: Color.fromRGBO(249, 191, 98, 1),
                            fontSize: 17,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BrowseFood()));
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: allRestraunts.when(data: (data) {
                  return Container(
                    height: 300,
                    child: ListView.builder(
                      itemExtent: 370,
                      scrollDirection: Axis.vertical,
                      itemCount: data.docs.length,
                      itemBuilder: (context, index) {
                        AllRestraunts restraunt =
                            AllRestraunts.fromMap(data.docs[index].data());
                        DocumentSnapshot docId = data.docs[index];
                        if (restraunt.status == "Approved") {
                          return Container(
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
                                          color:
                                              Color.fromRGBO(179, 170, 179, 1),
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

                                // if (restraunt.deliver_charges != null &&
                                //     restraunt.deliver_time != null)
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
                                              "${restraunt.deliver_time??"Not Added"}",
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
                                              "${restraunt.deliver_charges??"Not Added"}",
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
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection(
                                                        "All_Restraunts")
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
                                                      double rating =
                                                          ratingDoc.data()[
                                                                  "Rating"] ??
                                                              0.0;
                                                      ratings.add(rating);
                                                    });

                                                    // Calculate the average rating
                                                    double averageRating =
                                                        ratings.isNotEmpty
                                                            ? ratings.reduce(
                                                                    (a, b) =>
                                                                        a + b) /
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
                                                        child: Text(
                                                      "0.0",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                      ),
                                                    ));
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
                                                scrollDirection:
                                                    Axis.horizontal,
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
                                                            const EdgeInsets
                                                                .only(
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
                                        return Center(
                                            child: Text("Loading..."));
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
                          );
                        }
                      },
                    ),
                  );
                }, error: (error, stackTrace) {
                  return Center(
                    child: Text("Error"),
                  );
                }, loading: () {
                  return Center(
                    child: Text(''),
                  );
                }))
          ],
        ),
      ),
    );
  }
}
