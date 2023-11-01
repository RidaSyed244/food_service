import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_service/featuredItems.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../StateManagement.dart';
import 'AddToOrder.dart';
import 'Confirm_order.dart';

List fetchAllOrders = [];
final previouOrders = StateNotifierProvider((ref) => Services());
late Menu items = Menu(
    title: "Chicken Burger",
    price: 200,
    selectedSideItemId: '',
    image: "assets/images/burger.png",
    description: "Chicken Burger",
    i: 0,
    sideItemsPrice: 0,
    sideItemsIds: '',
    sideItems: [],
    allSideItemssInMenu: [],
    sideItemNames: '');

class PreviousOrders extends ConsumerStatefulWidget {
  final Menu itemsss;
  const PreviousOrders({
    super.key,
    required this.itemsss,
  });

  @override
  ConsumerState<PreviousOrders> createState() => _PreviousOrdersState();
}

class _PreviousOrdersState extends ConsumerState<PreviousOrders> {
  bool isVisible11 = true;
  bool isVisible22 = true;

  @override
  Widget build(BuildContext context) {
    final totalItems = ref.watch(cart);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Your Orders",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(padding: EdgeInsets.fromLTRB(20, 20, 20, 10), children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "UPCOMING ORDERS",
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    )
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     TextButton(
                //         onPressed: () {
                //           setState(() {
                //             isVisible11 = !isVisible11;
                //             ref.read(previouOrders.notifier).claerFirstList();
                //           });
                //         },
                //         child: Text(
                //           "CLEAR ALL",
                //           style: TextStyle(color: Colors.grey, fontSize: 12),
                //         ))
                //   ],
                // )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
              visible: isVisible11,
              child: Container(
                  height: 350,
                  child: Stack(children: [
                    ListView.builder(
                        itemCount: totalItems.length,
                        itemBuilder: ((context, index) {
                          final finalItems = totalItems[index];
                          return Container(
                              height: 120,
                              child: Column(children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.grey),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            finalItems.image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: DefaultTextStyle(
                                        style: const TextStyle(
                                            color: Colors.black54),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              finalItems.title,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              child: Text(
                                                "${finalItems.description}",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                const Text("\$\$"),
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8),
                                                  child: CircleAvatar(
                                                    radius: 2,
                                                    backgroundColor:
                                                        Colors.black38,
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(
                                                  "PriceP:\$${finalItems.totalPrice}",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromRGBO(
                                                        238, 167, 52, 1),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ]));
                        }))
                  ])),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ConfirmOrders(
                                        i: 0,
                                        itemsss: widget.itemsss,
                                      )));
                        },
                        child: Text(
                          "Proceed Payment",
                          style: TextStyle(
                              color: Color.fromRGBO(238, 167, 52, 1),
                              fontSize: 17),
                        ))
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "PAST ORDERS",
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    )
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     TextButton(
                //         onPressed: () {
                //           setState(() {
                //             isVisible22 = !isVisible22;
                //             ref.read(previouOrders.notifier).claerSecondList();
                //           });
                //         },
                //         child: Text(
                //           "CLEAR ALL",
                //           style: TextStyle(color: Colors.grey, fontSize: 12),
                //         ))
                //   ],
                // )
              ],
            ),
            Visibility(
              visible: isVisible22,
              child: Container(
                  height: 200,
                  child: Stack(children: [
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("AllOrders")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("Orders")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasData) {
                            return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: ((context, index) {
                                  final allOrders =
                                      snapshot.data!.docs[index].data();

                                  fetchAllOrders = allOrders["products"] ?? [];
                                  final previousfood =
                                      snapshot.data!.docs[index];
                                  return Container(
                                      height: 110,
                                      child: Column(children: [
                                        for (var i = 0;
                                            i < fetchAllOrders.length;
                                            i++)
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 100,
                                                height: 100,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Colors.grey),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.network(
                                                      fetchAllOrders[i]
                                                          ["ProductImage"],
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              Expanded(
                                                child: DefaultTextStyle(
                                                  style: const TextStyle(
                                                      color: Colors.black54),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        fetchAllOrders[i]
                                                            ["ProductName"],
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 10),
                                                        child: Text(
                                                          "${fetchAllOrders[i]["ProductDescription"]}",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Text("\$\$"),
                                                          const Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        8),
                                                            child: CircleAvatar(
                                                              radius: 2,
                                                              backgroundColor:
                                                                  Colors
                                                                      .black38,
                                                            ),
                                                          ),
                                                          // Text(
                                                          // "${previousfood.foodType}"),
                                                          Spacer(),
                                                          Text(
                                                            "Price: \$${previousfood["subtotal"]}",
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      238,
                                                                      167,
                                                                      52,
                                                                      1),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                      ]));
                                }));
                          } else {
                            return Center(child: Text("No Orders Yet"));
                          }
                        })
                  ])),
            ),
          ],
        )
      ]),
    );
  }
}
