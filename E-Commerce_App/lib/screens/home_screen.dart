
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState(){
    super.initState();
    setState(() {
      _selectedIndex = 0;
    });
  }

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

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Accueil',
      style: optionStyle,
    ),
    Text(
      'Index 1: Favoris',
      style: optionStyle,
    ),
    Text(
      'Index 2: Shop',
      style: optionStyle,
    ),
    Text(
      'Index 3: Compte',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "E-Commerce",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("E-Commerce B2DEV")
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
