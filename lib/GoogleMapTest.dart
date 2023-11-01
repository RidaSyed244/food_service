import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaptest extends StatefulWidget {
  const GoogleMaptest({super.key});

  @override
  State<GoogleMaptest> createState() => _GoogleMaptestState();
}

class _GoogleMaptestState extends State<GoogleMaptest> {
  LatLng sourceLocation = LatLng(31.450366199999994, 73.13496049999999);
  LatLng destinationLocation = LatLng(28.7041, 77.1025);
  Completer<GoogleMapController> _controller = Completer();
  @override
  void initState() {
    getUserLatitude();
    getUserLongitude();
  }

  var userLatitude;
  var userLongitude;

  Future getUserLatitude() async {
    final userLocationSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) {
      setState(() {
        userLatitude = value.data()?['UserLatitude'];
        print(userLatitude);
      });
    });
  }

  Future getUserLongitude() async {
    final userLocationSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) {
      setState(() {
        userLongitude = value.data()?['UserLongitude'];
        print(userLongitude);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: sourceLocation,
            zoom: 14,
          ),
          markers: {
            Marker(
              markerId: MarkerId('All_Restaurants'),
              position: sourceLocation,
            ),
            Marker(
              markerId: MarkerId('Users'),
              position: destinationLocation,
            ),
          },
          polylines: {
            Polyline(
              polylineId: PolylineId('route'),
              points: [
                sourceLocation,
                destinationLocation,
              ],
              color: Colors.blue,
            ),
          },
        ));
  }
}
