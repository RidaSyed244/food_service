// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_service/Home%20Screens/HomePage.dart';
import 'package:food_service/Order%20Screens/AddToOrder.dart';
import 'package:food_service/main.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'UserModel.dart';
import 'featuredItems.dart';

List<Menu> allCartItems = [];
List<Map<String, dynamic>> productList = [];
List<String> selectedTokens = [];

class AddToCart extends ChangeNotifier {
  List<Menu> get cartItems => allCartItems;
  int get length => cartItems.length;
  AllRestraunts _currentRestaurant = AllRestraunts();

  AllRestraunts get currentRestaurant => _currentRestaurant;

  void setRestaurant(AllRestraunts restaurant_name) {
    _currentRestaurant = restaurant_name;
    notifyListeners();
  }

  Menu operator [](int index) => allCartItems[index];

  ////////////////////Add product with selected side Items///////////////////////////////
  // void addToCart(Menu itemsss) async {
  //   var mybox = await Hive.openBox("SideItemsIsCheck");

  //   final existingProductIndex = allCartItems.indexWhere(
  //     (element) =>
  //         element.title == itemsss.title &&
  //         element.description == itemsss.description,
  //     // element.sideItemName== itemsss.sideItemName &&
  //     // element.sideItemsPrice== itemsss.sideItemsPrice,
  //   );

  //   if (existingProductIndex != -1) {
  //     // If the product already exists in the cart, update the count and total price.
  //     final existingProduct = allCartItems[existingProductIndex];
  //     existingProduct.counter++;

  //     // Update the total price by adding the price of the selected side items
  //     existingProduct.totalPrice =
  //         existingProduct.price * existingProduct.counter;

  //     for (var i = 0; i < itemsss.sideItems.length; i++) {
  //       if (mybox.containsKey(i)) {
  //         existingProduct.totalPrice += itemsss.sideItems[i]["sideItemPrice"];
  //       } else {
  //         existingProduct.totalPrice =
  //             existingProduct.price * existingProduct.counter;
  //         ;
  //       }
  //     }

  //     // Create a new array of products that includes the updated product
  //     final updatedProducts = List<Menu>.from(allCartItems);
  //     updatedProducts[existingProductIndex] == existingProduct;

  //     // Set the state to the new array of products
  //     allCartItems == updatedProducts;
  //     // // state[existingProductIndex] = existingProduct;
  //   } else {
  //     // If the product doesn't exist in the cart, add it to the list.
  //     var newItem = itemsss.copyWith(
  //         counter: 1,
  //         totalPrice: itemsss.price * itemsss.counter,
  //         sideItemsPrice: itemsss.sideItemsPrice);
  //     for (var i = 0; i < itemsss.sideItems.length; i++) {
  //       if (mybox.containsKey(i)) {
  //         newItem.totalPrice += itemsss.sideItems[i]["sideItemPrice"];
  //       }
  //     }

  //     allCartItems = [...allCartItems, newItem];
  //   }
  //   notifyListeners();
  // }
  double sideItemTotalPrice = 0.0;

  void updateTotalPrice(double price) {
    sideItemTotalPrice += price;
    notifyListeners();
  }

  addToCart(Menu itemsss, String sideItemIds) async {
    var mybox = await Hive.openBox("SideItemsIsCheck");
    var sideItemInfo = mybox.get(sideItemIds);

    // Find if the product already exists in the cart based on specific attributes
    final existingProductIndex = allCartItems.indexWhere(
      (element) =>
          element.title == itemsss.title &&
          element.description == itemsss.description &&
          element.selectedSideItemId == itemsss.selectedSideItemId &&
          element.storeLocation == itemsss.storeLocation &&
          element.latitude == itemsss.latitude &&
          element.longitude == itemsss.longitude,
    );

    if (existingProductIndex != -1) {
      // If the product already exists in the cart, update it.
      final existingProduct = allCartItems[existingProductIndex];

      // Check if the side item price has been added before
      // if (mybox.containsKey(sideItemIds)) {
      //   var sideItemInfo = mybox.get(sideItemIds);
      //   existingProduct.sideItemsPrice += sideItemInfo["SideItemPrice"] as int;
      //   // Append the new side item name to the existing names
      //   existingProduct.sideItemNames +=  sideItemInfo["SideItemName"];
      // }

      // Increment the counter for the existing product
      existingProduct.counter++;

      // Calculate the total price for this product (product price + side item price)
      existingProduct.totalPrice =
          existingProduct.price * existingProduct.counter +
              existingProduct.sideItemsPrice;

      // Create a new array of products that includes the updated product
      final updatedProducts = List<Menu>.from(allCartItems);
      updatedProducts[existingProductIndex] = existingProduct;

      // Set the state to the new array of products
      allCartItems = updatedProducts;
    } else {
      // If the product doesn't exist in the cart, add it to the list.
      var newItem = itemsss.copyWith(
        counter: 1,
        specialInstructions: itemsss.specialInstructions,
        token: itemsss.token,
        totalPrice: itemsss.price, // Initialize total price with product price
        latitude: itemsss.latitude,
        longitude: itemsss.longitude,
        selectedSideItemId: itemsss.selectedSideItemId,
        sideItemsPrice: 0, // Initialize side item price as 0
        sideItemNames: "", // Initialize side item names as an empty string
        restrauntLocation: itemsss.storeLocation,
      );

      // Check if the side item price has been added before
      if (mybox.containsKey(sideItemIds)) {
        var sideItemInfo = mybox.get(sideItemIds);
        newItem.sideItemsPrice += sideItemInfo["SideItemPrice"];
        newItem.sideItemNames += sideItemInfo["SideItemName"];
        newItem.totalPrice += newItem.sideItemsPrice;
      }

      // Calculate the total price for this product (product price + side item price)

      allCartItems = [...allCartItems, newItem];
    }
    notifyListeners();
  }

  void addSideItemToProduct(Menu product, String sideItemId) async {
    var mybox = await Hive.openBox("SideItemsIsCheck");
    var sideItemInfo = mybox.get(sideItemId);

    // Find the product in the cart based on specific attributes
    final existingProductIndex = allCartItems.indexWhere(
      (element) =>
          element.title == product.title &&
          element.description == product.description &&
          element.storeLocation == product.storeLocation &&
          element.latitude == product.latitude &&
          element.longitude == product.longitude,
    );

    if (existingProductIndex != -1) {
      // If the product exists in the cart, update it.
      final existingProduct = allCartItems[existingProductIndex];

      // Check if the side item price has been added before
      if (mybox.containsKey(sideItemId)) {
        var sideItemInfo = mybox.get(sideItemId);
        existingProduct.sideItemsPrice += sideItemInfo["SideItemPrice"] as int;
        // Append the new side item name to the existing names
        existingProduct.sideItemNames += sideItemInfo["SideItemName"];
      }

      // Calculate the total price for this product (product price + side item price)
      existingProduct.totalPrice =
          existingProduct.price * existingProduct.counter +
              existingProduct.sideItemsPrice;

      // Create a new array of products that includes the updated product
      final updatedProducts = List<Menu>.from(allCartItems);
      updatedProducts[existingProductIndex] = existingProduct;

      // Set the state to the new array of products
      allCartItems = updatedProducts;

      notifyListeners();
    }
  }

  void removeSideItem(Menu product, sideItemId) async {
    var mybox = await Hive.openBox("SideItemsIsCheck");

    final existingProductIndex = allCartItems.indexWhere(
      (element) =>
          element.title == product.title &&
          element.description == product.description &&
          element.storeLocation == product.storeLocation &&
          element.latitude == product.latitude &&
          element.longitude == product.longitude,
    );

    if (existingProductIndex != -1) {
      final existingProduct = allCartItems[existingProductIndex];

      // // Check if the side item price has been added before
      //  if (mybox.containsKey(sideItemId)) {
      //   var sideItemInfo = mybox.get(sideItemId);
      //   existingProduct.totalPrice -= sideItemInfo["SideItemPrice"] as int;

      //   // Remove the deleted side item name from the existing names
      // }

      // Calculate the total price including the updated side item price
      existingProduct.totalPrice -= existingProduct.sideItemsPrice;
      existingProduct.sideItemsPrice = 0; // Reset side item price
      existingProduct.sideItemNames = "";
      // Create a new array of products that includes the updated product
      final updatedProducts = List<Menu>.from(allCartItems);
      updatedProducts[existingProductIndex] = existingProduct;

      // Set the state to the new array of products
      allCartItems = updatedProducts;

      notifyListeners();
    }
  }

/////////////////////////////Remove product from cart///////////////////////////////
  void removeFromCart(Menu itemsss) {
    final existingProductIndex = allCartItems.indexWhere(
      (element) =>
          element.title == itemsss.title &&
          element.description == itemsss.description,
    );

    if (existingProductIndex != -1) {
      // If the product exists in the cart, remove one instance of it and update the count and total price.
      final existingProduct = allCartItems[existingProductIndex];
      if (existingProduct.counter > 1) {
        // If the item's count is greater than 1, decrease the count and update the total price.
        existingProduct.counter--;
        existingProduct.totalPrice =
            existingProduct.price * existingProduct.counter;
        allCartItems[existingProductIndex] = existingProduct;
      } else {
        // If the item's count is 1, remove it from the cart.
        allCartItems.removeAt(existingProductIndex);
      }
      notifyListeners();
    }
  }

  increaseCount(Menu itemsss) {
    itemsss.counter++;
    itemsss.totalPrice = itemsss.price * itemsss.counter;
    notifyListeners();
  }

  //  addToken(String token) {
  //   selectedTokens.add(token);
  //   notifyListeners();
  // }
  sendNotifications() async {
    try {
      var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

      for (var token in selectedTokens) {
        var body = {
          "to": token,
          "notification": {
            "title": "New Order",
            "body": "You have a new order from ${username}",
          },
        };

        var response = await post(
          url,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                "key=AAAAbXwSTlU:APA91bEvCpFMnWOvco-UbHMGzWOsK8yTRqL1PxHwRBCjIKcRlsYKMb1mH-P9to-VkDcIsQUOhQPq0s1XoMdEZzbpFhrGGDfV1TRqQiWreVnUPPTnGfiK8Nrw4yX-bfxYTZuYrceTZ5SH",
          },
          body: jsonEncode(body),
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        print("Sending Notification to ${token}");
      }

      print("Send Notification successfully");
    } catch (e) {
      print("Notification-Error: $e");
    }
  }

  void decreaseCount(Menu itemsss) {
    itemsss.counter--;
    itemsss.totalPrice = itemsss.price * itemsss.counter;
    notifyListeners();
  }

  removeItem(Menu item) {
    allCartItems.remove(item);
    notifyListeners();
  }

  double get totalPrice {
    double total = 0.0;
    for (var item in allCartItems) {
      total += item.totalPrice;
    }
    notifyListeners();
    return total;
  }

  final cartUserDetails = FirebaseFirestore.instance
      .collection("AllOrders")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection("Orders");
  final AllRestrauntOrders = FirebaseFirestore.instance
      .collection("All_Restraunts")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection("All_Orders");

  saveCartToFirebase(
      subtotalls,
      latitude,
      longitude,
      userName,
      userEmail,
      userCardNumber,
      userCardExpiryDate,
      ii,
      sideItemIds,
      userCurrentLocation,
      storeLocation) async {
    var mybox = await Hive.openBox('SideItemsIsCheck');

    for (Menu itemsss in allCartItems) {
      List<Map<String, dynamic>> sideItems = [];

      // for (var i = 0; i < itemsss.sideItems.length; i++) {
      if (mybox.containsKey(itemsss.sideItemsIds)) {
        var sideItemInfo = mybox.get(itemsss.sideItemsIds);
        sideItems.add({
          'SideItemPrice': sideItemInfo["SideItemPrice"],
          'SideItemName': sideItemInfo["SideItemName"],
        });
      }
      // }
      Map<String, dynamic> product = {
        'Store_Name': itemsss.restrauntName,
        'Store_Location': itemsss.storeLocation,
        'ProductName': itemsss.title,
        'ProductPrice': itemsss.price,
        'ProductQuantity': itemsss.counter,
        "ProductSpecialInstructions": itemsss.specialInstructions,
        "ProductImage": itemsss.image,
        'Side_Items': sideItems,
        "totalPrice": itemsss.totalPrice,
        "Store_uid": itemsss.storeId,
        'ProductDescription': itemsss.description,
        "Rating": "Not_Added",
        // "status":"Pending"
      };
      Map<String, dynamic> separateOrders = {
        'Store_Name': itemsss.restrauntName,
        'Store_Location': itemsss.storeLocation,
        "Store_latitude": itemsss.latitude,
        "Store_longitude": itemsss.longitude,
        'ProductName': itemsss.title,
        'ProductPrice': itemsss.price,
        "ProductSpecialInstructions": itemsss.specialInstructions,
        'ProductQuantity': itemsss.counter,
        "ProductImage": itemsss.image,
        'Side_Items': sideItems,
        "totalPrice": itemsss.totalPrice,
        "Store_uid": itemsss.storeId,
        'ProductDescription': itemsss.description,
      };
      productList.add(product);
      // Save the order details to the respective restaurant's collection
      final restaurantOrders = FirebaseFirestore.instance
          .collection("All_Restraunts")
          .doc(itemsss.storeId) // Use the restaurant's unique ID here
          .collection("All_Orders");

      restaurantOrders.add({
        'products': [separateOrders],
        'subtotal': subtotalls,
        'OrderTime': DateTime.now(),
        "Store_latitude": itemsss.latitude,
        "User_latitude": userLatitude,
        "User_longitude": userLongitude,
        "Store_longitude": itemsss.longitude,
        'UserName': userName,
        'UserEmail': userEmail,
        "UserLocation": userCurrentLocation,
        "UserToken": userToken,
        'UserCardNumber': userCardNumber,
        'UserCardExpiryDate': userCardExpiryDate,
        "status": "Pending",
        "uid": FirebaseAuth.instance.currentUser?.uid,
        "deliverStatus": "false",
        "statusByDriver": "Pending",
        "driverArrived": "Not_Yet",
        "Rating": "Not_Added",
      });
    }

    // Upload productList and other details to Firebase
    cartUserDetails.add({
      'products': productList,
      'subtotal': subtotalls,
      'OrderTime': DateTime.now(),
      'UserName': userName,
      'UserEmail': userEmail,
      "UserLocation": userCurrentLocation,
      'UserCardNumber': userCardNumber,
      'UserCardExpiryDate': userCardExpiryDate,
      "uid": FirebaseAuth.instance.currentUser?.uid,
    });

    notifyListeners();
  }

  updateRatingStatus(String orderDocId) {
    List<Map<String, dynamic>> productList = [];

    Map<String, dynamic> product = {
      "Review": "Added_Review",
    };
    productList.add(product);
    FirebaseFirestore.instance
        .collection("AllOrders")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("Orders")
        .doc(orderDocId)
        .update({
      'products': productList,
    });
    notifyListeners();
  }
}

class SelectedIndexState extends StateNotifier<int?> {
  SelectedIndexState() : super(null);

  void setSelectedIndex(int index) {
    state = index;
  }

  void clearSelectedIndex() {
    state = null;
  }
}
