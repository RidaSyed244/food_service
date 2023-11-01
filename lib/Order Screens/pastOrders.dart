import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_service/Drawer_Screens/add_Ratings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

var selectedOrder;
var selectedOrderDocId;
List selectedOrderListToUpdate = [];

class PastOrders extends ConsumerStatefulWidget {
  const PastOrders({super.key});

  @override
  ConsumerState<PastOrders> createState() => _PastOrdersState();
}

class _PastOrdersState extends ConsumerState<PastOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Past Orders",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collectionGroup("All_Orders")
            .orderBy("OrderTime", descending: true)
            .where("deliverStatus", isEqualTo: "true")
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                final allOrders = snapshot.data?.docs[index];
                final orderItems = allOrders?["products"] ?? [];
                final time = allOrders?["OrderTime"] as Timestamp;

                DateTime dateTime = time.toDate();
                String formattedDate =
                    DateFormat('EEE, M/d/y').format(dateTime);
                String formattedTime = DateFormat('h:mm a').format(dateTime);
                final orderDocId = snapshot.data!.docs[index];

                return Column(
                  children: [
                    for (var orderItem in orderItems)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.grey,
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              orderItem["ProductImage"],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        orderItem["ProductName"],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 19,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              DefaultTextStyle(
                                style: const TextStyle(color: Colors.black54),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Description:  ${orderItem["ProductDescription"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                          ),
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Special Instructions:  ${orderItem["ProductSpecialInstructions"] ?? "Not Added"}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                          ),
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 0),
                                          child: Text(
                                            "Quantity:  ${orderItem["ProductQuantity"]}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
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
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromRGBO(238, 167, 52, 1),
                                          ),
                                        )
                                      ],
                                    ),
                                    if (orderItem.containsKey("Side_Items"))
                                      Column(
                                        children: [
                                          for (var sideItem
                                              in orderItem["Side_Items"])
                                            Row(
                                              children: [
                                                Text(
                                                  "Side Item:     ${sideItem["SideItemName"]}",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(
                                                  "Price: ${sideItem["SideItemPrice"]}",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 0),
                                          child: Text(
                                            "Restaurant:  ${orderItem["Store_Name"]}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Restaurant Location:  ${orderItem["Store_Location"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                        maxLines: 7,
                                        overflow: TextOverflow.ellipsis,
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
                                          overflow: TextOverflow.ellipsis,
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
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Material(
                                              color: Colors.orange,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6.0)),
                                              child: MaterialButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    selectedOrder =
                                                        allOrders?["Store_uid"];
                                                    selectedOrderDocId =
                                                        orderDocId.id;
                                                    selectedOrderListToUpdate
                                                        .add(allOrders?[
                                                            "Rating"]);
                                                    /////////////
                                                  });

                                                  // print(
                                                  //     selectedOrderListToUpdate);
                                                  // navigate(orderDocId
                                                  //     .toString());-
                                                  if (allOrders?["Rating"] ==
                                                      "Added_Review") {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                            "Review Already Added",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          content: Text(
                                                            "You have already provided a review for this order.",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                "OK",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .orange),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  } else if (allOrders?[
                                                          "Rating"] ==
                                                      "Not_Added") {
                                                    if (selectedOrderDocId !=
                                                        null) {
                                                     
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        AddRatings(
                                                                          StoreUid:
                                                                              allOrders?["Store_uid"],
                                                                          orderDocId:
                                                                              orderDocId.id,
                                                                        )));
                                                    }
                                                  }

                                                  print(FirebaseAuth.instance
                                                      .currentUser!.uid);

                                                  print(
                                                      "selectedUid: $selectedOrderListToUpdate");
                                                  print(
                                                      "storeid: ${orderDocId.id.toString()}");
                                                  print(
                                                      "OrderDocId: ${selectedOrderDocId}");
                                                },
                                                minWidth: 20.0,
                                                height: 8.0,
                                                child: Text('Add Ratings',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.0,
                                                    )),
                                              ))
                                        ]),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              },
            );
          } else {
            return Center(
              child: Text("No Orders Yet"),
            );
          }
        },
      ),
    );
  }
}
