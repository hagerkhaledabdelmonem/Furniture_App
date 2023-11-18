import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../database/Sqflite.dart';

class Favorite extends StatefulWidget {
  String email;
  Favorite({required this.email, super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  Sqflite sql = Sqflite();
  List favoriteList = [];

  void readCartData()async{
    favoriteList.addAll(await sql.myRead("USER_FAVORITE"));
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
    return Scaffold(
      appBar:AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Favourite List",
          style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w500
          ),),
        centerTitle: true,
      ),
      body: (favoriteList.length == 0) ?
      const Center(child:
      Text("Your Favorite List  Is Empty",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25),)
      )
          :ListView.builder(
        itemCount: favoriteList.length,
        itemBuilder: (context, index) {
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
                      width: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(favoriteList[index]["image_link"],
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
                            Text(favoriteList[index]["title"],

                              style: const TextStyle(
                                fontSize: 12,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),
                            Text("\$ ${favoriteList[index]["price"]} ",
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                            const SizedBox(height: 30,)

                          ],
                        )
                    ),
                    const SizedBox(width: 8,)
                  ],
                ),
              )
          );
        },
      ),
    );
  }
}
