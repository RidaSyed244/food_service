import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_service/StateManagement.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final logicalScreen = StateNotifierProvider((ref) => LogicalScreens());
final currentLocation = StateNotifierProvider((ref) => Services());
final users = FirebaseFirestore.instance
    .collection('All_Restraunts')
    .orderBy('status')
    .where("status", isEqualTo: "Approved");

final providerrr = StreamProvider((ref) => users.snapshots());
// final categoryType = FirebaseFirestore.instance
//     .collection("TypesOfCategory")
//     .doc()
//     .collection("CategoryType");
// final categoryStream = StreamProvider((ref) => categoryType.snapshots());
// final categories = FirebaseFirestore.instance
//     .collection("Categories")
//     .doc()
//     .collection("Category")
//     .doc()
//     .collection('Products');
// final categoriesStream = StreamProvider((ref) => categories.snapshots());
final usersData = FirebaseFirestore.instance
    .collection('Users')
    .doc(FirebaseAuth.instance.currentUser?.uid)
    .snapshots()
    .map((event) => Users.fromMap(event.data()!));
final userStream = StreamProvider<Users>((ref) {
  return usersData;
});
final categoryData = FirebaseFirestore.instance
    .collection('Categories')
    .doc(FirebaseAuth.instance.currentUser?.uid)
    .collection("Category")
    .snapshots();

final categoryStream = StreamProvider((ref) {
  return categoryData;
});
