// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:food_service/Logical%20SCreens/SignIn.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'package:food_service/Settings%20Screns/PasswordChange.dart';

import 'Logical SCreens/Phone_No.dart';
import 'Logical SCreens/VerifyPhoneNo.dart';
import 'Order Screens/AddToOrder.dart';
import 'Order Screens/AddToOrder.dart';
import 'card_type.dart';
import 'card_utilis.dart';
import 'featuredItems.dart';
import 'main.dart';

TextEditingController countryCode = TextEditingController();
var phone = '';
String sessionToken = '12345';
var uuid = Uuid();
List<dynamic> placePrediction = [];
final searchCurrentLocationController = TextEditingController();
TextEditingController searchLocationn = TextEditingController();

final cvcController = TextEditingController();
final cardMonthController = TextEditingController();
bool isClearone = false;
bool isClearsecond = false;
final forgotPswrdAuth = FirebaseAuth.instance;
bool isValidEmail = false;
bool isNameValid = false;
bool isPasswordValid = false;
bool isEmailValid = false;
TextEditingController searchController = TextEditingController();
TextEditingController cardNumberController = TextEditingController();
final emailController = TextEditingController();
final passwordController = TextEditingController();
final nameController = TextEditingController();
final scrollController = ScrollController();
final phoneNoController = TextEditingController();
int selectedCategoryIndex = 0;
double restrauntInfoHeight = 200 //App bar expandedHeight
    +
    170 -
    kToolbarHeight; //Restraunt info height
List<double> breakpoints = [];
final logoutAuth = FirebaseAuth.instance;
final logInAuth = FirebaseAuth.instance;
CardType cardType = CardType.Discover;
int currentIndex = 0;

class Users {
  final String UserName;
  final String UserEmail;
  final String UserPhoneNo;
  final String UserPassword;

  Users({
    required this.UserName,
    required this.UserEmail,
    required this.UserPhoneNo,
    required this.UserPassword,
  });

  Users copyWith({
    String? UserName,
    String? UserEmail,
    String? UserPhoneNo,
    String? UserPassword,
  }) {
    return Users(
      UserName: UserName ?? this.UserName,
      UserEmail: UserEmail ?? this.UserEmail,
      UserPhoneNo: UserPhoneNo ?? this.UserPhoneNo,
      UserPassword: UserPassword ?? this.UserPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'UserName': UserName,
      'UserEmail': UserEmail,
      'UserPhoneNo': UserPhoneNo,
      'UserPassword': UserPassword,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      UserName: map['UserName'] as String,
      UserEmail: map['UserEmail'] as String,
      UserPhoneNo: map['UserPhoneNo'] as String,
      UserPassword: map['UserPassword'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) =>
      Users.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(UserName: $UserName, UserEmail: $UserEmail, UserPhoneNo: $UserPhoneNo, UserPassword: $UserPassword)';
  }

  @override
  bool operator ==(covariant Users other) {
    if (identical(this, other)) return true;

    return other.UserName == UserName &&
        other.UserEmail == UserEmail &&
        other.UserPhoneNo == UserPhoneNo &&
        other.UserPassword == UserPassword;
  }

  @override
  int get hashCode {
    return UserName.hashCode ^
        UserEmail.hashCode ^
        UserPhoneNo.hashCode ^
        UserPassword.hashCode;
  }
}

class Services extends StateNotifier {
  Services() : super("");
  void getCardTypeFrnNum() {
    if (cardNumberController.text.length <= 6) {
      String cardNum = CardUtils.getCleanedNumber(cardNumberController.text);
      CardType type = CardUtils.getCardTypeFrmNumber(cardNum);
      if (type != cardType) {
        cardType = type;
      }
    }
  }

  Future share() async {
    await FlutterShare.share(
        title: 'Example share',
        // text: 'https://foodservice66.page.link/u9DC',
        linkUrl: 'https://foodservice66.page.link/u9DC',
        chooserTitle: 'Example Chooser Title');
  }

  void clearSearchController() {
    searchController.clear();
  }

  void clearCurrentLocationController() {
    searchCurrentLocationController.clear();
  }

  buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? Colors.green : Colors.grey,
      ),
    );
  }

  void claerFirstList() {
    isClearone = !isClearone;
  }

  void claerSecondList() {
    isClearsecond = !isClearsecond;
  }
}

var newItem;

// class AddToCart extends StateNotifier<List<Menu>> {
//   AddToCart() : super([]);
//   ///////////////////just product//////////////////////////
//   // void addToCart(Menu itemsss) {
//   //   final newItem =
//   //       itemsss.copyWith(counter: itemsss.counter, totalPrice: itemsss.price);

//   //   state = [...state, newItem];

//   //   // final existingProductIndex = state.indexWhere(
//   //   //   (element) =>
//   //   //       element.title == itemsss.title &&
//   //   //       element.description == itemsss.description,
//   //   // );

//   //   // if (existingProductIndex != -1) {
//   //   //   // If the product already exists in the cart, update the count and total price.
//   //   //   final existingProduct = state[existingProductIndex];
//   //   //   existingProduct.counter ++;

//   //   //   existingProduct.totalPrice =
//   //   //       existingProduct.price * existingProduct.counter;
//   //   //   state[existingProductIndex] = existingProduct;
//   //   // } else {
//   //   //   // If the product doesn't exist in the cart, add it to the list.
//   //   //   final newItem = itemsss.copyWith(counter: 1, totalPrice: itemsss.price);
//   //   //   state = [...state, newItem];
//   //   // }
//   // }
//   ////////////////////////for 1 or more side items/////////////////////////////////
//   // void addToCart(Menu itemsss) {
//   //   final existingProductIndex = state.indexWhere(
//   //     (element) =>
//   //         element.title == itemsss.title &&
//   //         element.description == itemsss.description,
//   //   );

//   //   if (existingProductIndex != -1) {
//   //     // If the product already exists in the cart, update the count and total price.
//   //     final existingProduct = state[existingProductIndex];

//   //     existingProduct.counter++;
//   //     existingProduct.totalPrice =
//   //         existingProduct.price * existingProduct.counter;

//   //     // Update the total price by adding the price of the selected side items
//   //     if (itemsss.allSideItemssInMenu.length >= 1 &&
//   //         itemsss.sideItemCheck == true) {
//   //       double totalPrice = existingProduct.price * existingProduct.counter;

//   //       for (var sideItem in itemsss.allSideItemssInMenu) {
//   //         if (sideItem.isSelected == true) {
//   //           existingProduct.totalPrice += sideItem.price;
//   //         }
//   //       }

//   //       existingProduct.totalPrice = totalPrice;
//   //     } else if (itemsss.sideItemCheck == false) {
//   //       newItem.totalPrice = newItem.price * newItem.counter;
//   //     }

//   //     state[existingProductIndex] = existingProduct;
//   //   } else {
//   //     // If the product doesn't exist in the cart, add it to the list.
//   //     final newItem = itemsss.copyWith(
//   //       counter: 1,
//   //       totalPrice: itemsss.totalPrice,
//   //       sideItemsPrice: itemsss.sideItemsPrice,
//   //     );

//   //     if (itemsss.allSideItemssInMenu.length >= 1 &&
//   //         itemsss.sideItemCheck == true) {
//   //       double totalPrice = itemsss.price * itemsss.counter;

//   //       for (var sideItem in itemsss.allSideItemssInMenu) {
//   //         if (sideItem.isSelected == true) {
//   //           totalPrice += sideItem.price;
//   //         }
//   //       }

//   //       newItem.totalPrice = totalPrice;
//   //     } else if (itemsss.sideItemCheck == false) {
//   //       newItem.totalPrice = newItem.price * newItem.counter;
//   //     }

//   //     state = [...state, newItem];
//   //   }
//   // }
// ////////////////////for just 1 side item///////////////////////////////
// void addToCart(Menu itemsss) {
//   final existingProductIndex = state.indexWhere(
//     (element) =>
//         element.title == itemsss.title &&
//         element.description == itemsss.description,
//   );

//   if (existingProductIndex != -1) {
//     // If the product already exists in the cart, update the count and total price.
//     final existingProduct = state[existingProductIndex];
//     existingProduct.counter++;

//     // Update the total price by adding the price of the selected side items
//     existingProduct.totalPrice = existingProduct.price * existingProduct.counter;
//     for (var i = 0; i < itemsss.sideItems!.length; i++) {
//       if (itemsss.sideItems?[i]["isChecked"] == true) {
//         existingProduct.totalPrice += itemsss.sideItems?[i]["sideItemPrice"];
//       } else if (itemsss.sideItems?[i]["isChecked"] == false) {
//         existingProduct.totalPrice = existingProduct.price * existingProduct.counter;
//       }
//     }

//   // Create a new array of products that includes the updated product
//     final updatedProducts = List<Menu>.from(state);
//     updatedProducts[existingProductIndex]== existingProduct;

//     // Set the state to the new array of products
//     state == updatedProducts;
//     // // state[existingProductIndex] = existingProduct;
//   } else {
//     // If the product doesn't exist in the cart, add it to the list.
//     var newItem = itemsss.copyWith(
//         counter: 1, totalPrice: itemsss.price*itemsss.counter,
//         sideItemsPrice: itemsss.sideItemsPrice);
//     for (var i = 0; i < itemsss.sideItems!.length; i++) {
//       if (itemsss.sideItems?[i]["isChecked"] == true) {
//         newItem.totalPrice += itemsss.sideItems?[i]["sideItemPrice"];
//       }
//     }

//     state = [...state, newItem];
//   }
// }

// //  addToCart(Menu itemsss) {
// //   final existingProductIndex = state.indexWhere(
// //     (element) =>
// //         element.title == itemsss.title &&
// //         element.description == itemsss.description,
// //   );

// //   if (existingProductIndex != -1) {
// //     // If the product already exists in the cart, update the count and total price.
// //     final existingProduct = state[existingProductIndex];

// //     existingProduct.counter++;

// //     // Update the total price by adding the price of the selected side item
// //     if (itemsss.sideItemCheck == true) {
// //       final selectedSideItem = existingProduct.allSideItemssInMenu
// //           .firstWhere((sideItem) => sideItem.isSelected == true);
// //       existingProduct.totalPrice +=
// //           (existingProduct.price + selectedSideItem.price) *
// //               existingProduct.counter;
// //     } else {
// //       existingProduct.totalPrice = existingProduct.price *
// //           existingProduct.counter; // only update the product price
// //     }

// //     state[existingProductIndex] = existingProduct;
// //   } else {
// //     // If the product doesn't exist in the cart, add it to the list.
// //     newItem = itemsss.copyWith(
// //       counter: 1,
// //       totalPrice: itemsss.price,
// //       sideItemsPrice: 0,
// //     );
// //     if (itemsss.sideItemCheck == true) {
// //       final selectedSideItem = itemsss.allSideItemssInMenu
// //           .firstWhere((sideItem) => sideItem.isSelected == true);
// //       newItem.totalPrice += selectedSideItem.price;
// //       newItem.sideItemsPrice = selectedSideItem.price;
// //     }
// //     state = [...state, newItem];
// //   }
// // }

//   // addToCartWithSideItem(Menu itemsss, sideItemsIsCheck) {
//   //   final existingProductIndex = state.indexWhere(
//   //     (element) =>
//   //         element.title == itemsss.title &&
//   //         element.description == itemsss.description,
//   //   );

//   //   if (existingProductIndex != -1 ) {
//   //     // If the product already exists in the cart, update the count and total price.
//   //     final existingProduct = state[existingProductIndex];
//   //       existingProduct.counter++;
//   //     existingProduct.totalPrice =
//   //         existingProduct.price * existingProduct.counter;
//   //         if(sideItemsIsCheck==true){
//   //                   existingProduct.totalPrice += itemsss.sideItemsPrice;

//   //         }
//   //     //add the price of the selected side item to the total price

//   //     state[existingProductIndex] = existingProduct;
//   //   } else {
//   //     // If the product doesn't exist in the cart, add it to the list.
//   //     newItem = itemsss.copyWith(
//   //       counter: 1,
//   //       totalPrice: itemsss.price + itemsss.sideItemsPrice,
//   //       sideItemsPrice: itemsss.sideItemsPrice,
//   //     );
//   //     state = [...state, newItem];
//   //   }
//   // }

//   // addProductWithSideItem(Menu itemsss) {
//   //   final existingProductIndex = state.indexWhere(
//   //     (element) =>
//   //         element.title == itemsss.title &&
//   //         element.description == itemsss.description,
//   //   );

//   //   if (existingProductIndex != -1) {
//   //     // If the product already exists in the cart, update the count and total price.
//   //     final existingProduct = state[existingProductIndex];

//   //     existingProduct.counter++;

//   //     // Update the total price by adding the price of the selected side item
//   //     existingProduct.totalPrice =
//   //         existingProduct.price * existingProduct.counter +
//   //             itemsss.sideItemsPrice;

//   //     state[existingProductIndex] = existingProduct;
//   //   } else {
//   //     // If the product doesn't exist in the cart, add it to the list.
//   //     newItem = itemsss.copyWith(
//   //       counter: 1,
//   //       totalPrice: itemsss.price + itemsss.sideItemsPrice,
//   //       sideItemsPrice: itemsss.sideItemsPrice,
//   //     );
//   //     state = [...state, newItem];
//   //   }
//   // }

//   // void addProductWithSideItem(Menu itemsss) {
//   //    final existingProductIndex = state.indexWhere(
//   //     (element) =>
//   //         element.title == itemsss.title &&
//   //         element.description == itemsss.description,
//   //   );

//   //   if (existingProductIndex != -1) {
//   //     // If the product already exists in the cart, update the count and total price.
//   //     final existingProduct = state[existingProductIndex];

//   //     existingProduct.totalPrice =
//   //         existingProduct.price * existingProduct.counter+ existingProduct.sideItemsPrice;
//   //      // if (existingProduct.sideItemCheck == true) {
//   //     //   existingProduct.totalPrice =
//   //     //       existingProduct.totalPrice + existingProduct.sideItemsPrice;
//   //     // }
//   //     state[existingProductIndex] = existingProduct;
//   //   } else {
//   //     // If the product doesn't exist in the cart, add it to the list.
//   //     newItem = itemsss.copyWith(counter: 1, totalPrice: itemsss.price);
//   //     state = [...state, newItem];
//   //   }
//   // }
//   void removeFromCart(Menu itemsss) {
//     final existingProductIndex = state.indexWhere(
//       (element) =>
//           element.title == itemsss.title &&
//           element.description == itemsss.description,
//     );

//     if (existingProductIndex != -1) {
//       // If the product exists in the cart, remove one instance of it and update the count and total price.
//       final existingProduct = state[existingProductIndex];
//       if (existingProduct.counter > 1) {
//         // If the item's count is greater than 1, decrease the count and update the total price.
//         existingProduct.counter--;
//         existingProduct.totalPrice =
//             existingProduct.price * existingProduct.counter;
//         state[existingProductIndex] = existingProduct;
//       } else {
//         // If the item's count is 1, remove it from the cart.
//         state.removeAt(existingProductIndex);
//       }
//     }
//   }

//   void increaseCount(Menu itemsss) {
//     itemsss.counter++;
//     itemsss.totalPrice = itemsss.price * itemsss.counter;
//     // if (sideItemsCheck == true) {
//     //   itemsss.totalPrice =
//     //       itemsss.price * itemsss.counter + itemsss.sideItemsPrice;
//     // }
//   }

//   void decreaseCount(Menu itemsss) {
//     itemsss.counter--;
//     itemsss.totalPrice = itemsss.price * itemsss.counter;
//   }

//   final cartUserDetails = FirebaseFirestore.instance
//       .collection("AllOrders")
//       .doc(FirebaseAuth.instance.currentUser?.uid)
//       .collection("Orders");

//   saveCartToFirebase(restrauntName, restrauntLocation, subtotalls, userName,
//       userEmail, userCardNumber, userCardExpiryDate) {
//     List<Map<String, dynamic>> productList = [];

//     for (Menu itemsss in state) {
//       Map<String, dynamic> product = {
//         "Store_Name": restrauntName,
//         'ProductName': itemsss.title,
//         'ProductPrice': itemsss.price,
//         'ProductQuantity': itemsss.counter,
//         'ProductDescription': itemsss.description,
//         "Store_Location": restrauntLocation,
//       };

//       productList.add(product);
//     }
//     cartUserDetails.add({
//       "products": productList,
//       'subtotal': subtotalls,
//       "OrderTime": DateTime.now(),
//       "UserName": userName,
//       "UserEmail": userEmail,
//       "UserCardNumber": userCardNumber,
//       "UserCardExpiryDate": userCardExpiryDate,
//     });
//   }
// }

class LogicalScreens extends StateNotifier {
  LogicalScreens() : super('');
  validateEmail(String value) {
    final emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

    isEmailValid = RegExp(emailRegex).hasMatch(value);
  }

  passwordValidation(String value) {
    if (passwordController.text.length < 6) {
      isPasswordValid = false;
      return "Password must be at least 6 characters";
    } else {
      isPasswordValid = true;
    }
  }

  nameValidation(String value) {
    if (nameController.text.length < 3) {
      isNameValid = false;
      return "Name must be at least 3 characters";
    } else {
      isNameValid = true;
    }
  }

  emailValidation(String value) {
    final emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

    isValidEmail = RegExp(emailRegex).hasMatch(value);
  }

  Future createUser() async {
    UserCredential result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
    User? user = result.user;
    return user;
  }

  Future registerUser() async {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({
      "UserName": nameController.text,
      "UserEmail": emailController.text,
      "UserPassword": passwordController.text,
      // "token": token,
    });
  }

  Future addPhoneNo() async {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({
      "UserPhoneNo": countryCode.text + phone,
    });
  }

  Future logInUser() async {
    return await logInAuth.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
  }
  getToken(){
  FirebaseFirestore.instance.collection("Users").doc(
      FirebaseAuth.instance.currentUser?.uid).update({
        "UserToken": token,
  }
  );
}

  Future forgotPassword() async {
    await forgotPswrdAuth.sendPasswordResetEmail(email: emailController.text);
  }

  Future againResetPassword(String myEmail) async {
    await forgotPswrdAuth.sendPasswordResetEmail(email: myEmail);
  }

  Future updateEmail() async {
    try {
      await FirebaseAuth.instance.currentUser
          ?.updateEmail(emailController.text);
    } catch (error) {
      // Handle error if email update in Firebase Authentication fails
      print("Error updating email in Firebase Authentication: $error");
      // You can show an error message to the user here
      return;
    }

    // If email update in Firebase Authentication succeeds, update email in Firestore
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({
        "UserEmail": emailController.text,
      });
      print("Email updated successfully in Firestore");
    } catch (error) {
      // Handle error if email update in Firestore fails
      print("Error updating email in Firestore: $error");
      // You can show an error message to the user here
    }
  }

  Future updateName() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({
      "UserName": nameController.text,
    });
  }

  Future updatePhoneNo() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({
      "UserPhoneNo": countryCode.text + phone,
    });
    await FirebaseAuth.instance.currentUser?.updatePhoneNumber(
        PhoneAuthProvider.credential(
            verificationId: PhoneNumber.verify, smsCode: code));
  }

  Future updatePassword() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({"UserPassword": confirmPasswordController.text});
    await FirebaseAuth.instance.currentUser
        ?.updatePassword(confirmPasswordController.text);
  }

  Future signout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('UserEmail');
    return await logoutAuth.signOut();
  }

  facebookLogin() async {
    print("FaceBook");
    try {
      final result =
          await FacebookAuth.i.login(permissions: ['email', 'public_profile']);
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.i.getUserData();
        print(userData);
      }
    } catch (error) {
      print(error);
    }
  }
}

class AllRatingAndReview {
  final String? Name;
  final String? Email;
  final double? Rating;
  final String? Review;
  final String? url;

  AllRatingAndReview({
    this.Name,
    this.Email,
    this.Rating,
    this.Review,
    this.url,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Name': Name,
      'Email': Email,
      'Rating': Rating,
      'Review': Review,
      'url': url,
    };
  }

  factory AllRatingAndReview.fromMap(Map<String, dynamic> map) {
    return AllRatingAndReview(
      Name: map['Name'] != null ? map['Name'] as String : null,
      Email: map['Email'] != null ? map['Email'] as String : null,
      Rating: map['Rating'] != null ? map['Rating'] as double : null,
      Review: map['Review'] != null ? map['Review'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AllRatingAndReview.fromJson(String source) => AllRatingAndReview.fromMap(json.decode(source) as Map<String, dynamic>);
}
