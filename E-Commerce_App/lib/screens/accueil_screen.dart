

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:localstorage/localstorage.dart';



class ArticleInformation extends StatefulWidget {
  @override
    _ArticleInformationState createState() => _ArticleInformationState();
}

class DocItem {
  String prix;
  String name;
  String desc;
  String img;

  DocItem({required this.prix, required this.name, required this.desc, required this.img});

  toJSONEncodable(){
    Map<String, dynamic> m = new Map();

    m['prix'] = prix;
    m['name'] = name;
    m['desc'] = desc;
    m['img'] = img;
    return m;
  }

}


class DocList {
  List<DocItem> items = [];

  toJSONEncodable() {
    return items.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }
}

class _ArticleInformationState extends State<ArticleInformation> {
  final Stream<QuerySnapshot> _articlesStream = FirebaseFirestore.instance.collection('articles').snapshots();
  final LocalStorage storage = new LocalStorage('eco-app');
  final DocList articles = new DocList();
  final DocList articlesBasket = new DocList();

  void getData() async{
      setState(() {
        var items = storage.getItem('favoris') ?? [];
        var itemsBaskets = storage.getItem('basket') ?? [];
        if (items != null) {
          articles.items = List<DocItem>.from(
            (items as List).map(
              (item) => DocItem(
                prix: item['prix'],
                name: item['name'],
                desc: item['desc'],
                img: item['img'],
              ),
            ),
          );
        }if (itemsBaskets != null) {
          articlesBasket.items = List<DocItem>.from(
            (itemsBaskets as List).map(
              (item) => DocItem(
                prix: item['prix'],
                name: item['name'],
                desc: item['desc'],
                img: item['img'],
              ),
            ),
          );
        }
      });
    }
    
    _addItem(DocumentSnapshot doc) {
      
      setState(() {
        final item = new DocItem(prix: doc['prix'], name: doc['name'], desc: doc['desc'], img: doc['img']);
        articles.items.add(item);
        _saveToStorage();
      });

    }
    
    Future<bool> _addItemBasket(DocumentSnapshot doc, bool isLiked) async {
      
      setState(() {
        final item = new DocItem(prix: doc['prix'], name: doc['name'], desc: doc['desc'], img: doc['img']);
        articlesBasket.items.add(item);
        print('new in the basket: ' + item.name);
        _saveToStorageBasket();
      });
      return !isLiked;
    }

    _saveToStorageBasket() {
      storage.setItem('basket', articlesBasket.toJSONEncodable());
    }

    _saveToStorage() {
      storage.setItem('favoris', articles.toJSONEncodable());
    }

    _clearStorage() async {
      await storage.clear();

      setState(() {
        articles.items = storage.getItem('todos') ?? [];
      });
    }

    Future<bool> onLikeButtonTapped(bool isLiked, DocumentSnapshot doc) async{
      _addItem(doc);
      return !isLiked;
    }



  List<Widget> makeListWidget(AsyncSnapshot snapshot){
    return snapshot.data.docs.map<Widget>((doc){
      String desc;
      if(doc['desc'].length > 20){
        desc = doc['desc'].substring(0,20);
        desc += "...";
      }else{
        desc = doc['desc'];
      }
      return Container(
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(doc['img']),
                  fit: BoxFit.cover,
                ),
              ),
              height: 80,
              width: 80,
              
            ),
            Spacer(),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${doc['name']} "),
                  Text("${doc['prix']}"),
                  Text("$desc", style: TextStyle(fontSize: 12),),
                ]
              )
            ),
            Spacer(),
            Container(
              child: Column(
                children: [
                  LikeButton(
                    onTap: (isLiked) {return _addItemBasket(doc, isLiked);},
                    likeBuilder: (bool isLiked) {
                     return Icon(
                        Icons.shopping_cart,
                        color: isLiked ? Colors.red : Colors.black,
                      );
                    },
                  ),
                  LikeButton(
                    onTap: (isLiked) {
                      return onLikeButtonTapped(isLiked, doc);
                    },
                    likeBuilder: (bool isLiked) {
                     return Icon(
                        Icons.favorite,
                        color: isLiked ? Colors.grey : Colors.red,
                      );
                    },
                  ),
                ]
              )
            )
          ]
        )
      ); 
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return StreamBuilder<QuerySnapshot>(
      stream: _articlesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return new ListView(
          children: makeListWidget(snapshot),
        );
      },
    );
  }
}