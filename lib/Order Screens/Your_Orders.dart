import 'package:flutter/material.dart';
import 'package:food_service/Order%20Screens/AddToOrder.dart';
import 'package:food_service/Order%20Screens/ConFirmYourOrder.dart';
import 'package:food_service/Order%20Screens/Confirm_order.dart';
import 'package:food_service/Payment%20Screens/AddPaymentMethod.dart';
import 'package:food_service/bottomFile.dart';
import 'package:food_service/featuredItems.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../Screens/Filters.dart';

class YourOrders extends ConsumerStatefulWidget {
  final String? storeId;
  final String? categoryId;
  final Menu itemsss;
  final String? productId;
  final String? productName;
  final String? sideItemName;
  final String? restrauntName;
  final String? restrauntLocation;
  final int? indexSI;
  final int i;
  final String? currency;
  YourOrders(
      {this.storeId,
      this.categoryId,
      required this.itemsss,
      this.indexSI,
      this.sideItemName,
      this.productName,
      this.restrauntLocation,
      this.productId,
      this.currency,
      required this.i,
      this.restrauntName});
  @override
  ConsumerState<YourOrders> createState() => _YourOrdersState();
}

class _YourOrdersState extends ConsumerState<YourOrders> {
  List<Map<String, dynamic>> sideItems3 = [];
  // var mybox = Hive.openBox('SideItemsIsCheck');

  // showSideItemsInCart(Menu itemsss) async {
  //   // sideItems.clear(); // Clear the list before adding new side items

  //   var mybox = await Hive.openBox('SideItemsIsCheck');
  //   if (mybox.containsKey(itemsss.sideItemsIds)) {
  //     var sideItemInfo = mybox.get(itemsss.sideItemsIds);
  //     setState(() {
  //       sideItemss.add({
  //         'SideItemPrice': sideItemInfo["SideItemPrice"],
  //         'SideItemName': sideItemInfo["SideItemName"],
  //       });
  //     });
  //   }
  // }

  // @override
  // void initState() {
  //   showSideItemsInCart(widget.itemsss);
  //   super.initState();
  // }

  Widget build(BuildContext context) {
    final totalItems = ref.watch(cart);
    // final subtotalls = ref.watch(cartSubTotalProvider);
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
                    builder: (context) => AddToOrder(
                          title: "",
                          totalPrice: 0,
                          itemsss: items,
                          image: '',
                          i: 0,
                          indexx: 0,
                          counter: 0,
                          price: 0,
                          description: '',
                        )));
          },
          icon: Icon(Icons.close),
        ),
        title: Text(
          "Your Orders",
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
                                                    fontSize: 19,
                                                    color: Colors.orange,
                                                    fontWeight:
                                                        FontWeight.w500),
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
              padding: const EdgeInsets.all(6.0),
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
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${totalItems.totalPrice}",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )
                          ],
                        ),
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
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Material(
                      color: Color.fromRGBO(238, 167, 52, 1),
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      child: MaterialButton(
                        onPressed: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => 
                                AddPayementMethod(
                                  totalItems:totalItems,
                                    restrauntName: widget.restrauntName,
                                    itemsss: widget.itemsss,
                                    restrauntLocation:
                                        widget.restrauntLocation,
                                    storeId: widget.storeId,
                                    categoryId: widget.categoryId,
                                    productId: widget.productId,
                                    i: widget.i,
                                    indexSI: widget.indexSI,
                                    subtotalForPayment:
                                        totalItems.totalPrice)
                              ));
                        },
                        minWidth: 330.0,
                        height: 10.0,
                        child: Text('CONTINUE(${totalItems.totalPrice})',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            )),
                      ),
                    )
                  ]),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
