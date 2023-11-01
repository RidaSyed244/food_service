import 'package:flutter/material.dart';

import 'StateManagement.dart';

class SecondCardItems {
  String urlImage;
  String title;
  String subtitle;
  SecondCardItems(
      {required this.urlImage, required this.title, required this.subtitle});
}

class CardItems {
  String urlImage;
  String title;
  String subtitle;
  CardItems(
      {required this.urlImage, required this.title, required this.subtitle});
}

class ThirdCardItems {
  String urlImage;
  String title;
  String subtitle;
  ThirdCardItems(
      {required this.urlImage, required this.title, required this.subtitle});
}

List<CardItems> items1 = [
  CardItems(
    urlImage:
        "https://images.unsplash.com/photo-1618411640018-972400a01458?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8a3Jpc3B5JTIwY3JlbWV8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60",
    title: "Krispy Creme",
    subtitle: "St Georgece Terrace, Perth",
  ),
  CardItems(
    urlImage:
        "https://images.unsplash.com/photo-1506280754576-f6fa8a873550?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aXRhbGlhbm8lMjBmb29kfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=400&q=60",
    title: "Mario Italiano",
    subtitle: "Hay Street Perth City",
  ),
  CardItems(
    urlImage:
        "https://images.unsplash.com/photo-1519676867240-f03562e64548?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8ZnJlbmNoJTIwZm9vZHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=400&q=60",
    title: "PanCake",
    subtitle: "1/1 St Georges Terrace, Perth",
  ),
  CardItems(
    urlImage:
        "https://images.unsplash.com/photo-1585032226651-759b368d7246?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8Y2hpbmVzZSUyMGZvb2R8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60",
    title: "Chinese Pasta",
    subtitle: "Mexico Street, Perth",
  ),
  CardItems(
    urlImage:
        "https://images.unsplash.com/photo-1525755662778-989d0524087e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Y2hpbmVzZSUyMGZvb2R8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60",
    title: "Orange Chicken",
    subtitle: "USA Street",
  ),
  CardItems(
    urlImage:
        "https://images.unsplash.com/photo-1555126634-323283e090fa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8Y2hpbmVzZSUyMGZvb2R8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60",
    title: "Noodles",
    subtitle: "Canada Street",
  )
];
List<ThirdCardItems> items3 = [
  ThirdCardItems(
    urlImage:
        "https://images.unsplash.com/photo-1618411640018-972400a01458?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8a3Jpc3B5JTIwY3JlbWV8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60",
    title: "Krispy Creme",
    subtitle: "St Georgece Terrace, Perth",
  ),
  ThirdCardItems(
    urlImage:
        "https://images.unsplash.com/photo-1506280754576-f6fa8a873550?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aXRhbGlhbm8lMjBmb29kfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=400&q=60",
    title: "Mario Italiano",
    subtitle: "Hay Street Perth City",
  ),
  ThirdCardItems(
    urlImage:
        "https://images.unsplash.com/photo-1519676867240-f03562e64548?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8ZnJlbmNoJTIwZm9vZHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=400&q=60",
    title: "PanCake",
    subtitle: "1/1 St Georges Terrace, Perth",
  ),
  ThirdCardItems(
    urlImage:
        "https://images.unsplash.com/photo-1585032226651-759b368d7246?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8Y2hpbmVzZSUyMGZvb2R8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60",
    title: "Chinese Pasta",
    subtitle: "Mexico Street, Perth",
  ),
  ThirdCardItems(
    urlImage:
        "https://images.unsplash.com/photo-1525755662778-989d0524087e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Y2hpbmVzZSUyMGZvb2R8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60",
    title: "Orange Chicken",
    subtitle: "USA Street",
  ),
  ThirdCardItems(
    urlImage:
        "https://images.unsplash.com/photo-1555126634-323283e090fa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8Y2hpbmVzZSUyMGZvb2R8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60",
    title: "Noodles",
    subtitle: "Canada Street",
  )
];
List<SecondCardItems> items2 = [
  SecondCardItems(
    urlImage:
        "https://images.unsplash.com/photo-1609428079875-ae186c562aff?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bWNkb25hbGRzJTIwZnJpZXN8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60",
    title: "McDonald's",
    subtitle: "Hay Street Perth City",
  ),
  SecondCardItems(
    urlImage:
        "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YnVyZ2VyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=400&q=60",
    title: "The Halal Guys",
    subtitle: "Hay Street Perth City",
  ),
  SecondCardItems(
    urlImage:
        "https://images.unsplash.com/photo-1604152135912-04a022e23696?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8c291cHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=400&q=60",
    title: "Halal Soup",
    subtitle: "1/1 St Georges Terrace, Perth",
  ),
  SecondCardItems(
    urlImage:
        "https://images.unsplash.com/photo-1626322751504-930506dd41ca?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8ZHVtcGxpbmdzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=400&q=60",
    title: "Cheese Dumplings",
    subtitle: "Mexico Street, Perth",
  ),
  SecondCardItems(
    urlImage:
        "https://images.unsplash.com/photo-1546549032-9571cd6b27df?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YWxmcmVkb3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=400&q=60",
    title: "Alfredo Pasta",
    subtitle: "USA Street",
  ),
  SecondCardItems(
    urlImage:
        "https://images.unsplash.com/photo-1505253716362-afaea1d3d1af?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cnVzc2lhbiUyMGZydWl0JTIwc2FsYWR8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60",
    title: "Russian Fruit Salad",
    subtitle: "Canada Street",
  )
];

List imageList = [
  {
    "id": 1,
    "image_path":
        "https://images.unsplash.com/photo-1555939594-58d7cb561ad1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"
  },
  {
    "id": 1,
    "image_path":
        "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8Zm9vZHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=400&q=60"
  },
  {
    "id": 1,
    "image_path":
        "https://images.unsplash.com/photo-1565958011703-44f9829ba187?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8Zm9vZHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=400&q=60"
  },
  {
    "id": 1,
    "image_path":
        "https://images.unsplash.com/photo-1499028344343-cd173ffc68a9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fGZvb2R8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60"
  },
  {
    "id": 1,
    "image_path":
        "https://images.unsplash.com/photo-1481931098730-318b6f776db0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzB8fGZvb2R8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60"
  }
];
Widget buildCard({ required CardItems items }) {
  return Container(
    width: 200,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: AspectRatio(
          aspectRatio: 4.7 / 3,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                items.urlImage,
                fit: BoxFit.cover,
              )),
        )),
        SizedBox(
          height: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(items.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                )),
          ],
        ),
        SizedBox(
          height: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(items.subtitle,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                )),
          ],
        ),
        SizedBox(
          height: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                    height: 23,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(238, 167, 52, 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                        child: Text("4.5",
                            style:
                                TextStyle(color: Colors.white, fontSize: 13)))),
              ],
            ),
            SizedBox(
              width: 9,
            ),
            Column(
              children: [
                Text(
                  "25 min",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
            SizedBox(
              width: 9,
            ),
            Column(
              children: [
                Icon(
                  Icons.circle,
                  color: Colors.grey,
                  size: 5,
                ),
              ],
            ),
            SizedBox(
              width: 4,
            ),
            Column(
              children: [
                Text(
                  "Free delivery",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            )
          ],
        ),
      ],
    ),
  );
}
// Widget RatingReviewImages({required ) {
//   return
// }


Widget buildSecondCards({required SecondCardItems items}) {
  return Container(
    width: 200,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: AspectRatio(
          aspectRatio: 4.7 / 3,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                items.urlImage,
                fit: BoxFit.cover,
              )),
        )),
        SizedBox(
          height: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(items.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                )),
          ],
        ),
        SizedBox(
          height: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(items.subtitle,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                )),
          ],
        ),
        SizedBox(
          height: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                    height: 23,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(238, 167, 52, 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                        child: Text("4.5",
                            style:
                                TextStyle(color: Colors.white, fontSize: 13)))),
              ],
            ),
            SizedBox(
              width: 9,
            ),
            Column(
              children: [
                Text(
                  "25 min",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
            SizedBox(
              width: 9,
            ),
            Column(
              children: [
                Icon(
                  Icons.circle,
                  color: Colors.grey,
                  size: 5,
                ),
              ],
            ),
            SizedBox(
              width: 4,
            ),
            Column(
              children: [
                Text(
                  "Free delivery",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            )
          ],
        )
      ],
    ),
  );
}

Widget buildThirdCard({required ThirdCardItems items}) {
  return Container(
    height: 600,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: AspectRatio(
          aspectRatio: 4.7 / 3,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                items.urlImage,
                fit: BoxFit.cover,
              )),
        )),
        SizedBox(
          height: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(items.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                )),
          ],
        ),
        SizedBox(
          height: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(items.subtitle,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                )),
          ],
        ),
        SizedBox(
          height: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                    height: 23,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(238, 167, 52, 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                        child: Text("4.5",
                            style:
                                TextStyle(color: Colors.white, fontSize: 13)))),
              ],
            ),
            SizedBox(
              width: 9,
            ),
            Column(
              children: [
                Text(
                  "25 min",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
            SizedBox(
              width: 9,
            ),
            Column(
              children: [
                Icon(
                  Icons.circle,
                  color: Colors.grey,
                  size: 5,
                ),
              ],
            ),
            SizedBox(
              width: 4,
            ),
            Column(
              children: [
                Text(
                  "Free delivery",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            )
          ],
        )
      ],
    ),
  );
}
