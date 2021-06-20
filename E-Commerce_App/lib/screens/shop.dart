import 'package:flutter/material.dart';

class Shop extends StatelessWidget {

  late String url;
  late String name;
  late String description;
  late String prix;

  Shop(String url, String name, String description, String prix){
    this.url = url;
    this.name = name;
    this.description = description;
    this.prix = prix;

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                    image: NetworkImage(this.url))
                  ),
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
                child: new Column(
                  children: [
                    Text(
                  this.name,
                  style: TextStyle(fontSize: 22, color: Colors.black),),
                    Text(
                  this.description,
                  style: TextStyle(fontSize: 12, color: Colors.black),),
                  ElevatedButton(child: Text("Retour"), onPressed: (){Navigator.pop(context);},)
                  ],
                )
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
