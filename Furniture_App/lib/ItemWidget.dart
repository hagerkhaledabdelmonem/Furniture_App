
import 'Details.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'API/Products.dart';
import 'database/Sqflite.dart';

class itemsWidget extends StatefulWidget {
  List<Products> category = [];
  String categoryName;
  String email="";
  itemsWidget({required this.category,required this.categoryName,required this.email, super.key});

  @override
  State<itemsWidget> createState() => _itemsWidgetState();
}

class _itemsWidgetState extends State<itemsWidget> {
  Sqflite sql =Sqflite();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
          childAspectRatio: 0.51,
          // Adjust spacing between rows
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          // Disable scrolling within the grid
          physics: BouncingScrollPhysics(),
          children: List.generate(
            widget.category.length,
                (index) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Details(product: widget.category[index],index: index,category: widget.categoryName,email: widget.email,)
                  ),
                );
              },
              child: Container(

                padding: const EdgeInsets.only( top: 0),
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(248, 248, 248, 1),
                  //color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child:(index<9)?Image.asset(
                                "assests/2d_images/${widget.categoryName}/${index+1}.png",
                                fit: BoxFit.cover,
                              ):Image.asset(
                                "assests/2d_images/${widget.categoryName}/1.png",
                                fit: BoxFit.cover,
                              )
                          ),

                          Positioned(
                            right: 10,
                            top: 10,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.all(3),
                              ),
                              onPressed: () async{
                                setState(() {
                                  widget.category[index].is_favorited =
                                  !widget.category[index].is_favorited;
                                });
                                if(widget.category[index].is_favorited){
                                  int response = await sql.myInsert("USER_FAVORITE",
                                      {"title":widget.category[index].title,
                                        "price":widget.category[index].price,
                                        "user_email":widget.email,
                                        "image_link":(index<9)? "assests/2d_images/${widget.categoryName}/${index+1}.png"
                                            : "assests/2d_images/${widget.categoryName}/${index%10}.png"});
                                }
                                else{
                                  await sql.myDelete("USER_FAVORITE", "id = ${index}");
                                }
                              },
                              child: widget.category[index].is_favorited
                                  ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                                  : const Icon(
                                Icons.favorite_border,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 9,right: 9,top: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${widget.category[index].title}",

                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 9,right: 7,top: 10),

                      alignment: Alignment.centerLeft,
                      child: Text(
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        "${widget.category[index].brand}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xff534f54)
                          // fontSize: 14,
                          // color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 9,right: 7,top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            textAlign: TextAlign.start,
                            " \$${widget.category[index].price}",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff9c690b)

                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
