
import 'package:animator/animator.dart';
import 'package:first_project/main.dart';
import 'package:first_project/screens/accueil_screen.dart';
import 'package:first_project/screens/basket_screen.dart';
import 'package:first_project/screens/favorite_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedIndex = 0;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<Widget> _widgetOptions = <Widget>[
    ArticleInformation(),
    FavoriteScreen(),
    BasketScreen(),
    Authenticate()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      title: "E-Commerce",
      home: Scaffold(
        appBar: AppBar(
          title: Row(children: [
            Text("E-Commerce B2DEV"),
            AnimatedLogo(),
            Spacer(),
            IconButton(onPressed: () => print("test"), icon: const Icon(Icons.search)),
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
              icon: Icon(Icons.shopping_cart),
              label: 'Panier',
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

class AnimatedLogo extends StatelessWidget{
  Widget build(BuildContext context){
    return Animator<double>(
        tween: Tween<double>(begin: 0, end: 50),
        duration: Duration(seconds: 4),
        cycles: 0,
        builder: (context, animatorState, child) => Center(
          child: Container(
            child: Opacity(
              opacity: animatorState.value / 100,
              child: FlutterLogo(),
            ),
          ),
        ),
      );
  }
}