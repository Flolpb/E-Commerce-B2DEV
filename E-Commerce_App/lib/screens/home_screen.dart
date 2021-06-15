
import 'package:first_project/main.dart';
import 'package:first_project/screens/accueil_screen.dart';
import 'package:first_project/screens/favorite_screen.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;


  @override
  void dispose(){
    super.dispose();
  }

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<Widget> _widgetOptions = <Widget>[
    ArticleInformation(),
    FavoriteScreen(),
    Text(
      'Index 2: Shop',
      style: optionStyle,
    ),
    Authenticate()
  ];

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      title: "E-Commerce",
      home: Scaffold(
        appBar: AppBar(
          title: Row(children: [
            Text("E-Commerce B2DEV"),
            Spacer(),
            IconButton(onPressed: () => print("test"), icon: const Icon(Icons.search)),
            IconButton(onPressed: () => print("test"), icon: const Icon(Icons.shopping_basket)),
          ],
          
          
          )
          )
        ,
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favoris',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shop),
              label: 'Shop',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Compte',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      )
    );

  }

}
