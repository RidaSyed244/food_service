// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_service/Drawer_Screens/add_Ratings.dart';
import 'package:image_picker/image_picker.dart';

class AddMultipleImages extends StatefulWidget {
  const AddMultipleImages({super.key});

  @override
  State<AddMultipleImages> createState() => _AddMultipleImagesState();
}

class _AddMultipleImagesState extends State<AddMultipleImages> {
  
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
            "Add Images",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Container(
                child: GridView.builder(
                    itemCount: reviewImages.length + 1,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) {
                      return index == 0
                          ? Center(
                              child: IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  chooseImages();
                                },
                              ),
                            )
                          :  ClipRRect(
                                borderRadius: BorderRadius.circular(13),
                                child: Container(
                                  margin: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(reviewImages[index-1]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                    }),
              ),
            ),
            Positioned(
              top: 650,
              left: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    color: Color.fromRGBO(238, 167, 52, 1),
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    child: MaterialButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddRatings(
                                  orderDocId: '',
                                )));
                      },
                      minWidth: 250.0,
                      height: 10.0,
                      child: Text('Upload Images',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          )),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

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

 

  // @override
  // void initState() {
  //  FirebaseFirestore.instance.collection('ReviewImages').add({
  //     "images": reviewImages,
  //   });

  //   super.initState();
  // }
}
