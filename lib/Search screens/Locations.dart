// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:food_service/Payment%20Screens/Card_List.dart';
// import 'package:food_service/StateManagement.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:searchfield/searchfield.dart';

// class Locations extends ConsumerWidget {
//   List _suggestions = [
//     "  Lahore",
//     "  Faisalabad",
//     "  Karachi",
//     "  Islamabad",
//     "  Bahawalpur",
//     "  Sialkot",
//   ];
//   final _searchController = TextEditingController();
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           color: Colors.black,
//           onPressed: () {
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => CardList()));
//           },
//           icon: Icon(Icons.arrow_back),
//         ),
//         title: Text(
//           "Payment Methods",
//           style: TextStyle(
//               color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w600),
//         ),
//       ),
//       body: Container(
//         child: ListView(
//           children: [
//             Padding(
//               padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
//               child: Container(
//                 width: 100,
//                 padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
//                 decoration: BoxDecoration(
//                   color: Color.fromARGB(255, 245, 245, 245),
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: SearchField(
//                   searchInputDecoration: InputDecoration(
//                       contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 0),
//                       isCollapsed: false,
//                       icon: Icon(
//                         Icons.location_on,
//                         color: Color.fromARGB(255, 129, 126, 126),
//                       ),
//                       border: InputBorder.none,
//                       hintText: 'Search new address',
//                       hintStyle: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 17,
//                       )),
//                   suggestionState: Suggestion.expand,
//                   suggestionItemDecoration: BoxDecoration(
//                       shape: BoxShape.rectangle,
//                       border: Border.all(
//                         color: Colors.transparent,
//                       )),
//                   suggestionAction: SuggestionAction.next,
//                   suggestions:
//                       _suggestions.map((e) => SearchFieldListItem(e)).toList(),
//                   textInputAction: TextInputAction.next,
//                   controller: _searchController,
//                   autoCorrect: true,
//                   maxSuggestionsInViewPort: 5,
//                   itemHeight: 60,
//                   onSuggestionTap: (e) {},
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text("RECENT ADDRESS",
//                           style: TextStyle(
//                             color: Color.fromARGB(255, 179, 175, 175),
//                             fontSize: 17,
//                           )),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       TextButton(
//                           onPressed: () {},
//                           child: Text(
//                             "CLEAR ALL",
//                             style: TextStyle(
//                               color: Color.fromARGB(255, 158, 156, 156),
//                               fontSize: 15,
//                             ),
//                           ))
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//                 height: 700,
//                 child: ListView.builder(
//                     itemCount: 1,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Text(
//                           "${_searchController.text}",
//                           style: TextStyle(color: Colors.black),
//                         ),
//                         textColor: Colors.black,
//                         leading: Icon(Icons.location_on),
//                       );
//                     }))
//           ],
//         ),
//       ),
//     );
//   }
// }
