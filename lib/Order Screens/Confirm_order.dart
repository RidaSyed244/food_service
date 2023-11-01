
import 'package:flutter/material.dart';
import 'package:food_service/Home%20Screens/HomePage.dart';
import 'package:food_service/Order%20Screens/AddToOrder.dart';
import 'package:food_service/Order%20Screens/OrderDone.dart';
import 'package:food_service/Order%20Screens/Special_InstructionScreen.dart';
import 'package:food_service/bottomFile.dart';
import 'package:food_service/featuredItems.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class ConfirmOrders extends ConsumerStatefulWidget {
  final String? restrauntName;
  final String? restrauntLocation;
  final String? userCardNumber;
  final String? userCardExpiryDate;
  final String? storeId;
  final String? categoryId;
  final String? productId;
  final int? i;
  final Menu itemsss;
  ConfirmOrders({
    this.restrauntName,
    this.restrauntLocation,
    required this.itemsss,
    this.userCardNumber,
    this.userCardExpiryDate,
    this.categoryId,
    this.productId,
    this.i,
    this.storeId,
  });

  @override
  ConsumerState<ConfirmOrders> createState() => _ConfirmOrdersState();
}

class _ConfirmOrdersState extends ConsumerState<ConfirmOrders> {
  

  List<Map<String, dynamic>> sideItems = [];
  
 

  
  // sendNotifications() async {
  //   try {
  //     var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

  //     for (var token in selectedTokens) {
  //       var body = {
  //         "to": token,
  //         "notification": {
  //           "title": "New Order",
  //           "body": "You have a new order from ${username}",
  //         },
  //       };

  //       var response = await post(
  //         url,
  //         headers: {
  //           HttpHeaders.contentTypeHeader: 'application/json',
  //           HttpHeaders.authorizationHeader:
  //               "key=AAAAbXwSTlU:APA91bEvCpFMnWOvco-UbHMGzWOsK8yTRqL1PxHwRBCjIKcRlsYKMb1mH-P9to-VkDcIsQUOhQPq0s1XoMdEZzbpFhrGGDfV1TRqQiWreVnUPPTnGfiK8Nrw4yX-bfxYTZuYrceTZ5SH",
  //         },
  //         body: jsonEncode(body),
  //       );

  //       print('Response status: ${response.statusCode}');
  //       print('Response body: ${response.body}');
  //       print("Sending Notification to ${token}");
  //     }

  //     print("Send Notification successfully");
  //   } catch (e) {
  //     print("Notification-Error: $e");
  //   }
  // }

  

  Widget build(BuildContext context) {
   

    final totalItems = ref.watch(cart);
   

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
       
        title: Text(
          "Confirm Your Orders",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
                height: 350,
                child: Column(children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: totalItems.length,
                        itemBuilder: ((context, index) {
                          final finalItems = totalItems[index];

                          return Container(
                              height: 180,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 40, 5, 0),
                                child: Column(
                                  children: [
                                    Column(
                                      children: [
                                        Row(children: [
                                          Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white38,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                height: 18,
                                                width: 25,
                                                child: Center(
                                                    child: Text(
                                                  "${finalItems.counter}",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          249, 191, 98, 1)),
                                                )),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${finalItems.title}",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20.0),
                                                child: Text(
                                                  "Price: ${finalItems.price}",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 37.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${finalItems.description}",
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              37, 0, 20, 10),
                                          child: Container(
                                              height: 30,
                                              child:
                                                  //  ListView.builder(
                                                  //     // scrollDirection:
                                                  //     //     Axis.horizontal,
                                                  //     itemCount: sideItemss.length,
                                                  //     itemBuilder: (context, index) {
                                                  //       final finalSideItems =
                                                  //           sideItemss[index];
                                                  //               List<String> sideItemNames = finalSideItems['SideItemName'];

                                                  //       return
                                                  Row(
                                                children: [
                                                  // for (int i = 0;
                                                  //     i <
                                                  //         finalItems
                                                  //             .sideItemNames
                                                  //             .length;
                                                  //     i++)

                                                  // for (var sideItemName in sideItemNames)

                                                  Text(
                                                    "${finalItems.sideItemNames}",
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  // SizedBox(width: 200,),
                                                  Spacer(),
                                                  Text(
                                                    "Price: ${finalItems.sideItemsPrice}",
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              )
                                              // }),
                                              ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              40, 0, 20, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Price: ${finalItems.totalPrice}",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.orange,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // ListView.builder(
                                        //   itemBuilder: (context, index) {
                                        //     final finalSideItems =
                                        //         allCartItems[index];
                                        //     return Row(
                                        //       children: [
                                        //         SizedBox(
                                        //           height: 20,
                                        //         ),
                                        //         Padding(
                                        //           padding: const EdgeInsets.only(
                                        //               left: 40.0),
                                        //           child: Row(
                                        //             mainAxisAlignment:
                                        //                 MainAxisAlignment.start,
                                        //             children: [
                                        //               Text(
                                        //                 finalSideItems
                                        //                     .sideItemName,
                                        //                 style: TextStyle(
                                        //                   fontSize: 18,
                                        //                   color: Colors.grey,
                                        //                 ),
                                        //               ),
                                        //               Spacer(),
                                        //               Padding(
                                        //                 padding:
                                        //                     const EdgeInsets.only(
                                        //                         right: 20),
                                        //                 child: Text(
                                        //                   finalSideItems
                                        //                       .sideItemsPrice
                                        //                       .toString(),
                                        //                   style: TextStyle(
                                        //                     fontSize: 18,
                                        //                     color: Colors.grey,
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //             ],
                                        //           ),
                                        //         ),
                                        //       ],
                                        //     );
                                        //   },
                                        //   itemCount: sideItems.length,
                                        // ),
                                      ],
                                    ),
                                    Divider()
                                  ],
                                ),
                              ));
                        })),
                  )
                ])),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding:  EdgeInsets.all(6.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Subtotal",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Text(
                              "${totalItems.totalPrice}",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Delivery",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                "\$0",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ))
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                "${totalItems.totalPrice}",
                                style: TextStyle(
                                    color: Color.fromRGBO(249, 191, 98, 1),
                                    fontSize: 15),
                              ))
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Add more items",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(249, 191, 98, 1)),
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BottonNavigation()));
                            },
                            icon: Icon(Icons.arrow_forward_ios_outlined)),
                      ]),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Promo code",
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_forward_ios_outlined)),
                      ]),
                    ],
                  ),
                  Divider(),
                  // ValueListenableBuilder(
                  //     valueListenable:
                  //         Hive.box("SideItemsIsCheck").listenable(),
                  //     builder: (context, box, child) {
                  //       return Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Material(
                  //               color: Color.fromRGBO(238, 167, 52, 1),
                  //               borderRadius:
                  //                   BorderRadius.all(Radius.circular(6.0)),
                  //               child: MaterialButton(
                  //                 onPressed: () async {
                  //                   // for (var i = 0;
                  //                   //     i < sideItems.length;
                  //                   //     i++)
                  //                   await ref
                  //                       .read(cart.notifier)
                  //                       .saveCartToFirebase(
                  //                           totalItems.totalPrice,
                  //                           widget.itemsss.latitude,
                  //                           widget.itemsss.longitude,
                  //                           username,
                  //                           userEmail,
                  //                           widget.userCardNumber,
                  //                           widget.userCardExpiryDate,
                  //                           widget.itemsss.i,
                  //                           widget.itemsss.sideItemsIds,
                  //                           userCurrentLocation,
                  //                           widget.itemsss.storeLocation);

                  //                   // await sendNotifications();
                  //                   // selectedTokens.clear();
                  //                   print(widget.itemsss.token);

                  //                   await box.clear();
                  //                   specialInstruction.clear();
                  //                   ScaffoldMessenger.of(context)
                  //                       .clearSnackBars();
                  //                   ScaffoldMessenger.of(context).showSnackBar(
                  //                       SnackBar(
                  //                           backgroundColor:
                  //                               Color.fromRGBO(238, 167, 52, 1),
                  //                           content: const Text(
                  //                               'Order Placed Successfully',
                  //                               style: TextStyle(
                  //                                   color: Colors.white,
                  //                                   fontSize: 18,
                  //                                   fontWeight:
                  //                                       FontWeight.w500))));
                  //                   Navigator.push(
                  //                       context,
                  //                       MaterialPageRoute(
                  //                           builder: (context) => OrderDone(
                  //                               itemsss: widget.itemsss,
                  //                               restrauntName:
                  //                                   widget.restrauntName)));
                  //                 },
                  //                 minWidth: 330.0,
                  //                 height: 10.0,
                  //                 child:
                  //                     Text('CHECKOUT(${totalItems.totalPrice})',
                  //                         style: TextStyle(
                  //                           color: Colors.white,
                  //                           fontSize: 16.0,
                  //                         )),
                  //               ),
                  //             )
                  //           ]);
                  //     })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
