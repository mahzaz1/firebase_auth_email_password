import 'package:firebase/pages/forgetPassword.dart';
import 'package:firebase/pages/signUp.dart';
import 'package:firebase/pages/userMain.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../components/textForm.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();

  var email = '';
  var password = '';

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void dispose(){
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
  
  userLogin() async{

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

    Navigator.push(context, MaterialPageRoute(builder: (context)=>UserMain()));


      // Fluttertoast.showToast(msg: "Successfully logged In",backgroundColor: Colors.white54,textColor: Colors.black);

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              content: Text("Successfully logged In",
                textAlign: TextAlign.center,)
          )
      );



    }on  FirebaseAuthException catch (e){


      if(e.code == 'user-not-found'){
        Fluttertoast.showToast(msg: "User Not Found",backgroundColor: Colors.white54,textColor: Colors.black);
      }
      if(e.code == 'invalid-email'){
        Fluttertoast.showToast(msg: "Invalid Email",backgroundColor: Colors.white54,textColor: Colors.black);
      }
      if(e.code == 'wrong-password'){
        Fluttertoast.showToast(msg: "Wrong Password",backgroundColor: Colors.white54,textColor: Colors.black);
      }
      else{
        Fluttertoast.showToast(msg: "Something went Wrong",backgroundColor: Colors.white54,textColor: Colors.black);

      }

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Login Here',style: TextStyle(fontWeight: FontWeight.bold,),),
        actions: [
          PopupMenuButton(
              color:  Color(0xff9546C4),
              icon: Icon(Icons.more_vert_outlined),
              itemBuilder: (context)=>[
                PopupMenuItem(
                  child: TextButton(
                      onPressed: () async{
                        await FirebaseAuth.instance.signOut();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>UserMain()));
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.green,
                                content: Text("logged In Without Account",
                                  textAlign: TextAlign.center,)
                            )
                        );
                      },
                      child: Text('Dashboard', style: TextStyle(color: Colors.white),)),
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
        child: Column(
          children: [
            Lottie.asset('assets/lottie/51084-contract-signing.json',width: 200),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    TextForm(
                      autofocus: false,
                      keyboardType: TextInputType.emailAddress,
                      icon: Icon(Icons.email,color: Colors.white),
                      labelText: 'Email',
                      controller: emailController,
                      validator: (value){

                        if(value == null || value.isEmpty ){
                          return 'Please Enter Email';

                        }else if(!value.contains('@')){
                          return 'Please Enter Valid Email';
                        }

                        else{
                          return null;
                        }
                      },
                    ),
                    TextForm(
                      keyboardType: TextInputType.visiblePassword,
                      autofocus: false,
                      obscureText: true,
                      icon: Icon(Icons.lock,color: Colors.white),
                      labelText: 'Password',
                      controller: passwordController,
                      validator: (value){

                        if(value == null || value.isEmpty ) {
                          return 'Please Enter password';
                        }
                        return null;

                      },
                    ),

                    Container(
                      width: double.infinity,
                      child: ElevatedButton(

                          onPressed: (){
                            if(_formKey.currentState!.validate()){
                            setState(() {
                              email = emailController.text;
                              password = passwordController.text;
                            });
                            userLogin();
                            }
                          },
                          child: Text('Login')),
                    ),

                    TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPassword()));

                        },
                        child: Text('Forget Password')),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?"),
                        TextButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));

                            },
                            child: Text('SignUp')),
                      ],
                    )

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
