import 'package:flutter/material.dart';
import 'API/Products.dart';

class RecommendedProductsPage extends StatelessWidget {
  final Widget buildRecommendedProducts;

  RecommendedProductsPage({required this.buildRecommendedProducts,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(13.0),
                child: Text(
                  "All Products",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: buildRecommendedProducts), // Display the provided widget
            ],
          ),
        ),
      ),
    );
  }
}
