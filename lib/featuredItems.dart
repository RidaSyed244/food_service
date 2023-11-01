// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_service/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

////Browse food /////
class FoodItems {
  String image;
  String title;
  String discription;
  String time;
  String free;
  String box;
  String area;

  FoodItems(
      {required this.image,
      required this.title,
      required this.discription,
      required this.time,
      required this.free,
      required this.box,
      required this.area});
}

class UpcomingFood {
  String image;
  String title;
  String discription;
  String foodType;
  double price;
  UpcomingFood({
    required this.image,
    required this.title,
    required this.discription,
    required this.foodType,
    required this.price,
  });
}

List<UpcomingFood> upComingFoods = [
  UpcomingFood(
      image:
          "https://images.unsplash.com/photo-1618411640018-972400a01458?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8a3Jpc3B5JTIwY3JlbWV8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60",
      title: "Mcdonald's",
      discription: "Shortbread, chocolate turtle,\ncookies and red velvet",
      foodType: "Chinese",
      price: 10.0),
  UpcomingFood(
      image:
          "https://images.unsplash.com/photo-1618411640018-972400a01458?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8a3Jpc3B5JTIwY3JlbWV8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60",
      title: "Mcdonald's",
      discription: "Shortbread, chocolate turtle,\ncookies and red velvet",
      foodType: "Chinese",
      price: 10.0),
  UpcomingFood(
      image:
          "https://images.unsplash.com/photo-1618411640018-972400a01458?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8a3Jpc3B5JTIwY3JlbWV8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60",
      title: "Mcdonald's",
      discription: "Shortbread, chocolate turtle,\ncookies and red velvet",
      foodType: "Chinese",
      price: 10.0),
  UpcomingFood(
      image:
          "https://images.unsplash.com/photo-1618411640018-972400a01458?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8a3Jpc3B5JTIwY3JlbWV8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60",
      title: "Mcdonald's",
      discription: "Shortbread, chocolate turtle,\ncookies and red velvet",
      foodType: "Chinese",
      price: 10.0),
  UpcomingFood(
      image:
          "https://images.unsplash.com/photo-1618411640018-972400a01458?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8a3Jpc3B5JTIwY3JlbWV8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60",
      title: "Mcdonald's",
      discription: "Shortbread, chocolate turtle,\ncookies and red velvet",
      foodType: "Chinese",
      price: 10.0),
  UpcomingFood(
      image:
          "https://images.unsplash.com/photo-1618411640018-972400a01458?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8a3Jpc3B5JTIwY3JlbWV8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60",
      title: "Mcdonald's",
      discription: "Shortbread, chocolate turtle,\ncookies and red velvet",
      foodType: "Chinese",
      price: 10.0),
  UpcomingFood(
      image:
          "https://images.unsplash.com/photo-1618411640018-972400a01458?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8a3Jpc3B5JTIwY3JlbWV8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60",
      title: "Mcdonald's",
      discription: "Shortbread, chocolate turtle,\ncookies and red velvet",
      foodType: "Chinese",
      price: 10.0),
];
List<FoodItems> browseFood = [
  FoodItems(
      time: "25 min",
      free: "Free",
      area: "America",
      box: "4.5",
      title: 'Tacos Nanchas',
      image:
          'https://images.unsplash.com/photo-1611908957204-1c8ab9d88c8c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fHRhY29zJTIwbmFuYWNoYXN8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60',
      discription: "Chinese"),
  FoodItems(
      time: "25 min",
      free: "Free",
      area: "America",
      box: "4.5",
      title: 'Tacos Nanchas',
      image:
          'https://images.unsplash.com/photo-1638902427911-7cb57511a58b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bWFjZG9uYWxkc3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=400&q=60',
      discription: "Chinese"),
  FoodItems(
      time: "25 min",
      free: "Free",
      area: "America",
      box: "4.5",
      title: 'Tacos Nanchas',
      image:
          'https://images.unsplash.com/photo-1523798724321-364e1951df59?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGtmYyUyMGZvb2RzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=400&q=60',
      discription: "Chinese"),
  FoodItems(
      time: "25 min",
      free: "Free",
      area: "America",
      box: "4.5",
      title: 'Tacos Nanchas',
      image:
          'https://images.unsplash.com/photo-1511920170033-f8396924c348?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Y2FmZSUyMG1heWZpZWxkc3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=400&q=60',
      discription: "Chinese"),
  FoodItems(
      time: "25 min",
      free: "Free",
      area: "America",
      box: "4.5",
      title: 'Tacos Nanchas',
      image:
          'https://images.unsplash.com/photo-1550547660-d9450f859349?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8YnVyZ2VyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=400&q=60',
      discription: "Chinese"),
  FoodItems(
      time: "25 min",
      free: "Free",
      area: "America",
      box: "4.5",
      title: 'Tacos Nanchas',
      image:
          'https://images.unsplash.com/photo-1509042239860-f550ce710b93?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y29mZmVlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=400&q=60',
      discription: "Chinese"),
  FoodItems(
      time: "25 min",
      free: "Free",
      area: "America",
      box: "4.5",
      title: 'Tacos Nanchas',
      image:
          'https://images.unsplash.com/photo-1619894991209-9f9694be045a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bGF6YW5pYXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=400&q=60',
      discription: "Chinese"),
  FoodItems(
      time: "25 min",
      free: "Free",
      area: "America",
      box: "4.5",
      title: 'Tacos Nanchas',
      image:
          'https://images.unsplash.com/photo-1584190926897-0023f6aa05f9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cGl6emElMjBodXR8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60',
      discription: "Chinese"),
  FoodItems(
      time: "25 min",
      free: "Free",
      area: "America",
      box: "4.5",
      title: 'Tacos Nanchas',
      image:
          'https://images.unsplash.com/photo-1654170990161-e9d0c2d345d4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cmVzdHJhdW50c3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=400&q=60',
      discription: "Chinese"),
  FoodItems(
      time: "25 min",
      free: "Free",
      area: "America",
      box: "4.5",
      title: 'Tacos Nanchas',
      image:
          'https://images.unsplash.com/photo-1606755456206-b25206cde27e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8ZnJlbmNoJTIwZnJpZXN8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60',
      discription: "Chinese"),
];

//////////////////////////////////////
///
class Menu {
  final String title;
  final i;
  final String image;
  final String selectedSideItemId;
String ?token;
  int price;
  double? latitude;
  String  specialInstructions;
  double? longitude;
  String? storeId;
  double subtotal;
  List cartSideItems = [];
  bool? isSlected;
  int sideItemsPrice;
  final String? restrauntName;
  final String? storeLocation;
  String sideItemsIds;
  List sideItems;
  int quantity;
  List allSideItemssInMenu;
  int counter;
  int indexx;
  String sideItemNames; // new field
  int totalPrice;
  final String description;
  Menu({
    required this.title,
    this.restrauntName,
    this.token,
    this.specialInstructions='',
    this.storeLocation,
    required this.selectedSideItemId,
    this.i,
    this.storeId,
    this.longitude,
    this.latitude,
    this.isSlected,
    required this.image,
    required this.sideItemsPrice,
    // this.sideItemNameInList= const [],
    this.indexx = 0,
    required this.sideItemsIds,
    this.cartSideItems = const [],
    // this.sideItemPriceInList= const [],
    required this.sideItems,
    required this.allSideItemssInMenu,
    this.quantity = 0,
    required this.sideItemNames,
    this.totalPrice = 0,
    this.counter = 0,
    this.subtotal = 0.0,
    required this.price,
    required this.description,
  });

  copyWith(
      {required int totalPrice,
      required int counter,
      required sideItemsPrice,
      required latitude,
      required token,
      required specialInstructions,
      required longitude,
      required sideItemNames,
      required selectedSideItemId,
      required restrauntLocation}) {
    return Menu(
      title: this.title,
      storeLocation: this.storeLocation,
      i: this.i,
      selectedSideItemId: this.selectedSideItemId,
      storeId: this.storeId,
      restrauntName: this.restrauntName,
      token: this.token,
      specialInstructions: this.specialInstructions,
      latitude: this.latitude,
      longitude: this.longitude,
      cartSideItems: this.cartSideItems,
      sideItemsIds: this.sideItemsIds,
      // sideItemPriceInList: this.sideItemPriceInList,
      // sideItemNameInList: this.sideItemNameInList,
      isSlected: this.isSlected,
      sideItemNames: this.sideItemNames,
      image: this.image,
      allSideItemssInMenu: this.allSideItemssInMenu,
      sideItemsPrice: this.sideItemsPrice,
      indexx: this.indexx,
      quantity: this.quantity,
      totalPrice: this.totalPrice,
      counter: counter,
      sideItems: this.sideItems,
      subtotal: this.subtotal,
      price: this.price,
      description: this.description,
    );
  }
}

class RestrauntCategories extends SliverPersistentHeaderDelegate {
  final ValueChanged<int> onChanged;
  final int selectedIndex;
  final String? storeId;
  RestrauntCategories({
    required this.onChanged,
    required this.selectedIndex,
    required this.storeId,
  });
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 52,
      color: Colors.white,
      child: Categories(
          stioreId: storeId,
          onChanged: onChanged,
          selectedIndex: selectedIndex),
    );
  }

  @override
  double get maxExtent => 52;

  @override
  double get minExtent => 52;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class Categories extends ConsumerStatefulWidget {
  const Categories(
      {required this.onChanged,
      required this.stioreId,
      required this.selectedIndex});
  final ValueChanged<int> onChanged;
  final int selectedIndex;
  final stioreId;
  @override
  ConsumerState<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends ConsumerState<Categories> {
  late ScrollController _controller;
  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Categories oldWidget) {
    _controller.animateTo(80.0 * widget.selectedIndex,
        duration: Duration(milliseconds: 200), curve: Curves.ease);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Categories")
          .doc(widget.stioreId)
          .collection("Category")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                snapshot.data!.docs.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: TextButton(
                    onPressed: () {
                      widget.onChanged(index);
                      // _controller.animateTo(
                      //   80.0 * index,
                      //   curve: Curves.ease,
                      //   duration: const Duration(milliseconds: 200),
                      // );
                    },
                    style: TextButton.styleFrom(
                        foregroundColor: widget.selectedIndex == index
                            ? Colors.black
                            : Colors.black45),
                    child: Text(
                      snapshot.data?.docs[index]["CategoryName"],
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
        // DocumentSnapshot categoryId = snapshot.data!.docs[widget.selectedIndex];
      },
    );
  }
}

class MenuCategoryItem extends StatelessWidget {
  const MenuCategoryItem({
    Key? key,
    required this.title,
    required this.items,
  }) : super(key: key);

  final String? title;
  final List items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 13),
          child: Text(
            title ?? "",
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...items
      ],
    );
  }
}

class MenuCard extends StatelessWidget {
  const MenuCard({
    Key? key,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
  }) : super(key: key);

  final String image, title;
  final price;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: DefaultTextStyle(
            style: const TextStyle(color: Colors.black54),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "${description}",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    // const Text("\$\$"),
                    // const Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 8),
                    //   child: CircleAvatar(
                    //     radius: 2,
                    //     backgroundColor: Colors.black38,
                    //   ),
                    // ),
                    // const Text("Chinese"),
                    const Spacer(),
                    Text(
                      "Price. $price",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(249, 191, 98, 1),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class PriceRange {
  final int text;
  PriceRange({required this.text});
}

final List<PriceRange> priceText = [
  PriceRange(text: 100),
  PriceRange(text: 200),
  PriceRange(text: 300),
  PriceRange(text: 400),
  PriceRange(text: 500),
  PriceRange(text: 600),
  PriceRange(text: 700),
  PriceRange(text: 800),
  PriceRange(text: 900),
  PriceRange(text: 1000),
];
