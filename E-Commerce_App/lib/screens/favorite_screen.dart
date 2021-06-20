
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/screens/accueil_screen.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>{
  
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  
  final LocalStorage storage = new LocalStorage('eco-app');
  DocList articles = new DocList();
  DocList articlesBasket = new DocList();


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

  _addItemBasket(DocItem doc) {
      
      setState(() {
        articlesBasket.items.add(doc);
        print('new in the basket: ' + doc.name);
        _saveToStorageBasket();
      });
    }

    _saveToStorageBasket() {
      storage.setItem('basket', articlesBasket.toJSONEncodable());
    }

    deleteData(doc){
      articles.items.remove(doc);
      _saveToStorage();
    }

    
    _saveToStorage() {
      storage.setItem('favoris', articles.toJSONEncodable());
    }


  List<Widget> makeListWidget(articles){
    String desc;
    List<Widget> widgets = [];
    articles.items.forEach((doc) {
      if(doc.desc.length > 20){
        desc = doc.desc.substring(0,20);
        desc += "...";
      }else{
        desc = doc.desc;
      }
      widgets.add(Container(
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(doc.img),
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
                  Text(doc.name),
                  Text(doc.prix),
                  Text(desc, style: TextStyle(fontSize: 12),),
                ]
              )
            ),
            Spacer(),
            Container(
              child: Column(
                children: [
                  IconButton(onPressed: () => _addItemBasket(doc), icon: const Icon(Icons.shopping_basket_rounded)),
                  IconButton(onPressed: () => deleteData(doc), icon: const Icon(Icons.delete), color: Colors.black),
                ]
              )
            )
          ]
        )
      ));
    });
    return widgets;
  }

  @override 
  Widget build(BuildContext context){
    getData();
    if(articles.items.length < 1){
      return Text("Vous n'avez pas de favoris");
    }
    return new ListView(
      children: makeListWidget(articles)
      );
  }
}