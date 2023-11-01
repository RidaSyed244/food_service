import 'package:flutter/material.dart';
import 'package:food_service/Home%20Screens/HomePage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import '../StateManagement.dart';
import '../featuredItems.dart';

int selectedButtonIndex = -1;
final findRestraunt = StateNotifierProvider((ref) => Services());

class FindRestraunts extends ConsumerStatefulWidget {
  const FindRestraunts({super.key});

  @override
  ConsumerState<FindRestraunts> createState() => _FindRestrauntsState();
}

class _FindRestrauntsState extends ConsumerState<FindRestraunts> {
  void handleButtonTap(int index) {
    if (selectedButtonIndex == index) {
      setState(() {
        selectedButtonIndex = -1;
      });

      selectedButtonIndex = -1;
    } else {
      setState(() {
        selectedButtonIndex = index;
      });
    }
  }

  buildButton(String title, int index) {
    Color color = selectedButtonIndex == index
        ? Color.fromRGBO(254, 248, 237, 1)
        : Color.fromRGBO(244, 244, 244, 1);
    Color textColor = selectedButtonIndex == index
        ? Color.fromRGBO(238, 167, 52, 1)
        : Colors.grey;

    return GestureDetector(
      onTap: () {
        handleButtonTap(index);
      },
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            '${title}',
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
  // List<Color> _containerColor =
  //     List.filled(filterText.length, Color.fromARGB(255, 243, 243, 243));
  // List<Color> secondContainerColor =
  //     List.filled(dietaryText.length, Color.fromARGB(255, 243, 243, 243));
  // List<Color> thirdContainerColor =
  //     List.filled(priceText.length, Color.fromARGB(255, 243, 243, 243));
  // void changeColor(int index) {
  //   setState(() {
  //     if (_containerColor[index] == Color.fromARGB(255, 243, 243, 243)) {
  //       _containerColor[index] = Color.fromRGBO(238, 167, 52, 1);
  //     } else {
  //       _containerColor[index] = Color.fromARGB(255, 243, 243, 243);
  //     }
  //     ;
  //   });
  // }

  // void secondchangeColor(int index) {
  //   setState(() {
  //     if (secondContainerColor[index] == Color.fromARGB(255, 243, 243, 243)) {
  //       secondContainerColor[index] = Color.fromRGBO(238, 167, 52, 1);
  //     } else {
  //       secondContainerColor[index] = Color.fromARGB(255, 243, 243, 243);
  //     }
  //     ;
  //   });
  // }

  // void thirdchangeColor(int index) {
  //   setState(() {
  //     if (thirdContainerColor[index] == Color.fromARGB(255, 243, 243, 243)) {
  //       thirdContainerColor[index] = Color.fromRGBO(238, 167, 52, 1);
  //     } else {
  //       thirdContainerColor[index] = Color.fromARGB(255, 243, 243, 243);
  //     }
  //     ;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          OpenStreetMapSearchAndPick(
              center: LatLong(23, 89), onPicked: (pickedData) {}),
          DraggableScrollableSheet(builder: ((context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                              child: Container(
                                alignment: Alignment.center,
                                height: 4,
                                width: 40,
                                color: Color.fromARGB(255, 207, 203, 203),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text("Top Pick Restraunts",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              buildButton("BURGERS", 0),

                              buildButton("BRUNCH", 1),

                              buildButton("BREAKFAST", 2),

                              // Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       GestureDetector(
                              //         child: Material(
                              //           color: _containerColor[0],
                              //           borderRadius: BorderRadius.all(
                              //               Radius.circular(22.0)),
                              //           child: MaterialButton(
                              //             onPressed: () async {
                              //               changeColor(0);
                              //             },
                              //             minWidth: 30.0,
                              //             height: 10.0,
                              //             child: Text('BURGERS',
                              //                 style: TextStyle(
                              //                   color: Colors.grey,
                              //                   fontSize: 16.0,
                              //                 )),
                              //           ),
                              //         ),
                              //       )
                              //     ]),
                              // SizedBox(
                              //   width: 10,
                              // ),
                              // Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       GestureDetector(
                              //         child: Material(
                              //           color: _containerColor[1],
                              //           borderRadius: BorderRadius.all(
                              //               Radius.circular(22.0)),
                              //           child: MaterialButton(
                              //             onPressed: () async {
                              //               changeColor(1);
                              //             },
                              //             minWidth: 30.0,
                              //             height: 10.0,
                              //             child: Text('BRUNCH',
                              //                 style: TextStyle(
                              //                   color: Colors.grey,
                              //                   fontSize: 16.0,
                              //                 )),
                              //           ),
                              //         ),
                              //       )
                              //     ]),
                              // SizedBox(
                              //   width: 10,
                              // ),
                              // Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       GestureDetector(
                              //         child: Material(
                              //           color: _containerColor[2],
                              //           borderRadius: BorderRadius.all(
                              //               Radius.circular(22.0)),
                              //           child: MaterialButton(
                              //             onPressed: () async {
                              //               changeColor(2);
                              //             },
                              //             minWidth: 30.0,
                              //             height: 10.0,
                              //             child: Text('BREAKFAST',
                              //                 style: TextStyle(
                              //                   color: Colors.grey,
                              //                   fontSize: 16.0,
                              //                 )),
                              //           ),
                              //         ),
                              //       )
                              //     ]),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 1,
                          width: double.infinity,
                          color: Color.fromARGB(255, 207, 203, 203),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 167, 0, 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(
                                      address: '',
                                    )));
                      },
                      child: Container(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, mainAxisExtent: 380),
                          controller: scrollController,
                          itemCount: browseFood.length,
                          itemBuilder: (context, index) {
                            final food = browseFood[index];
                            return buildFood(food);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }))
        ],
      ),
    );
  }

  buildFood(FoodItems food) {
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
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        food.image,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.lock_clock,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "${food.time}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.donut_small_sharp,
                                          color: Colors.white),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${food.free}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 60,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                              height: 23,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    238, 167, 52, 1),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Center(
                                                  child: Text("4.5",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 13)))),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
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
                "${food.title}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "${food.discription}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Row(
              children: [
                Icon(
                  Icons.circle,
                  color: Colors.grey,
                  size: 4,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "${food.area}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
