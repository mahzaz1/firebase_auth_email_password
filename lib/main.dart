import 'package:firebase/pages/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    return FutureBuilder(
      future: _initialization,
        builder: (context, snapshot) {

        if(snapshot.connectionState == ConnectionState.done){
          return MaterialApp(

              theme: ThemeData(
                fontFamily: 'Montserrat',
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color(0xff5E61F4),
                    ),
                  )
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: Color(0xff5E61F4),
              ),
                textTheme: TextTheme(
                  bodyText1: TextStyle(color: Colors.white),
                  bodyText2: TextStyle(color: Colors.white),
                ),
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                errorStyle: TextStyle(color: Colors.orange),
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20)),
                fillColor: Colors.white10,
                filled: true
              ),
            ),
              debugShowCheckedModeBanner: false,
              home:SplashScreen()
              // FirebaseAuth.instance.currentUser == null ?  Login() : UserMain()
          );
        }
        return Center(child: CircularProgressIndicator(color: Color(0xffCB2B93),));
      }


    );
  }
}
