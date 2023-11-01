import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import '../Home Screens/HomePage.dart';
import 'dart:ui' as ui;

class FreshOrders extends StatefulWidget {
  const FreshOrders({super.key});

  @override
  State<FreshOrders> createState() => _FreshOrdersState();
}

class _FreshOrdersState extends State<FreshOrders> {
  List fetchAllOrders = [];
  StreamController<List<DocumentSnapshot>> _streamController =
      StreamController<List<DocumentSnapshot>>();
  Stream<List<DocumentSnapshot>> get stream => _streamController.stream;
  BitmapDescriptor carIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collectionGroup("All_Orders")
        .where("deliverStatus", isEqualTo: "false")
        .where("status", isEqualTo: "Accept")
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .listen((querySnapshot) {
      _streamController.add(querySnapshot.docs);
    });
    getUserLatitude();
    getUserLongitude();
    _loadCustomIcon();
    loadDriverData();
    loadRestrauntData();
    loadPersonImage();
    // getCurrentOrdersAndLocations();
    // Load the custom car icon
    // BitmapDescriptor.fromAssetImage(
    //   ImageConfiguration(
    //       devicePixelRatio: 2.5,
    //       size: Size(5, 5)), // Adjust the pixel ratio as needed
    //   'assets/images/car.png', // Path to your custom icon
    // ).then((icon) {
    //   carIcon == icon;
    // });
  }

  Future<void> _loadCustomIcon() async {
    final resizedImageAsset =
        'assets/images/car.png'; // Use the actual asset path
    final icon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        devicePixelRatio: 2.5,
      ), // Adjust the pixel ratio as needed
      resizedImageAsset,
    );

    setState(() {
      carIcon = icon;
    });

    // Rest of your code...
  }

  var userLatitude;
  var userLongitude;
  LatLng restaurantLocation = LatLng(0, 0);
  LatLng driverLocation = LatLng(0, 0);

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

  StreamSubscription<DocumentSnapshot>? locationSubscription;
  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Uint8List? driverImages;
  Uint8List? restaurantImages;
  Uint8List? personImage;

  void loadDriverData() async {
    driverImages = await getImages(
        'assets/images/car.png', 100); // Replace with your icon path
    setState(() {});
  }

  void loadPersonImage() async {
    personImage = await getImages(
        'assets/images/people.png', 100); // Replace with your icon path
    setState(() {});
  }

  void loadRestrauntData() async {
    restaurantImages = await getImages(
        'assets/images/restaurant.png', 100); // Replace with your icon path
    setState(() {});
  }
  // getCurrentOrdersAndLocations() async {
  //   //Fetch latitiude and longitude fields of each document in this collection restaurant
  //   FirebaseFirestore.instance
  //       .collectionGroup("All_Orders")
  //       .where("deliverStatus", isEqualTo: "false")
  //       .where("status", isEqualTo: "Accept")
  //       .where("uid", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
  //       .get()
  //       .then((querySnapshot) {
  //     querySnapshot.docs.forEach((result) {
  //       //I want to show location of both restraunts on ,map not in print format
  //       restaurantLocation = LatLng(
  //           result.data()["Store_latitude"], result.data()["Store_longitude"]);
  //     });
  //   });
  //   //Not only print but fetch the latitude and longitude fields of each document in this collection
  // }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  GoogleMapController? _controller;

  // Future<void> mymap(
  //     AsyncSnapshot<List<DocumentSnapshot<Object?>>> snapshot) async {
  //   await _controller
  //       .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //           target: LatLng(
  //             snapshot.data!.singleWhere(
  //                 (element) => element.id == widget.user_id)['latitude'],
  //             snapshot.data!.singleWhere(
  //                 (element) => element.id == widget.user_id)['longitude'],
  //           ),
  //           zoom: 14.47)));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.orange,
          leading: IconButton(
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                            address: '',
                          )));
            },
            icon: Icon(Icons.close),
          ),
          title: Text(
            "Fresh Orders",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Container(
          child: StreamBuilder(
              stream: stream,
              builder: (context, snapshot) {
                // mymap(snapshot);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  LatLng userLocation = LatLng(userLatitude, userLongitude);
                  List<Marker> restaurantMarkers = [];
                  List<Polyline> polylines = [];
                  List<Marker> driverMarkers = [];
                  final allOrdersDelivered = snapshot.data!.every((result) {
                    final data = result.data() as Map<String, dynamic>;
                    return data["deliverStatus"] == "true";
                  });
                  // final allPendingOrders = snapshot.data!.indexWhere((result) {
                  //   final data = result.data() as Map<String, dynamic>;
                  //   return data["status"] == "Pending";
                  // });

                  if (allOrdersDelivered) {
                    // All orders are delivered, show a text message
                    return Center(
                      child: Container(
                        height: 100,
                        width: 250,
                        color: Colors.orange,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "All orders are delivered.\nPlease order again!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    );
                  }
                  snapshot.data?.forEach((result) {
                    Map<String, dynamic> data = result.data()
                        as Map<String, dynamic>; // Cast the data to Map

                    restaurantLocation = LatLng(
                      data["Store_latitude"],
                      data["Store_longitude"],
                    );

                    restaurantMarkers.add(Marker(
                      markerId: MarkerId(result.id),
                      position: restaurantLocation,
                      icon: BitmapDescriptor.fromBytes(restaurantImages!),
                      infoWindow: InfoWindow(
                        title: 'Restraunt', // Customize this label as needed
                      ),
                    ));

                    polylines.add(Polyline(
                      polylineId: PolylineId('route-${result.id}'),
                      points: [userLocation, restaurantLocation],
                      color: Colors.blue,
                    ));
                    // Check if the statusByDriver is "Accepted"
                    if (data["statusByDriver"] == "Accepted") {
                      driverLocation = LatLng(
                        data["Driver_latitude"],
                        data["Driver_longitude"],
                      );
                      print(
                          "Driver Location: $driverLocation"); // Debugging line

                      driverMarkers.add(Marker(
                        markerId: MarkerId('Driver-${result.id}'),
                        position: driverLocation,
                        icon: BitmapDescriptor.fromBytes(
                            driverImages!), // Use your custom driver icon
                        infoWindow: InfoWindow(
                          title: 'Driver', // Customize this label as needed
                        ),
                      ));

                      polylines.add(Polyline(
                        polylineId: PolylineId('route-Driver-${result.id}'),
                        points: [userLocation, driverLocation],
                        color: Colors.green,
                      ));
                      _controller?.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: driverLocation,
                            // zoom: 14.47,
                          ),
                        ),
                      );
                    }
                  });
                  return Stack(
                    children: [
                      Container(
                        height: 400,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: userLocation,
                            zoom: 14,
                          ),
                          markers: {
                            ...restaurantMarkers,
                            Marker(
                              markerId: MarkerId(
                                'All_Restaurants',
                              ),
                              icon:
                                  BitmapDescriptor.fromBytes(restaurantImages!),
                              infoWindow: InfoWindow(
                                title:
                                    'Restraunt', // Customize this label as needed
                              ),
                              position: restaurantLocation,
                            ),
                            Marker(
                              markerId: MarkerId('User'),
                              position: userLocation,
                              icon: BitmapDescriptor.fromBytes(personImage!),
                              infoWindow: InfoWindow(
                                title: 'User', // Customize this label as needed
                              ),
                            ),
                            ...driverMarkers,
                            Marker(
                              markerId: MarkerId('Driver'),
                              position: driverLocation,
                              icon: BitmapDescriptor.fromBytes(
                                  driverImages!), // Use your custom driver icon
                              infoWindow: InfoWindow(
                                title:
                                    'Driver', // Customize this label as needed
                              ),
                            ),
                          },
                          polylines: Set<Polyline>.from(polylines),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 410.0),
                        child: ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              final allOrders = snapshot.data![index];
                              fetchAllOrders = allOrders["products"] ?? [];
                              // DocumentSnapshot orderId = snapshot.data![index];
                              final time = allOrders["OrderTime"] as Timestamp;

                              DateTime dateTime = time.toDate();
                              String formattedDate =
                                  DateFormat('EEE, M/d/y').format(dateTime);
                              String formattedTime =
                                  DateFormat('h:mm a').format(dateTime);
                              for (var orderItem in fetchAllOrders) {
                                return Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 10, 15, 10),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 10, 15, 20),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 40,
                                                    height: 40,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: Colors.grey,
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Image.network(
                                                          orderItem[
                                                              "ProductImage"],
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    orderItem["ProductName"],
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 17,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // Row(
                                              //   children: [
                                              //     if (orderItem["statusByDriver"] ==
                                              //         "Accepted")
                                              //       Icon(Icons.check_circle,
                                              //           color: Colors.green),
                                              //     if (orderItem["statusByDriver"] ==
                                              //         "Rejected")
                                              //       Icon(Icons.cancel, color: Colors.red),
                                              //     if (allOrders["status"] == "Pending")
                                              //       Icon(Icons.pending,
                                              //           color: Colors.orange),
                                              //   ],
                                              // )
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          DefaultTextStyle(
                                            style: const TextStyle(
                                                color: Colors.black54),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      "Description: ${orderItem["ProductDescription"]}",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey,
                                                      ),
                                                      maxLines: 5,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      "Special Instructions:  ${orderItem["ProductSpecialInstructions"] ?? "Not Added"}",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey,
                                                      ),
                                                      maxLines: 5,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Restraunt: ${orderItem["Store_Name"]}",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey,
                                                      ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    "Restraunt Location: ${orderItem["Store_Location"]}",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey,
                                                    ),
                                                    maxLines: 7,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    "Order Time: ${formattedTime}",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Order Date: ${formattedDate}",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey,
                                                      ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                                // Row(
                                                //   children: [
                                                //     Text(
                                                //       "Your Location: ${allOrders["UserLocation"]} ",
                                                //       style: TextStyle(
                                                //         fontSize: 16,
                                                //         color: Colors.grey,
                                                //       ),
                                                //       maxLines: 2,
                                                //       overflow: TextOverflow.ellipsis,
                                                //     ),
                                                //   ],
                                                // ),
                                                // Row(
                                                //   children: [
                                                //     Text(
                                                //       "Your Name: ${allOrders["UserName"]} ",
                                                //       style: TextStyle(
                                                //         fontSize: 16,
                                                //         color: Colors.grey,
                                                //       ),
                                                //       maxLines: 2,
                                                //       overflow: TextOverflow.ellipsis,
                                                //     ),
                                                //   ],
                                                // ),
                                                if (orderItem
                                                    .containsKey("Side_Items"))
                                                  Column(
                                                    children: [
                                                      for (var sideItem
                                                          in orderItem[
                                                              "Side_Items"])
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Side Item:     ${sideItem["SideItemName"]}",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                            Spacer(),
                                                            Text(
                                                              "Price: ${sideItem["SideItemPrice"]}",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                    ],
                                                  ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Quantity: ${orderItem["ProductQuantity"]}",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey,
                                                      ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Restraunt Status: ${allOrders["status"]}",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Driver Status: ${allOrders["statusByDriver"]}",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));
                              }
                            }),
                      )
                    ],
                  );
                } else {
                  return Center(
                    child: Container(
                      height: 80,
                      width: 250,
                      color: Colors.orange,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "No orders yet",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  );
                }

                // } else {
                //   return Center(
                //     child: Container(
                //       height: 80,
                //       width: 250,
                //       color: Colors.orange,
                //       child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Text(
                //           "No orders yet",
                //           textAlign: TextAlign.center,
                //           style: TextStyle(
                //               fontSize: 20,
                //               color: Colors.white,
                //               fontWeight: FontWeight.w600),
                //         ),
                //       ),
                //     ),
                //   );
                // }
              }),
        ));
  }
}
