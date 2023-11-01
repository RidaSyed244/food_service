import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_service/Drawer_Screens/Fresh_Orders.dart';
import 'package:food_service/Drawer_Screens/add_Ratings.dart';
import 'package:food_service/Home%20Screens/AcceptedOrders.dart';
import 'package:food_service/Home%20Screens/PendingOrders.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../Order Screens/pastOrders.dart';
import '../Screens/Filters.dart';
import '../StateManagement.dart';

final usersDataForNavBar = FirebaseFirestore.instance
    .collection('Users')
    .doc(FirebaseAuth.instance.currentUser?.uid)
    .snapshots()
    .map((event) => Users.fromMap(event.data()!));

final detailsProvider = StreamProvider.autoDispose<Users>((ref) {
  return usersDataForNavBar;
});
// final logOut = StateNotifierProvider((ref) => AllNotifier());

class NavBar extends ConsumerWidget {
  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final userdetails = ref.watch(detailsProvider);
    return Drawer(
        child: userdetails.when(data: (data) {
      return ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              data.UserName,
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            accountEmail: Text(
              data.UserEmail,
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
            ),
            // currentAccountPicture: CircleAvatar(
            //   radius: 23,
            //   backgroundColor: Colors.black,
            //   child: NetworkImage(data.image.toString()) == true
            //       ? Container(
            //           decoration: BoxDecoration(
            //               color: Colors.black,
            //               borderRadius: BorderRadius.circular(55)),
            //           width: 100,
            //           height: 100,
            //         )
            //       : CircleAvatar(
            //           radius: 55,
            //           backgroundImage: NetworkImage(data.image.toString()),
            //         ),
            // ),
            decoration: BoxDecoration(
              color: Colors.orange,
            ),
          ),
          ListTile(
            title: Text("Filters"),
            leading: Icon(Icons.person),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Filters()));
            },
          ),
          ListTile(
            title: Text("Past Orders"),
            leading: Icon(Icons.image),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PastOrders()));
            },
          ),
            ListTile(
            title: Text("Fresh Orders"),
            leading: Icon(Icons.time_to_leave),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FreshOrders()));
            },
          ),
            ListTile(
            title: Text("Pending Orders"),
            leading: Icon(Icons.pending),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PendingOrders()));
            },
          ),
          // ListTile(
          //   title: Text("Ratings and Reviews"),
          //   leading: Icon(Icons.reviews),
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => AddRatings(
          //                   orderDocId: '',
          //                 )));
          //   },
          // ),
          // ListTile(
          //   title: Text("Accepted Orders"),
          //   leading: Icon(Icons.image),
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => AcceptedOrders()));
          //   },
          // ),
        
          // ListTile(
          //   title: Text("Logout"),
          //   leading: Icon(Icons.logout),
          //   onTap: () async {
          //     // await ref
          //     //     .read(logOut.notifier)
          //     //     .signout()
          //     //     .then((value) => Navigator.push(
          //     //           context,
          //     //           MaterialPageRoute(builder: (context) => LogIn()),
          //     //         ));
          //   },
          // ),
        ],
      );
    }, error: (Object error, StackTrace stackTrace) {
      return Center(
        child: Text("${error.toString()}"),
      );
    }, loading: () {
      return Center(
        child: CircularProgressIndicator(),
      );
    }));
  }
}
