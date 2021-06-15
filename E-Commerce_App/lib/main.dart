import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/screens/account_navbar.dart';
import 'package:first_project/screens/home_screen.dart';
import 'package:first_project/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class Authenticate extends StatefulWidget{

  const Authenticate({Key? key}) : super(key: key);
  @override
  _AuthenticateState createState() => _AuthenticateState();
}


class _AuthenticateState extends State<Authenticate>{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool signed = false;
  User? user;
  String? user_email = "test";
  void initState(){
    user = _firebaseAuth.currentUser;
    if(user != null){
      signed = true;
    }
    super.initState();
  }

  void logOut() {
    _firebaseAuth.signOut().then((value) => {
      setState(() {
        user = _firebaseAuth.currentUser;
        signed = false;
      })
    });
    
  }

  void logUp(){
    AuthenticationService(_firebaseAuth).signUp(
      email: emailController.text.trim(), 
      password: passwordController.text.trim()).then((e) => {
        setState(() {
          user = _firebaseAuth.currentUser;
          if(user != null){
            signed = true;
          }
        })
      });
  }

  void logIn(){
    AuthenticationService(_firebaseAuth).signIn(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    ).then((e) => {
      setState(() {
        user = _firebaseAuth.currentUser;
        if(user != null){
          signed = true;
        }
      })
    });
    
    setState(() {
      user = _firebaseAuth.currentUser;
      if(user != null){
        signed = true;
      }
    });
  }

  @override 
  Widget build(BuildContext context){
    if(signed){
      if(_firebaseAuth.currentUser != null){
        user_email = _firebaseAuth.currentUser!.email;
      }
    }
    if(signed == false){
      return Scaffold(
        body: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Password",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                logIn();
              },
              child: Text("Sign in"),
            ),
            ElevatedButton(
              onPressed: () {
                logUp();
              },
              child: Text("Sign up"),
            )
          ],
        ),
      );
    }
      return Scaffold(
        body: Container(
          child: Center(
            child: Column(
              children: [
                Text("Signed in as " + user_email!),
                ElevatedButton(
                  child: Text("Se déconnecter"),
                  onPressed: () => {logOut()},
                ),
              ]
            ,)
          ,)
        ,)
      );
  } 
}
