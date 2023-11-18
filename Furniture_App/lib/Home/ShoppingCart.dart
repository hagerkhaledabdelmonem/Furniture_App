
import 'package:flutter/material.dart';

import '../database/Sqflite.dart';
import 'Home.dart';

class ShoppingCart extends StatefulWidget {
  bool in_home = false;
  String email;
  ShoppingCart({super.key,required this.in_home,required this.email});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  Sqflite sql = Sqflite();
  List shoppingList = [];
  List quantity =[];
  double totalPrice = 0;

  void readCartData()async{
    shoppingList.addAll(await sql.myRead("USER_CART"));
    for(var item in shoppingList){
      totalPrice+=item['price']*item['quantity'];
    }
    setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readCartData();
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: widget.in_home?
      AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Your Orders",
          style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w500
          ),),
        centerTitle: true,
      )
          :AppBar(
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
                onPressed: (){

                },
                icon: const Icon(Icons.keyboard_backspace,color: Colors.black,size: 30,),
              ),
            ),
            const Spacer(),
            const Text("Your Orders",
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
                          builder: (context) => HomePage(mail: widget.email,))
                  );
                },
                icon: const Icon(Icons.home,color: Colors.black,size: 30,),
              ),
            ),
          ],
        ),
      ),
      body: (shoppingList.length == 0) ?
      const Center(child:
      Text("Your cart Is Empty",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25),)
      )
          :ListView.builder(
        itemCount: shoppingList.length+1,
        itemBuilder: (context, index) {
          if(index == shoppingList.length) {
            return Column(
              children: [
                const Divider(thickness: 2,color: Colors.black),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      const Text("Total Price:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text("\$ $totalPrice ",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50,),
                ElevatedButton(
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    minimumSize:Size(screenWidth-200, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text("Check Out",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                const SizedBox(height: 50,)
              ],
            );
          }
          else{
            return Padding(padding: const EdgeInsets.only(top: 20,bottom: 10,left: 15,right: 15),
                child: Container(
                  height: 170,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(0xfff8f8f8),
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0xffe0dcdc),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0,7)
                        )
                      ]
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 170,
                        width: 150,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(shoppingList[index]["image_link"],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 12,),
                              Text(shoppingList[index]["title"],

                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(),
                              Text("\$ ${shoppingList[index]["price"]*shoppingList[index]["quantity"]} ",
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                              const SizedBox(height: 30,)

                            ],
                          )
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(onPressed: ()async{
                            await sql.myDelete("USER_CART", "id = ${shoppingList[index]['id']}");
                            totalPrice -= (shoppingList[index]['price']*shoppingList[index]['quantity']);
                            shoppingList.remove(shoppingList[index]);
                            setState(() {});
                          },
                            icon: const Icon(Icons.cancel_outlined,
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black)
                            ),
                            child: Row(
                              children: [
                                IconButton(onPressed: (){
                                  setState(() {
                                    if(shoppingList[index]['quantity'] > 1) shoppingList[index]['quantity']--;
                                  });
                                },
                                  icon: const Icon(Icons.remove,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                                Text("${shoppingList[index]['quantity']}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(onPressed: (){},
                                  icon: const Icon(Icons.add,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 22,)
                        ],
                      ),
                      const SizedBox(width: 8,)
                    ],
                  ),
                )
            );
          }
        },
      ),
    );
  }
}
