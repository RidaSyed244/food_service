import 'package:flutter/material.dart';
import 'package:food_service/Search%20screens/Search_Results.dart';
import 'package:food_service/StateManagement.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:searchfield/searchfield.dart';
  final clear = StateNotifierProvider((ref) => Services());

class SearchingFood extends ConsumerStatefulWidget {
  const SearchingFood({super.key});

  @override
  ConsumerState<SearchingFood> createState() => _SearchingFoodState();
}

class _SearchingFoodState extends ConsumerState<SearchingFood> {
  List _suggestions = [
    "  Burgers",
    "  Pizza",
    "  Sandwich",
    "  Rolls",
    "  Pasta",
    "  Drinks",
    "  Bakery",
    "  Cake",
    "  Subway",
    "  Fried rice with meat"

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: SearchField(
              searchInputDecoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  suffixIcon: TextButton(
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Color.fromARGB(255, 97, 95, 95),
                        fontSize: 17,
                      ),
                    ),
                    onPressed: (() {
                      ref.read(clear.notifier).clearSearchController();
                    }),
                  ),
                  isCollapsed: false,
                  icon: Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 129, 126, 126),
                    size: 28,
                  ),
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                  )),
              suggestionState: Suggestion.expand,
              suggestionAction: SuggestionAction.next,
              suggestions:
                  _suggestions.map((e) => SearchFieldListItem(e)).toList(),
              textInputAction: TextInputAction.next,
              controller: searchController,
              maxSuggestionsInViewPort: 5,
              itemHeight: 45,
              onSuggestionTap: (e) {
                 Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchResults(
                              searchFood: searchController.text,
                            )));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("RECENT SEARCHES",
                        style: TextStyle(
                          color: Color.fromARGB(255, 179, 175, 175),
                          fontSize: 17,
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "CLEAR ALL",
                          style: TextStyle(
                            color: Color.fromARGB(255, 158, 156, 156),
                            fontSize: 15,
                          ),
                        ))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
