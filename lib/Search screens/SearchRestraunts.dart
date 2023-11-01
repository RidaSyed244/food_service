import 'package:flutter/material.dart';
import 'package:food_service/Search%20screens/searchRRR.dart';
import 'package:food_service/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../UserModel.dart';

class SearchRestraunts extends ConsumerStatefulWidget {
  const SearchRestraunts({super.key});

  @override
  ConsumerState<SearchRestraunts> createState() => _SearchRestrauntsState();
}

class _SearchRestrauntsState extends ConsumerState<SearchRestraunts> {
  int bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    final searchRestraunt = ref.watch(providerrr);
    return Scaffold(
        body: Container(
      padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
      child: ListView(children: [
        Text(
          "Search",
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 50,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              backgroundColor: Color.fromRGBO(251, 251, 251, 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)),
              side: const BorderSide(
                  width: 2, color: Color.fromARGB(255, 199, 195, 195)),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RestaurantSearch()));
            },
            icon: Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.search,
                color: Colors.grey,
                size: 25.0,
              ),
            ),
            label: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Search on foodly',
                style: TextStyle(color: Colors.grey, fontSize: 17),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Top Restraunts",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 550,
              child: searchRestraunt.when(
                  data: (data) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, mainAxisExtent: 230),
                      itemCount: data.docs.length,
                      itemBuilder: (context, index) {
                        AllRestraunts searchRestraunts =
                            AllRestraunts.fromMap(data.docs[index].data());
                        if (searchRestraunts.status == "Approved") {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        height: 180,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              searchRestraunts.restraunt_logo
                                                  .toString(),
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      "${searchRestraunts.restaurant_name.toString()}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // SizedBox(
                              //   height: 5,
                              // ),
                              // // Row(
                              // //   children: [
                              // //     Row(
                              // //       mainAxisAlignment: MainAxisAlignment.start,
                              // //       children: [
                              // //         Padding(
                              // //           padding:
                              // //               const EdgeInsets.only(left: 10.0),
                              // //           child: Text(
                              // //             "\$\$",
                              // //             style: TextStyle(
                              // //               color: Colors.grey,
                              // //               fontSize: 15,
                              // //             ),
                              // //           ),
                              // //         ),
                              // //       ],
                              // //     ),
                              // //     SizedBox(
                              // //       width: 20,
                              // //     ),
                              // //     Row(
                              // //       children: [
                              // //         Icon(
                              // //           Icons.circle,
                              // //           color: Colors.grey,
                              // //           size: 4,
                              // //         ),
                              // //       ],
                              // //     ),
                              // //     Row(
                              // //       mainAxisAlignment: MainAxisAlignment.start,
                              // //       children: [
                              // //         Padding(
                              // //           padding:
                              // //               const EdgeInsets.only(left: 10.0),
                              // //           child: Text(
                              // //             "",
                              // //             style: TextStyle(
                              // //               color: Colors.grey,
                              // //               fontSize: 15,
                              // //             ),
                              // //           ),
                              // //         ),
                              // //       ],
                              // //     ),
                              //   ],
                              // ),
                            ],
                          );
                        } else {
                          return Container();
                        }

                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       image: DecorationImage(
                        //         image: NetworkImage(everyItems[index].image),
                        //         fit: BoxFit.cover,
                        //       ),
                        //     ),
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: Column(
                        //         mainAxisAlignment: MainAxisAlignment.end,
                        //         children: [
                        //           Row(
                        //             mainAxisAlignment: MainAxisAlignment.start,
                        //             children: [
                        //               Icon(
                        //                 Icons.lock_clock,
                        //                 color: Colors.white,
                        //               ),
                        //               SizedBox(
                        //                 width: 5,
                        //               ),
                        //               Text(
                        //                 "${everyItems[index].time}",
                        //                 style: TextStyle(
                        //                     color: Colors.white, fontSize: 13),
                        //               ),
                        //               SizedBox(
                        //                 height: 5,
                        //               ),
                        //             ],
                        //           ),
                        //           SizedBox(
                        //             height: 3,
                        //           ),
                        //           Row(
                        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Row(
                        //                 children: [
                        //                   Icon(Icons.donut_small_sharp,
                        //                       color: Colors.white),
                        //                   SizedBox(
                        //                     width: 4,
                        //                   ),
                        //                   Text(
                        //                     "${everyItems[index].free}",
                        //                     style: TextStyle(
                        //                         color: Colors.white, fontSize: 13),
                        //                   ),
                        //                 ],
                        //               )
                        //             ],
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // );

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     Container(
                        //       height: 100,
                        //       width: 100,
                        //       decoration: BoxDecoration(
                        //         color: Colors.white,
                        //         borderRadius: BorderRadius.circular(20),
                        //       ),
                        //       child: Column(
                        //         children: [
                        //           SizedBox(
                        //             height: 10,
                        //           ),
                        //           Row(
                        //             children: [
                        //               Text(
                        //                 "${everyItems[index].title}",
                        //                 style: TextStyle(
                        //                   color: Colors.black,
                        //                   fontSize: 15,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //           SizedBox(
                        //             height: 5,
                        //           ),
                        //           Text(
                        //             "${everyItems[index].discription}",
                        //             style: TextStyle(
                        //               color: Colors.grey,
                        //               fontSize: 12,
                        //             ),
                        //           ),
                        //           SizedBox(
                        //             height: 5,
                        //           ),
                        //           Text(
                        //             "${everyItems[index].area}",
                        //             style: TextStyle(
                        //               color: Colors.grey,
                        //               fontSize: 12,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      },
                    );
                  },
                  error: (error, stackTrace) {
                    return Text("Error");
                  },
                  loading: () => Center(child: CircularProgressIndicator())),
            ),
          ],
        )
      ]),
    ));
  }
}
