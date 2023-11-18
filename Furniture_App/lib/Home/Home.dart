import '../Details.dart';
import 'Favorite.dart';
//import 'ShoppingCart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import '../API/Constants.dart';
import '../API/DioHelper.dart';
import '../API/Products.dart';
import '../recommendedPage.dart';
import 'dart:convert';

import '../CategoryDetails.dart';
import 'Profile.dart';
import 'Search.dart';
import 'ShoppingCart.dart';
//import 'Favorite.dart';
//import 'Profile.dart';

final int length = 6;

class HomePage extends StatefulWidget {
  @override
  String? mail;
  HomePage({ required this.mail});
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  int indexValue = 0;
  List<Products> chairs = [];
  List<Products> tables = [];
  List<Products> beds = [];
  int bedsAdded = 0;
  String categoryName="";

  @override
  void initState() {
    super.initState();
    getData();
  }
  Future<void> getData() async {
    List productsList = await DioHelper().getItems(
        path: APIConstants.baseUrl ,
        queryParameters: {"api_key": APIConstants.apiKey, "engine": APIConstants.engine,"q":"chair"});
    chairs = Products.convertToProducts(productsList);
    productsList = await DioHelper().getItems(
        path: APIConstants.baseUrl ,
        queryParameters: {"api_key": APIConstants.apiKey, "engine": APIConstants.engine,"q":"bed"});
    beds = Products.convertToProducts(productsList);

    productsList = await DioHelper().getItems(
        path: APIConstants.baseUrl ,
        queryParameters: {"api_key": APIConstants.apiKey, "engine": APIConstants.engine,"q":"table"});
    tables = Products.convertToProducts(productsList);
    print("tables: ${tables.length}");
    setState(() {});
  }

  final List<String> categoryNames = [
    "tables",
    "beds",
    "chairs",
    "sofas"
  ];
  List<Products> getCategoryList(int index){
    if(index==0) return tables;
    else if(index==1) return beds;
    else return chairs;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
                delegate: ProductSearchDelegate(email: widget.mail!,
                  allProducts: chairs + tables + beds,),
              );
            },
          ),

        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: GNav(
          color: const Color(0xff79797b),
          activeColor: const Color(0xff9c690b),
          tabBackgroundColor: const Color(0xffd3d4d8),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.favorite,
              text: 'Wishlist',
            ),
            GButton(
              icon: Icons.shopping_cart_rounded,
              text: 'Order',
            ),
            GButton(
              icon: Icons.account_circle_rounded,
              text: 'Profile',
            ),
          ],
          selectedIndex: -1,
          gap: 8,
          onTabChange: (index) {
            setState(() {
              indexValue = index;
            });
          },
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (indexValue) {
      case 0:
        return _buildHomePage();
      case 1:
        return Favorite(email: widget.mail!,);
      case 2:
        return ShoppingCart(in_home: true,email: widget.mail!,);
      case 3:
        return Profile();
      default:
      // Default to home page
        return _buildHomePage();
    }
  }

  Widget _buildHomePage() {
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 30),

            Container(
              width: screenWidth - 19,
              height: 270,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                image: DecorationImage(
                  image: NetworkImage(
                    'https://www.build-review.com/wp-content/webp-express/webp-images/uploads/2021/11/Neutral-Home-Interior.jpg.webp',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              padding: EdgeInsets.all(5),
              child: Container(
                padding: EdgeInsets.only(top: 10, left:20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Atfarg",
                      style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "New collection from Walter Knoll",
                          style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          "that's perfect for the Living Room.",
                          style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          "Discover different furniture options.",
                          style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        print("shopping");
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text("Shop Now"),
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color(0xff79797b),
                        backgroundColor: Color.fromRGBO(245, 245, 245, 1),
                        padding: EdgeInsets.symmetric(vertical: 9, horizontal: 30),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 25),

            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryNames.length,
                itemBuilder: (context, index) {
                  return _buildCategoryImage(index);
                },
              ),
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text(
                      "Recommended for You",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff534f54)
                      ),
                    ),
                    SizedBox(width: 85),


                    GestureDetector(
                      onTap: () {
                        // Navigate to the page that displays all products
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecommendedProductsPage(
                              buildRecommendedProducts: buildRecommendedProducts(),
                            ),
                          ),
                        );
                      },
                      // InkWell provides a transparent button effect
                      child: InkWell(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "See All",
                            style: TextStyle(fontSize: 14, color: Color(0xff9c690b)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),

            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),

                child: (chairs.length == 0  || tables.length == 0 || beds.length == 0) ?

                const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 117, 115, 113),
                  ),
                )
                    : buildRecommendedProducts()
            )

          ],
        ),
      ),
    );
  }

  Widget buildRecommendedProducts() {
    List<Products> recommendedProducts = [];

    // Add 2 products from the "chairs" category if available.
    if (chairs.length >= 2) {
      recommendedProducts.add(chairs[0]);
      recommendedProducts.add(chairs[1]);
    }

    // Add 2 products from the "tables" category if available.
    if (tables.length >= 2) {
      recommendedProducts.add(tables[0]);
      recommendedProducts.add(tables[1]);
    }

    // Add 2 products from the "beds" category if available.
    while (bedsAdded < beds.length && recommendedProducts.length < 6) {
      recommendedProducts.add(beds[bedsAdded]);
      bedsAdded++;
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.48,
        mainAxisSpacing: 15,
        crossAxisSpacing: 10,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: recommendedProducts.length,
      itemBuilder: (context, index) {
        if(index<2) {
          categoryName = "chairs";
        } else if(index<4) {
          categoryName = "tables";
        } else if(index<6) {
          categoryName = "beds";
        }
        return _buildImageWithDescription(
          context,
          actualImageIndex: index,
          image: "assests/2d_images/$categoryName/${index%2+1}.png",
          description: recommendedProducts[index].title,
          collection: recommendedProducts[index].brand,
          price: '\$ ${recommendedProducts[index].price.toStringAsFixed(2)}',
          maxWordsPerLine: 3,
          maxLines: 2,
          onTap: (index) {
            if(index<2) {
              categoryName = "chairs";
            } else if(index<4) {
              categoryName = "tables";
            } else if(index<6) {
              categoryName = "beds";
            }
            // Navigate to the Details() page and pass the imageIndex
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Details(product: recommendedProducts[index],index: (index%2),category: categoryName,email: widget.mail!),
              ),
            );
          },
        );
      },
    );
  }


  Widget _buildCategoryImage(int index) {
    return GestureDetector(
      onTap: () {
        // Navigate to the product description page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Product(category: getCategoryList(index), categoryName: categoryNames[index],email: widget.mail!)
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
              child: ClipOval(
                child: Image.network(
                  _getCategoryImageUrl(index),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              categoryNames[index],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xff534f54),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCategoryImageUrl(int index) {
    if (index == 0) {
      return 'https://pisces.bbystatic.com/image2/BestBuy_US/images/products/6445/6445856_sd.jpg';
    } else if (index == 1) {
      return 'https://i1.adis.ws/i/dreams/251-00268_main-shot_01_lucia-dark-grey-v3';
    } else if (index == 2) {
      return 'https://wallmantra.com/cdn/shop/products/1_c2124f13-b02d-45c7-8624-d66268a24e9f_1024x1024.jpg?v=1657878406';
    } else {
      return 'https://i5.walmartimages.com/seo/Positano-Mid-Modern-Sofa-Smoke-Grey_c3414bfa-ef30-47fe-ad45-335c7d5defaf.d1271ed020110fe8c7c0629334e41a6d.jpeg';
    }

  }


}

Widget _buildImageWithDescription(BuildContext context, {
  required int actualImageIndex,
  required String image,
  required String description,
  required String? collection,
  required String price,
  int maxWordsPerLine = 3,
  int maxLines = 2,
  required Function(int) onTap,
}) {
  // Split the description into words
  List<String> words = description.split(' ');

  // Create a list to store lines
  List<String> lines = [];

  // Initialize a current line with the first word
  String currentLine = words.isNotEmpty ? words[0] : '';

  for (int i = 1; i < words.length; i++) {
    if (currentLine.split(' ').length < maxWordsPerLine) {
      // If the current line doesn't exceed the maximum words per line, add the word
      currentLine += ' ${words[i]}';
    } else {
      // If the current line exceeds the maximum words per line, start a new line
      lines.add(currentLine);
      currentLine = words[i];
    }
  }

  // Add the last line
  lines.add(currentLine);

  // Join the lines with line breaks
  String title = lines.join('\n');

  return GestureDetector(
    onTap: () {
      //Call the onTap with the actual imageIndex
      onTap(actualImageIndex);
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 180,
          height: 250,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          maxLines: maxLines,
        ),
        const SizedBox(height: 3),
        Text(
          collection ?? " ",
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff534f54)),
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 3),
        Text(
          price,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xff9c690b)),
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 15),
      ],
    ),
  );
}

