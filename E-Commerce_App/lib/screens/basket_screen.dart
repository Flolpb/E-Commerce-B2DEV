
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/screens/accueil_screen.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class BasketScreen extends StatefulWidget{
  const BasketScreen({Key? key}) : super(key: key);

  @override 
  _BasketScreenState createState() => _BasketScreenState();

}

class _BasketScreenState extends State<BasketScreen>{
  
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  double prix = 0;
  
  final LocalStorage storage = new LocalStorage('eco-app');
  DocList articles = new DocList();

  void getData() async{
    setState(() {
      var items = storage.getItem('basket') ?? [];
      
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
      }
    });
  }

  
    deleteData(doc){
      articles.items.remove(doc);
      _saveToStorage();
    }

  
    _saveToStorage() {
      storage.setItem('basket', articles.toJSONEncodable());
    }

  List<Widget> makeListWidget(articles){
    String desc;
    List<Widget> widgets = [];
    double prix = 0;
    articles.items.forEach((doc) {
      var _prix = doc.prix.substring(0, doc.prix.length-1);
      prix += double.parse(_prix);
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
                  IconButton(onPressed: () => deleteData(doc), icon: const Icon(Icons.delete), color: Colors.black),
                ]
              )
            )
          ]
        )
      ));
    });
    widgets.add(Spacer());
    widgets.add(Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text("Prix total de votre panier: $prix €", style: TextStyle(fontSize: 18))]
    ));
    return widgets;
  }

  @override 
  Widget build(BuildContext context){
    getData();
    if(articles.items.length < 1){
      return Text("Vous n'avez pas de favoris");
    }
    return new ListView(
      children: makeListWidget(articles),
    );
  }
}