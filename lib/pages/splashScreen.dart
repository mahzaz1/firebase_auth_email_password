import 'dart:async';

import 'package:firebase/pages/userMain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState(){
    super.initState();

    Timer(Duration(seconds: 1),(){
      Navigator.push(context,
          MaterialPageRoute(builder: (context)=>
          FirebaseAuth.instance.currentUser == null ?  Login() : UserMain()));

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xffCB2B93),
              Color(0xff9546C4),
              Color(0xff5E61F4),
            ],
          ),
        ),
        child: Center(
          child: Text(
            'hello',
            style: TextStyle(
                fontFamily: 'Pacifico',
                color: Colors.white,
                fontSize: 95,
                letterSpacing: 5
            ),
          ),
        ),
      ),
    );

  }
}


