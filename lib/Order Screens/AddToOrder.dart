// ignore_for_file: unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_service/Order%20Screens/Special_InstructionScreen.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../Home Screens/Single_Restraunt.dart';
import '../cartChangeNotifier.dart';
import '../featuredItems.dart';
import 'Your_Orders.dart';

bool? isChecked = false;
int boxIndex = 0;
final cart = ChangeNotifierProvider((ref) {
  return AddToCart();
});
List cartSideItems = [];
List selectedSideItems = [];
List sideItems2 = [];

// ignore: must_be_immutable
class AddToOrder extends ConsumerStatefulWidget {
  final title;
  final image;
  final sideItemList;
  final productID;
  final description;
  int? price;
  bool? sideItemCheck;
  final currency;
  final int? i;
  final storeId;
  final int? storeIndexId;
  final Menu itemsss;
  final restrauntName;
  final productId;
  final categoryId;
  final int? indexx;
  final sideItemsIds;
  final int? length;
  final int? counter;
  final restrauntLocation;
  final int? totalPrice;
  String? token;
  AddToOrder({
    this.title,
    this.totalPrice,
    this.productID,
    this.token,
    this.sideItemList,
    this.currency,
    required this.itemsss,
    this.restrauntName,
    this.length,
    this.sideItemCheck,
    this.restrauntLocation,
    this.counter,
    this.sideItemsIds,
    this.storeIndexId,
    this.productId,
    this.i,
    this.categoryId,
    this.image,
    this.storeId,
    this.price,
    this.indexx,
    this.description,
  });

  @override
  ConsumerState<AddToOrder> createState() => _AddToOrderState();
}

class _AddToOrderState extends ConsumerState<AddToOrder> {
  List<String> items = [];
  var mybox = Hive.openBox("SideItemsIsCheck");

  @override
  Widget build(BuildContext context) {
    // final length = ref.watch(cart);

    return Scaffold(
      body: CustomScrollView(slivers: [
        AddToOrderAppBar(widget: widget),
        SliverToBoxAdapter(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
              height: 600,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.title}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "${widget.description}",
                      maxLines: 5,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("TypesOfCategory")
                          .doc(widget.storeId)
                          .collection("CategoryType")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                            child: Container(
                              height: 30,
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
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: Text(
                                            snapshot.data!.docs[storeIndexId]
                                                .data()["categoryType"],
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
                          return Center(child: Text(""));
                        }
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                      height: 250,
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('Categories')
                              .doc(widget.storeId)
                              .collection('Category')
                              .doc(widget.categoryId)
                              .collection('Products')
                              .snapshots(),
                          builder: (context, snapshot) {
                            sideItems2 = snapshot.data?.docs[widget.indexx!]
                                    .data()["SideItems"] ??
                                [];
                            if (snapshot.hasData) {
                              return Column(children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Add Side Items",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Material(
                                            color: Color.fromARGB(
                                                255, 255, 228, 187),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6.0)),
                                            child: MaterialButton(
                                              onPressed: () async {},
                                              minWidth: 30.0,
                                              height: 10.0,
                                              child: Text('REQUIRED',
                                                  style: TextStyle(
                                                    color: Colors.orange,
                                                    fontSize: 16.0,
                                                  )),
                                            ),
                                          )
                                        ]),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 180,
                                  child: ValueListenableBuilder(
                                    valueListenable:
                                        Hive.box("SideItemsIsCheck")
                                            .listenable(),
                                    builder: (context, box, child) {
                                      return Consumer(
                                        builder: (context, watch, child) {
                                          final sideItemId = snapshot
                                              .data?.docs[widget.indexx!].id;

                                          return ListView.builder(
                                            itemCount:
                                                widget.sideItemList.length,
                                            itemBuilder: (context, index) {
                                              final sideItemsss =
                                                  widget.sideItemList[index];
                                              final sideItemNP = {
                                                "SideItemPrice": sideItemsss[
                                                    "sideItemPrice"],
                                                "SideItemName":
                                                    sideItemsss["sideItemName"],
                                              };

                                              return Column(
                                                children: [
                                                  ListTile(
                                                    subtitle: Text(
                                                        "Price: ${sideItemsss["sideItemPrice"]}",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        )),
                                                    trailing: IconButton(
                                                      onPressed: () async {
                                                        setState(() {
                                                          box.delete(
                                                              sideItemId);
                                                          ref
                                                              .read(
                                                                  cart.notifier)
                                                              .removeSideItem(
                                                                  widget
                                                                      .itemsss,
                                                                  sideItemId);
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .clearSnackBars();
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              backgroundColor:
                                                                  Color
                                                                      .fromRGBO(
                                                                          238,
                                                                          167,
                                                                          52,
                                                                          1),
                                                              content:
                                                                  const Text(
                                                                'Choosed item deleted',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                      },
                                                      icon: Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    leading: IconButton(
                                                      icon: Icon(Icons.add),
                                                      onPressed: () async {
                                                        setState(() {
                                                          // Put selected side item into Hive box
                                                          box.put(sideItemId,
                                                              sideItemNP);
                                                          final cartu =
                                                              ref.read(cart
                                                                  .notifier);
                                                          cartu
                                                              .addSideItemToProduct(
                                                            widget.itemsss,
                                                            widget.sideItemsIds,
                                                          );
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .clearSnackBars();
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              backgroundColor:
                                                                  Color
                                                                      .fromRGBO(
                                                                          238,
                                                                          167,
                                                                          52,
                                                                          1),
                                                              content:
                                                                  const Text(
                                                                'Side item added',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                          // Update the total price
                                                          final sideItemPrice =
                                                              sideItemsss[
                                                                      "sideItemPrice"] ??
                                                                  0.0;
                                                          ref
                                                              .read(
                                                                  cart.notifier)
                                                              .updateTotalPrice(
                                                                  sideItemPrice);
                                                        });
                                                      },
                                                    ),
                                                    title: Text(
                                                        "${sideItemsss["sideItemName"]}",
                                                        style: TextStyle(
                                                          fontSize: 19,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        )),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ]);
                            } else {
                              return Center(
                                child: Text(''),
                              );
                            }
                          })),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Add Special Instructions",
                            style: TextStyle(
                              fontSize: 20,
                            ),
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
                                      builder: (context) => SpecialInstructions(
                                          itemsss: widget.itemsss)));
                            },
                            icon: Icon(Icons.arrow_forward_ios_outlined)),
                      ]),
                    ],
                  ),
                  Divider(),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Material(
                          color: Color.fromARGB(255, 240, 238, 236),
                          borderRadius: BorderRadius.all(Radius.circular(70.0)),
                          child: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () async {
                              final cartu = ref.read(cart.notifier);
                              await ref
                                  .read(cart.notifier)
                                  .increaseCount(widget.itemsss);
                              await cartu.addToCart(
                                widget.itemsss,
                                widget.sideItemsIds,
                              );
                              selectedTokens.add(widget.token ?? "");
                            },
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      Material(
                          color: Color.fromARGB(255, 240, 238, 236),
                          borderRadius: BorderRadius.all(Radius.circular(70.0)),
                          child: IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () async {
                              ref
                                  .read(cart.notifier)
                                  .decreaseCount(widget.itemsss);
                              final cartu = ref.read(cart.notifier);
                              cartu.removeFromCart(widget.itemsss);
                            },
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  //  for (var i = 0; i < sideItems.length; i++)
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Material(
                      color: Color.fromRGBO(238, 167, 52, 1),
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      child: MaterialButton(
                        onPressed: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => YourOrders(
                                        storeId: widget.storeId,
                                        categoryId: widget.categoryId,
                                        productId: widget.productId,
                                        restrauntName: widget.restrauntName,
                                        restrauntLocation:
                                            widget.restrauntLocation,
                                        productName: widget.title,
                                        itemsss: widget.itemsss,
                                        indexSI: widget.indexx,
                                        i: widget.i!,
                                        currency: widget.currency,

                                        // sideItemName: widget
                                        //     .itemsss.sideItems[widget.indexx],
                                        // sideItemName: sideItems[widget.indexx]["isChecked"],
                                        // sideItemPrice:
                                      )));
                        },
                        minWidth: 330.0,
                        height: 10.0,
                        child: Text('ADD TO ORDER',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            )),
                      ),
                    )
                  ]),
                ],
              )),
        )),
      ]),
    );
  }
}

class AddToOrderAppBar extends StatelessWidget {
  const AddToOrderAppBar({
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
        child: CircleAvatar(
            radius: 13,
            backgroundColor: Colors.grey,
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SingleRestraunt(
                                title: "",
                                image: '',
                                discription: '',
                                time: '',
                                free: '',
                                currency: '',
                                categories: 0,
                                storeId: '',
                                // storeIndexId: 0,
                              )));
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ))),
      ),
    );
  }
}
