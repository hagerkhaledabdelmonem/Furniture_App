
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';


import 'API/Products.dart';
import 'Home/ShoppingCart.dart';
import 'database/Sqflite.dart';

class Details extends StatefulWidget {
  Products product;
  int index;
  String category;
  String email = "";
  Details({super.key, required this.product,required this.index,required this.category,required this.email});
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Sqflite sql = Sqflite();
  String imageLink ="";
  int number_of_product = 0;
  @override
  // TODO: implement widget
  Details get widget => super.widget;
  @override
  Widget build(BuildContext context) {
    widget.product.rating ??= 0;
    widget.product.brand ??= " ";
    widget.product.reviews ??= 0;
    if(widget.index<3) imageLink ='assests/2d_images/${widget.category}/${widget.index+1}.png';
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                border: Border.all(width: 1.5,color: const Color(0xffd5d5d5)),
                shape: BoxShape.circle,
                color: const Color(0xffefefef),
              ),
              child: IconButton(
                onPressed: (){},
                icon: const Icon(Icons.keyboard_backspace,color: Colors.black,size: 30,),
              ),
            ),
            const Spacer(),
            const Text("Product Details",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w500
              ),
            ),
            const Spacer(),
            Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                border: Border.all(width: 1.5,color: const Color(0xffd5d5d5)),
                shape: BoxShape.circle,
                color: const Color(0xffefefef),
              ),
              child: IconButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShoppingCart(in_home: false,email: widget.email,))
                  );
                },
                icon: const Icon(Icons.shopping_cart_outlined,color: Colors.black,size: 30,),
              ),
            ),
          ],
        ),
      ),
      body:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.41,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: widget.index < 3 ? [
                      ModelViewer(
                        src:'assests/3d_images/${widget.category}/${widget.index+1}.glb',
                        ar:true,
                        arPlacement: ArPlacement.floor,
                        autoRotate: true,
                        cameraControls:true,

                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape:const CircleBorder(),
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.all(10),
                          ),
                          onPressed: ()async{
                            setState(() {
                              widget.product.is_favorited = !(widget.product.is_favorited);
                            });
                            if(widget.product.is_favorited){
                              int response = await sql.myInsert("USER_FAVORITE",
                                  {"title":widget.product.title,
                                    "price":widget.product.price,
                                    "user_email":widget.email,
                                    "image_link":(widget.index<10)? "assests/2d_images/${widget.category}/${widget.index+1}.png"
                                        : "assests/2d_images/${widget.category}/1.png"});
                            }
                            else{
                              await sql.myDelete("USER_FAVORITE", "id = ${widget.index}");
                            }
                          },
                          child: widget.product.is_favorited ? const Icon(Icons.favorite,color: Colors.red,): const Icon(Icons.favorite_border,color: Colors.grey,),
                        ),
                      )
                    ]:[
                      Container(
                          height: 400,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: widget.index < 10 ?Image.asset("assests/2d_images/${widget.category}/${widget.index+1}.png")
                                :Image.asset("assests/2d_images/${widget.category}/1.png"),
                          )
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape:const CircleBorder(),
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.all(10),
                          ),
                          onPressed: ()async{
                            setState(() {
                              widget.product.is_favorited = !(widget.product.is_favorited);
                            });
                            if(widget.product.is_favorited){
                              int response = await sql.myInsert("USER_FAVORITE",
                                  {"title":widget.product.title,
                                    "price":widget.product.price,
                                    "user_email":widget.email,
                                    "image_link":(widget.index<10)? "assests/2d_images/${widget.category}/${widget.index+1}.png"
                                        : "assests/2d_images/${widget.category}/1.png"});
                            }
                            else{
                              await sql.myDelete("USER_FAVORITE", "id = ${widget.index}");
                            }
                          },
                          child: widget.product.is_favorited ? const Icon(Icons.favorite,color: Colors.red,): const Icon(Icons.favorite_border,color: Colors.grey,),
                        ),
                      )
                    ],
                  ),

                ),

                const SizedBox(height: 15,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.product.title,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 8,),
                      Text(widget.product.brand!,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900
                        ),
                      ),
                      const SizedBox(height: 18,),
                      Row(
                        children: [
                          Icon(Icons.star,color: Colors.yellow[600],size: 30),
                          const SizedBox(width: 10,),
                          Text(widget.product.rating!.toStringAsFixed(1),
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          const SizedBox(width: 20,),
                          Text("(${widget.product.reviews} reviews)"),
                        ],
                      ),
                      const SizedBox(height: 18,),
                      Row(
                        children: [
                          Text("\$ ${widget.product.price} ",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 45,
                            height: 35,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xffefefef)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),)),
                              onPressed: (){
                                setState(() {
                                  if(number_of_product > 0) number_of_product--;
                                });
                              },
                              child: const Icon(Icons.remove,color: Colors.orange,size: 30,),
                            ),
                          ),
                          Text("   $number_of_product   ",
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 45,
                            height: 35,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xffefefef)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),)),
                              onPressed: (){
                                setState(() {
                                  number_of_product++;
                                });
                              },
                              child: const Icon(Icons.add,color: Colors.orange),
                            )
                            ,
                          )
                        ],
                      ),
                      const SizedBox(height: 5,),
                      widget.product.price_was!=null ?
                      Row(children: [
                        const SizedBox(width: 23,),
                        Text("\$ ${widget.product.price_was!.toStringAsFixed(2)}",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                      ):
                      const SizedBox(height: 25,)
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.only(left: 40,right: 25),
          height: 60,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    color: Color(0xffadadad),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(0,-2)
                )
              ]
          ),
          child:  Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Total Price",
                    style: TextStyle(
                        color: Colors.black38,
                        fontSize: 12
                    ),
                  ),
                  Text("\$ ${number_of_product*widget.product.price} ",
                    style: const TextStyle(
                      color: Colors.orange,
                    ),)
                ],
              ),
              const Spacer(),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    backgroundColor: const Color(0xffefefef),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                ),
                onPressed: ()async{
                  if(number_of_product>0){
                    int response = await sql.myInsert("USER_CART",
                        {"title":widget.product.title,
                          "price":widget.product.price,
                          "quantity":number_of_product,
                          "image_link":imageLink});
                  }
                },
                icon: const Icon(Icons.shopping_cart_outlined,size: 20,color: Colors.orange),
                label: const Text("Add to Cart",
                  style: TextStyle(
                      color: Colors.orange
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
