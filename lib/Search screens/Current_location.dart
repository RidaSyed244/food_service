// ignore_for_file: unused_local_variable, unused_label, unnecessary_null_comparison, unused_element

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_service/bottomFile.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:food_service/Home%20Screens/HomePage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import '../StateManagement.dart';

class CurrentLocation extends ConsumerStatefulWidget {
  const CurrentLocation({super.key});

  @override
  ConsumerState<CurrentLocation> createState() => _CurrentLocationState();
}

class _CurrentLocationState extends ConsumerState<CurrentLocation> {
  void onChange() {
    if (sessionToken == null) {
      setState(() {
        sessionToken = uuid.v4();
      });
    }
    getSuggestions(searchLocationn.text);
  }

  String? data;
  void GetAddressfromLatLong(Position datas) async {
    List<Placemark> placeMark =
        await placemarkFromCoordinates(datas.latitude, datas.longitude);
    Placemark places = placeMark[0];
    var address = "${places.locality},${places.country}";
    setState(() {
      data = address;
    });
    String UserAddress = data.toString();
    if (UserAddress.isNotEmpty) {
      try {
        List<Location> locations = await locationFromAddress(UserAddress);
        if (locations.isNotEmpty) {
          setState(() {
            _latitude = locations.first.latitude.toString();
            _longitude = locations.first.longitude.toString();
          });
          await FirebaseFirestore.instance
              .collection("Users")
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .update({
            "UserAddress": data.toString(),
            "UserLatitude": locations.first.latitude,
            "UserLongitude": locations.first.longitude,
          });
        }
      } catch (e) {
        print("Error: $e");
      }
    }
  }

  String _latitude = '';
  String _longitude = '';

  determinedPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled == false) {
      return Future.error("Location service are disabled");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permissions denied forever");
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  void getSuggestions(String input) async {
    String kPLACES_API_KEY = "AIzaSyB8Jj-czijVcqGI5gLyEi7Zb9s7VmyTPts";
    String baseUrl =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request =
        "$baseUrl?input=$input&key=$kPLACES_API_KEY&sessiontoken=$sessionToken&components=country:in";

    final response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    print("data");
    print(data);
    if (response.statusCode == 200) {
      setState(() {
        placePrediction = jsonDecode(response.body.toString())["predictions"];
      });
    } else {
      print("error");
    }
  }

  getLocation() async {
    var status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      Position datas = await determinedPosition();
      GetAddressfromLatLong(datas);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BottonNavigation(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    searchLocationn.addListener(() {
      onChange();
    });
  }

////current location

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 35, 20, 0),
        child: ListView(children: [
          Text('Find restraunts near you',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: 15,
          ),
          Text(
              'Please enter your location or allow access to\nyour location to find restraunts near you.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 17.0, color: Color.fromRGBO(164, 164, 164, 1))),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7)),
                side: const BorderSide(width: 2, color: Colors.orange),
              ),
              onPressed: () async {
                // await ref.read(currentLocation.notifier).getLocation();
                await getLocation();

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BottonNavigation()));
              },
              icon: Icon(
                Icons.ios_share,
                color: Colors.orange,
                size: 24.0,
              ),
              label: Text(
                'Use current location',
                style: TextStyle(color: Colors.orange, fontSize: 17),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Form(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchLocationn,
                onChanged: (value) {},
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: "Search your location",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Icon(
                      Icons.location_on,
                      color: Color.fromRGBO(164, 164, 164, 1),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 600,
            child: ListView.builder(
                itemCount: placePrediction.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(placePrediction[index]["description"]),
                    onTap: () async {
                      String UserAddress =
                          placePrediction[index]["description"];
                      if (UserAddress.isNotEmpty) {
                        try {
                          List<Location> locations =
                              await locationFromAddress(UserAddress);
                          if (locations.isNotEmpty) {
                            setState(() {
                              _latitude = locations.first.latitude.toString();
                              _longitude = locations.first.longitude.toString();
                            });
                            await FirebaseFirestore.instance
                                .collection("Users")
                                .doc(FirebaseAuth.instance.currentUser?.uid)
                                .update({
                              "UserAddress": placePrediction[index]
                                  ["description"],
                              "UserLatitude": locations.first.latitude,
                              "UserLongitude": locations.first.longitude,
                            });
                          }
                        } catch (e) {
                          print("Error: $e");
                        }
                      }

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottonNavigation()));
                    },
                  );
                }),
          ),
        ]),
      ),
    );
  }
}
