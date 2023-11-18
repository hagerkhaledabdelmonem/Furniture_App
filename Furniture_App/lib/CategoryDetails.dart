import 'package:flutter/material.dart';
import 'API/Products.dart';
import 'Home/Search.dart';
import 'ItemWidget.dart';

class Product extends StatefulWidget {
  List<Products> category =[];
  String categoryName;
  String email ="";
  Product({required this.category, required this.categoryName,required this.email,super.key});
  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // Remove the shadow
        leadingWidth:screenWidth - 19,
        title: Container(
          width: screenWidth - 19,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Color.fromRGBO(245, 245, 245, 1),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.search,
                        color: Color(0xff79797b),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Color(0xff79797b),),
            onPressed: () async {
              final selectedProduct = await showSearch<Products>(
                context: context,
                delegate: ProductSearchDelegate(email: widget.email,
                    allProducts: widget.category,category_name: widget.categoryName),
              );
            },
          ),

        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 20,
            ),
            /*************************Gatgory Name************************/
            Text(
              "${widget.categoryName}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(200, 142, 98, 1),

                // color: Colors.deepOrangeAccent,
                fontSize: 30,
              ),
            ),
            /*************************items************************/
            itemsWidget(category: widget.category,categoryName: widget.categoryName,email: widget.email),
          ],
        ),
      ),
    );
  }
}
