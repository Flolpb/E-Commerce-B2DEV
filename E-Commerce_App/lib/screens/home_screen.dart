import 'package:first_project/screens/profile_screen.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  int _inc = 0;

  @override
  void initState(){
    super.initState();
    setState(() {
      _inc = 10;
    });
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        child: GestureDetector(
          child: Center(
            child: Container(
              child: Column( 
                children: [
                  SizedBox(
                    child: ElevatedButton(
                      
                      onPressed: () => setState(() => _inc++),
                      child: Text("Coucou"),
                    ),
                  ),
                  Text("Nombre de click: $_inc"),
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => ProfileScreen()),
                          (route) => false,
                        ),
                      child: Text("Coucou"),
                    ),
                  )
              ],
              )  
            )
           
            
          ),
        ),
      )
    );

  }

}
