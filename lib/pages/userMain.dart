import 'package:firebase/pages/login.dart';
import 'package:firebase/pages/profile.dart';
import 'package:firebase/pages/ChangePassword.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dashboard.dart';

class UserMain extends StatefulWidget {
  const UserMain({Key? key}) : super(key: key);

  @override
  State<UserMain> createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {

  int _selectedIndex = 0;

  static Set<Widget> _widgetOptions = <Widget>{
    Dashboard(),
    Profile(),
    ChangePassword(),
  };

  void _onTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Welcome'),
        actions: [
          PopupMenuButton(
            color:  Color(0xff9546C4),
            icon: Icon(Icons.more_vert_outlined),
              itemBuilder: (context)=>[
                PopupMenuItem(
                    child: TextButton(
                        onPressed: () async{
                          await FirebaseAuth.instance.signOut();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.green,
                                  content: Text("Successfully logged Out",
                                    textAlign: TextAlign.center,)
                              )
                          );
                        },
                        child: Text('Logout', style: TextStyle(color: Colors.white),)),
                )
              ]
          ),


        ],
      ),
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
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        backgroundColor: Color(0xff9546C4),
        currentIndex: _selectedIndex,
        onTap: _onTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home,color: Colors.white,),
              label: 'Dashboard'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person,color: Colors.white),
              label: 'Profile'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings,color: Colors.white),
              label: 'Settings'
          ),
        ],
      ),

    );
  }
}
