import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_service/Home%20Screens/Featured_Partners.dart';

class Categories {
  final String CategoryName;
  final String CategoryImage;

  Categories({
    required this.CategoryName,
    required this.CategoryImage,
  });
}

class SearchCategories extends StatefulWidget {
  const SearchCategories({super.key});

  @override
  State<SearchCategories> createState() => _SearchCategoriesState();
}

class _SearchCategoriesState extends State<SearchCategories> {
  var searchText = '';
  List<Categories> filteredCategories = [];
  List<Categories> allCategories = [];

  @override
  void initState() {
    super.initState();
    fetchAllCategoriesFromFB();
  }

  void fetchAllCategoriesFromFB() async {
    final snapshot =
        await FirebaseFirestore.instance.collectionGroup('Category').get();

    if (snapshot.docs.isNotEmpty) {
      allCategories = snapshot.docs
          .map((doc) => Categories(
                CategoryName: doc.get('CategoryName').toString(),
                CategoryImage: doc.get('CategoryImage').toString(),
              ))
          .toList();
    }
  }

  void searchcategories(String searchQuery) {
    setState(() {
      searchText = searchQuery;
      filteredCategories = allCategories
          .where((category) => category.CategoryName.toLowerCase()
              .startsWith(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: Column(
          children: [
            TextField(
              onChanged: searchcategories,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: '  Search',
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
                // suffixIcon: TextButton(
                //     onPressed: () {
                //       setState(() {
                //         searchText = '';
                //         filteredCategories = [];
                //       });
                //     },
                //     child: Text(
                //       'Cancel',
                //       style: TextStyle(color: Colors.grey, fontSize: 15,),
                //     )
                //     ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Top Categories",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            // SizedBox(height: 16),
            if (searchText.isNotEmpty)
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisExtent: 200),
                  itemCount: filteredCategories.length,
                  itemBuilder: (context, index) {
                    final category = filteredCategories[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FeaturedPartners(
                                        storeDocId: '',
                                        storeIndexId: 0,
                                        resName: resnamee,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 180,
                                  width: 300,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.4),
                                        BlendMode.darken,
                                      ),
                                      image: NetworkImage(
                                        category.CategoryImage,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Text(
                                          "${category.CategoryName}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.only(left: 10.0),
                        //       child: Text(
                        //         "${category.CategoryName}",
                        //         style: TextStyle(
                        //           color: Colors.black,
                        //           fontSize: 20,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        ///////////////For Category ////////////////
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.only(left: 10.0),
                        //       child: Text(
                        //         "${restaurant.status}",
                        //         style: TextStyle(
                        //           color: Colors.grey,
                        //           fontSize: 15,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    );
                    // ListTile(
                    //   leading: Image.network(restaurant.restraunt_logo),
                    //   title: Text(restaurant.restaurant_name),
                    //   subtitle: Text(restaurant.restraunt_currency),
                    // );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
