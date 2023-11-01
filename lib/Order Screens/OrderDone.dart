import 'package:flutter/material.dart';
import 'package:food_service/Order%20Screens/Confirm_order.dart';
import 'package:food_service/Search%20screens/Browse_food.dart';
import 'package:food_service/bottomFile.dart';
import 'package:food_service/cartChangeNotifier.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../featuredItems.dart';
import 'AddToOrder.dart';

class OrderDone extends ConsumerStatefulWidget {
  final String? restrauntName;
  final Menu itemsss;
  const OrderDone({super.key, this.restrauntName, required this.itemsss});

  @override
  ConsumerState<OrderDone> createState() => _OrderDoneState();
}

class _OrderDoneState extends ConsumerState<OrderDone> {
  late Menu items = Menu(
      title: "",
      sideItemsIds: '',
      selectedSideItemId: '',
      i: 0,
      sideItemNames: '',
      allSideItemssInMenu: [],
      price: 0,
      sideItemsPrice: 0,
      sideItems: [],
      totalPrice: 0,
      counter: 0,
      image: "",
      description: '');
  double height = 0.0, width = 0.0;
  @override
  // void initState() {
  //   super.initState();

  //   showSideItemsInCart(widget.itemsss);
  // }

  // List<Map<String, dynamic>> sideItems = [];

  // showSideItemsInCart(Menu itemsss) async {
  //   sideItems.clear(); // Clear the list before adding new side items

  //   var mybox = await Hive.openBox('SideItemsIsCheck');
  //   if (mybox.containsKey(itemsss.sideItemsIds)) {
  //     var sideItemInfo = mybox.get(itemsss.sideItemsIds);
  //     setState(() {
  //       sideItems.add({
  //         'SideItemPrice': sideItemInfo["SideItemPrice"],
  //         'SideItemName': sideItemInfo["SideItemName"],
  //       });
  //     });
  //   }
  // }
  @override
  void initState() {
    super.initState();

    // Delay for 5 seconds and then navigate to the next screen
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BottonNavigation()),
        // Replace with the screen you want to navigate to
      );
    });
  }

  Widget build(BuildContext context) {
    final totalItems = ref.watch(cart);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        // leading: IconButton(
        //   color: Colors.black,
        //   onPressed: () {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => ConfirmOrders(itemsss: items, i: 0)));
        //   },
        //   icon: Icon(Icons.arrow_back_ios),
        // ),
        title: Text(
          "Your Orders",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                  height: 350,
                  child: Stack(children: [
                    ListView.builder(
                        itemCount: totalItems.length,
                        itemBuilder: ((context, indexId) {
                          final finalItems = totalItems[indexId];
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
                                    Divider(),
                                  ],
                                ),

                                //               child: Container(
                                //                 height: 300,
                                //                 child: Row(
                                //                   children: [
                                //                     Text(
                                //                       widget.title,
                                //                       style: TextStyle(
                                //                         fontSize: 20,
                                //                         color: Colors.grey,
                                //                         fontWeight: FontWeight.w500,
                                //                       ),
                                //                     ),
                                //                     SizedBox(
                                //                       width: 10,
                                //                     ),
                                //                     Column(
                                //                       mainAxisAlignment: MainAxisAlignment.center,
                                //                       crossAxisAlignment: CrossAxisAlignment.start,
                                //                       children: [
                                //                         Text(
                                //                           widget.description,
                                //                           style: TextStyle(
                                //                             fontSize: 10,
                                //                             fontWeight: FontWeight.w500,
                                //                             color: Colors.grey,
                                //                           ),
                                //                         ),
                                //                         SizedBox(
                                //                           height: 10,
                                //                         ),
                                //                         Text(
                                //                           widget.price.toString(),
                                //                           style: TextStyle(
                                //                             fontSize: 20,
                                //                             color: Colors.grey,
                                //                             fontWeight: FontWeight.w500,
                                //                           ),
                                //                         ),
                                //                       ],
                                //                     ),
                                //                   ],
                                //                 ),
                                //               ),
                                //               ),
                                //         );
                                //       }),
                                //     ),
                                //     // Positioned(

                                //     //   child: Row(
                                //     //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //     //     children: [
                                //     //       Row(
                                //     //         mainAxisAlignment: MainAxisAlignment.start,
                                //     //         children: [
                                //     //           Text(
                                //     //             "Subtotal",
                                //     //             style: TextStyle(
                                //     //               fontSize: 20,
                                //     //               color: Colors.grey,
                                //     //               fontWeight: FontWeight.w500,
                                //     //             ),
                                //     //           ),
                                //     //         ],
                                //     //       ),
                                //     //       Row(
                                //     //         mainAxisAlignment: MainAxisAlignment.start,
                                //     //         children: [
                                //     //           Text(
                                //     //             "AUD\$${widget.price}",
                                //     //             style: TextStyle(
                                //     //               fontSize: 20,
                                //     //               color: Colors.grey,
                                //     //               fontWeight: FontWeight.w500,
                                //     //             ),
                                //     //           ),
                                //     //         ],
                                //     //       ),
                                // ],
                                // ),
                              ));
                        }))
                  ])),
              Divider(),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 318,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(248, 237, 220, 1),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 60),
                                      child: Text(
                                        "You Place the Order\nSuccessfully",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: Text(
                                        "You placed the order successfully. You will get\nyour food within 25 minutes. Thanks for using\nour services. Enjoy your food :)",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black38),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BrowseFood()));
                                          },
                                          child: Text(
                                            "KEEP BROWSING",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Color.fromRGBO(
                                                    238, 167, 52, 1)),
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: height * .5 - (width * .2),
            left: width * .4,
            child: Container(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 35,
                backgroundColor: Color.fromRGBO(248, 182, 76, 1),
                child: Icon(
                  Icons.done,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
