import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import '../Home Screens/HomePage.dart';

class PendingOrders extends StatefulWidget {
  const PendingOrders({super.key});

  @override
  State<PendingOrders> createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  List fetchAllOrders = [];
  StreamController<List<DocumentSnapshot>> _streamController =
      StreamController<List<DocumentSnapshot>>();
  Stream<List<DocumentSnapshot>> get stream => _streamController.stream;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collectionGroup("All_Orders")
        .where("deliverStatus", isEqualTo: "false")
        .where("status", isEqualTo: "Pending")
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .listen((querySnapshot) {
      _streamController.add(querySnapshot.docs);
    });
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

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
            "Pending Orders",
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
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  return Stack(
                    children: [
                      ListView.builder(
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
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 10, 15, 10),
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
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Colors.grey,
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
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
                                                    fontWeight: FontWeight.w500,
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
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5),
                                                    child: Text(
                                                      "Description: ${orderItem["ProductDescription"]}",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey,
                                                      ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 0),
                                                    child: Text(
                                                      "Special Instructions:  ${orderItem["ProductSpecialInstructions"]}",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey,
                                                      ),
                                                      maxLines: 5,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 0),
                                                    child: Text(
                                                      "Quantity:  ${orderItem["ProductQuantity"]}",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey,
                                                      ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Price: \$${orderItem["ProductPrice"]}",
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          238, 167, 52, 1),
                                                    ),
                                                  )
                                                ],
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
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Order Time: ${formattedTime}",
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
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                            }
                          })
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
