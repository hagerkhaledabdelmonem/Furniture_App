
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/cupertino.dart';

import 'dart:convert';

import 'package:flutter/material.dart';

import '../API/Products.dart';
import '../Details.dart';
import 'Home.dart';

// Create a custom SearchDelegate for product search
class ProductSearchDelegate extends SearchDelegate<Products> {
  final List<Products> allProducts;
  String? category_name="chairs";
  String email = "";
  ProductSearchDelegate({required this.allProducts,required this.email,this.category_name});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        // Navigate to the back to home page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(mail: email),
          ),
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Text('No search results'),
      );
    }
    final results = allProducts
        .where((product) => product.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      return Center(
        child: Text('No matching results found.'),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final product = results[index];
        return ListTile(
          title: Text(product.title),
          subtitle: Text(product.brand ?? ''),
          onTap: () {
            // Navigate to the Details() page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Details(product: product, index: index,category: category_name!,email: email),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    final results = allProducts
        .where((product) => product.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final product = results[index];
        return ListTile(
          title: Text(product.title),
          subtitle: Text(product.brand ?? ''),
          onTap: () {
            query = product.title;
          },
        );
      },
    );
  }
}