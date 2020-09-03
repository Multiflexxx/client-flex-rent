import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  final cities = [
    'Berlin',
    'Paris',
    'Wien',
    'Madrid',
    'Prag',
    'Amsterdam',
    'Rom',
    'München',
    'Athen',
    'Lissabon',
    'London',
    'New York',
  ];

  final recentCities = [
    'Wien',
    'Amsterdam',
    'München',
    'London',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Card(
      color: Colors.red,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentCities
        : cities.where((element) => element.startsWith(query)).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(
          Icons.location_city,
          color: Colors.white,
        ),
        title: Text(
          suggestionList[index],
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
