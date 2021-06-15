

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetArticle extends StatelessWidget{
  
  final String documentId;

  GetArticle(this.documentId);

  @override
  Widget build(BuildContext context){
    CollectionReference articles = FirebaseFirestore.instance.collection('articles');
    return FutureBuilder<DocumentSnapshot>(
      future: articles.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Text("Name: ${data['name']} ${data['prix']}");
        }

        return Text("loading");
      }
    );
   
  }

}

class ArticleInformation extends StatefulWidget {
  @override
    _ArticleInformationState createState() => _ArticleInformationState();
}

class _ArticleInformationState extends State<ArticleInformation> {
  final Stream<QuerySnapshot> _articlesStream = FirebaseFirestore.instance.collection('articles').snapshots();

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
                  IconButton(onPressed: () => print("test"), icon: const Icon(Icons.shopping_basket)),
                  IconButton(onPressed: () => print("test"), icon: const Icon(Icons.favorite), color: Colors.red),
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