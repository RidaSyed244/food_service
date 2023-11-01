import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_service/Home%20Screens/Single_Restraunt.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RestaurantSearch extends ConsumerStatefulWidget {
  @override
  _RestaurantSearchState createState() => _RestaurantSearchState();
}

class _RestaurantSearchState extends ConsumerState<RestaurantSearch> {
  List<Restaurant> filteredRestaurants = [];
  List<Restaurant> allRestaurants = [];
  var searchText = '';

  void searchRestaurant(String searchQuery) {
    setState(() {
      searchText = searchQuery;
      filteredRestaurants = allRestaurants
          .where((restaurant) => restaurant.restaurant_name
              !.toLowerCase()
              .startsWith(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAllRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: Column(
          children: [
            TextField(
              onChanged: searchRestaurant,
              decoration: InputDecoration(
                labelText: '  Search',
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
                suffixIcon: TextButton(
                  onPressed: () {
                    setState(() {
                      searchText = '';
                      filteredRestaurants = [];
                    });
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            if (searchText.isNotEmpty)
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 270,
                  ),
                  itemCount: filteredRestaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = filteredRestaurants[index];

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SingleRestraunt(
                                        title: restaurant.restaurant_name,
                                        image: restaurant.restraunt_logo,
                                        restrauntLocation:
                                            restaurant.restaurant_address,
                                        time: restaurant.deliver_time,
                                        free: restaurant.deliver_charges,
                                        token: restaurant.token,
                                        currency: restaurant.restraunt_currency,
                                        storeId: restaurant.uid,
                                        categories: restaurant.CategoryName,
                                        latitude: restaurant.latitude ?? 0.0,
                                        longitude: restaurant.longitude ?? 0.0,
                                        orderType: restaurant.OrderType,
                                        storeIndexId: 0,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 180,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        restaurant.restraunt_logo,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 4, 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              if (restaurant.deliver_time !=
                                                  null)
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
                                                      " ${restaurant.deliver_time ?? ""}",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                  ],
                                                ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  if (restaurant
                                                          .deliver_charges !=
                                                      null)
                                                    Row(children: [
                                                      Icon(Icons.money,
                                                          color: Colors.white),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        "${restaurant.deliver_charges ?? ""}",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 11,
                                                        ),
                                                      ),
                                                    ]),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                        height: 23,
                                                        width: 35,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color.fromRGBO(
                                                                  238,
                                                                  167,
                                                                  52,
                                                                  1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                        ),
                                                        child: StreamBuilder(
                                                          stream:
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "All_Restraunts")
                                                                  .doc(
                                                                      restaurant
                                                                          .uid)
                                                                  .collection(
                                                                      "RatingsandReviews")
                                                                  .snapshots(),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                .hasData) {
                                                              List<double>
                                                                  ratings = [];
                                                              snapshot.data!
                                                                  .docs
                                                                  .forEach(
                                                                      (ratingDoc) {
                                                                // Assuming each rating document has a field named 'Rating'
                                                                double rating =
                                                                    ratingDoc.data()["Rating"] ?? 0.0;
                                                                ratings.add(
                                                                    rating);
                                                              });

                                                              // Calculate the average rating
                                                              double averageRating =
                                                                  ratings.isNotEmpty
                                                                      ? ratings.reduce(
                                                                              (a, b) => a + b) /
                                                                          ratings.length
                                                                      : 0.0;

                                                              return Center(
                                                                child: Text(
                                                                  '${averageRating.toStringAsFixed(1)}',
                                                                  style: TextStyle(
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
                                                                  "No",
                                                                  style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Text(
                                "${restaurant.restaurant_name ?? ""}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  fetchFilteredRestaurants(QuerySnapshot snapshot) {
  return snapshot.docs.map((doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Restaurant(
      status: data['status']?.toString() ?? 'N/A',
      restraunt_logo: data['restraunt_logo']?.toString() ?? '',
      restaurant_name: data['restaurant_name']?.toString() ?? '',
      restraunt_currency: data['restraunt_currency']?.toString() ?? '',
      restaurant_address: data['restaurant_address']?.toString() ?? '',
      deliver_charges: data['deliver_charges']?.toString() ?? '',
      deliver_time: data['deliver_time']?.toString() ?? '',
      token: data['token']?.toString() ?? '',
      CategoryName: data['CategoryName']?.toString() ?? '',
      uid: data['uid']?.toString() ?? '',
      latitude: data['latitude'] as double?,
      longitude: data['longitude'] as double?,
      OrderType: data['OrderType']?.toString() ?? '',
    );
  }).toList();
}

fetchAllRestaurants() async {
  final snapshot = await FirebaseFirestore.instance
      .collection('All_Restraunts')
      .where("status", isEqualTo: "Approved")
      .get();

  if (snapshot.docs.isNotEmpty) {
    allRestaurants = fetchFilteredRestaurants(snapshot);
  }
}

}

class Restaurant {
  final String restraunt_logo;
  final String? restaurant_name;
  final String? restraunt_currency;
  final String? status;
  final String? restaurant_address;
  final String? deliver_charges;
  final String? deliver_time;
  final String? token;
  final String? CategoryName;
  final String? uid;
  final double? latitude;
  final double? longitude;
  final String? OrderType;

  Restaurant({
    required this.restraunt_logo,
    this.restaurant_name,
    this.restraunt_currency,
    this.status,
    this.restaurant_address,
    this.deliver_charges,
    this.deliver_time,
    this.token,
    this.CategoryName,
    this.uid,
    this.latitude,
    this.longitude,
    this.OrderType,
  });
}
