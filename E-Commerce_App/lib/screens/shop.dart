import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ShopState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(),
      body: Container(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              child: Icon(
                Icons.shopping_cart,
                color: Colors.grey[800],
                size: 40,
              ),
            ),
            Container(
              height: size.height * 1,
              width: size.width * 1,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/shoes.jpg"))),
            ),
            Container(
                // Area product
                height: size.height * 0.35,
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                )),
            Positioned(
              // Description product
              bottom: 160,
              child: Align(
                alignment: Alignment.bottomRight,
                child: new Text(
                  "Description du produit ndbhsvbshsdjvbhdbcjhdbvhj",
                  style: TextStyle(fontSize: 22, color: Colors.black),
                ),
              ),
            ),
            Positioned(
              // Button buy now
              bottom: 30,
              right: 40,
              child: Container(
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.grey.shade800),
                  ),
                  onPressed: () {},
                  child: Text(
                    "BUY NOW",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
            ),
            Positioned(
              // grey bar
              bottom: 200,
              child: Container(
                height: 10,
                width: 200,
                color: Colors.grey[800],
              ),
            ),
            Positioned(
              // icon add to pannier
              bottom: 30,
              left: 50,
              child: Container(
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.grey[800],
                  size: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
