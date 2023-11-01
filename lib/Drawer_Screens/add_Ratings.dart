import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:food_service/Drawer_Screens/add_MultipleImages.dart';
import 'package:food_service/Order%20Screens/pastOrders.dart';
import 'package:food_service/bottomFile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart' as Path;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';

List<File> reviewImages = [];
final picker = ImagePicker();
CollectionReference? ImageRef;
firebase_storage.Reference? ref;

class AddRatings extends ConsumerStatefulWidget {
  const AddRatings({
    this.StoreUid,
    this.orderDocId,
  });
  final String? StoreUid;
  final String? orderDocId;
  @override
  ConsumerState<AddRatings> createState() => _AddRatingsState();
}

class _AddRatingsState extends ConsumerState<AddRatings> {
  final reviewController = TextEditingController();
  double rating = 0;
  String userName = '';
  Future getUserName() async {
    final DocumentSnapshot<Map<String, dynamic>> user = await FirebaseFirestore
        .instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    userName = user.data()!['UserName'];
    setState(() {
      userName = user.data()!['UserName'];
    });
  }

  void submitReview() async {}
  chooseImages() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      reviewImages.add(File(pickedFile!.path));
    });
    if (pickedFile!.path == null) {
      retrieveLostData();
    }
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        reviewImages.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.orange,
        leading: IconButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Ratings and Reviews",
          style: TextStyle(
              color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
        child: ListView(
          children: [
            Text(
              "Unlock the power of feedback! Your ratings\nand reviews play a crucial role in shaping\nour products/services",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "Delicious Captures*",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(73, 73, 73, 1),
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddMultipleImages()));
              },
              child: Container(
                child: Center(
                  child: Text(
                    "Upload Images",
                    style: TextStyle(color: Colors.orange, fontSize: 20),
                  ),
                ),
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "Selected Images",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(73, 73, 73, 1),
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: reviewImages.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                        ),
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(13),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(reviewImages[index]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      reviewImages.removeAt(index);
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      size: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
//...

//...

            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "Write a review*",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(73, 73, 73, 1),
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              maxLines: 4,
              controller: reviewController,
              onChanged: (value) {},
              style: TextStyle(
                color: Colors.grey,
              ),
              decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 80.0),
                    child: Icon(
                      Icons.reviews,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: "Write your review here....",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2.0),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "Rate the product*",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(73, 73, 73, 1),
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 140,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: RatingBar.builder(
                      minRating: 1,
                      direction: Axis.horizontal,
                      updateOnDrag: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          this.rating = rating;
                        });
                      },
                    ),
                  ),
                  Text("Ratings: ${rating.toString()}",
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 20,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Material(
                color: Colors.orange,
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
                child: MaterialButton(
                  onPressed: () async {
                    final userId = FirebaseAuth.instance.currentUser?.uid;

                    try {
                      // Update the "Rating" field in the specific order document
                      await FirebaseFirestore.instance
                          .collection("All_Restraunts")
                          .doc(selectedOrder)
                          .collection("All_Orders")
                          .doc(selectedOrderDocId) // Use widget.orderDocId
                          .update({'Rating': "Added_Review"});
                      print('Done saving rating');

                      // Upload review images to Firebase Storage
                      final List<Map<String, dynamic>> imageUrls = [];
                      for (var imageFile in reviewImages) {
                        final imageName = Path.basename(imageFile.path);
                        final ref = firebase_storage.FirebaseStorage.instance
                            .ref()
                            .child('ReviewImages/$imageName');

                        final uploadTask = ref.putFile(imageFile);
                        final snapshot =
                            await uploadTask.whenComplete(() => null);

                        if (snapshot.state ==
                            firebase_storage.TaskState.success) {
                          final imageUrl = await ref.getDownloadURL();
                          imageUrls.add({"ImageUrls": imageUrl});
                        }
                      }

                      // Create the review data
                      final reviewData = {
                        "orderId": widget.orderDocId, // Use widget.orderDocId
                        'imageUrls': imageUrls,
                        'Review': reviewController.text,
                        'Rating': rating,
                        'Name': userName,
                        'Email': FirebaseAuth.instance.currentUser!.email,
                        'Time': DateTime.now(),
                        'uid': userId,
                      };

                      // Find and update the restaurant document
                      final collectionRef = FirebaseFirestore.instance
                          .collection('All_Restraunts');
                      final querySnapshot = await collectionRef
                          .where("uid", isEqualTo: widget.StoreUid)
                          .get();

                      if (querySnapshot.docs.isNotEmpty) {
                        final restaurantDoc = querySnapshot.docs.first;
                        final restaurantRef = restaurantDoc.reference;

                        final docRef = await restaurantRef
                            .collection('RatingsandReviews')
                            .add(reviewData);
                        final documentId = (await docRef).id;

                        for (var imageUrl in imageUrls) {
                          await restaurantRef
                              .collection('RatingsandReviews')
                              .doc(documentId)
                              .update({
                            'imageUrls': FieldValue.arrayUnion([imageUrl]),
                          });
                        }
                      }

                      print('Done saving review');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottonNavigation(),
                        ),
                      );
                    } catch (e) {
                      print('rating issue: $e');
                      // Handle errors here
                    }
                  },
                  minWidth: 220.0,
                  height: 10.0,
                  child: Text('Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    getUserName();
    super.initState();
  }
}
