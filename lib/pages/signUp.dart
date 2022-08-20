import 'package:firebase/pages/login.dart';
import 'package:firebase/pages/userMain.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../components/textForm.dart';
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _formKey = GlobalKey<FormState>();

  var email = '';
  var password = '';
  var confirmPassword = '';

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  registration() async{
    if(password == confirmPassword){
      try{

        UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        print(userCredential);

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserMain()));

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
                content: Text("Registered Successfully",
                  textAlign: TextAlign.center,)
            )
        );

        // Fluttertoast.showToast(msg: 'Registered Successfully',backgroundColor: Colors.white54,textColor: Colors.black);


      }on FirebaseAuthException catch(e){

        if(e.code == 'weak-password'){

          Fluttertoast.showToast(msg: 'Weak password',backgroundColor: Colors.white54,textColor: Colors.black);
        }

        if(e.code == 'email-already-in-use'){
          Fluttertoast.showToast(msg: 'Email Already in Use',backgroundColor: Colors.white54,textColor: Colors.black);

        }

      }
    }
    else{
      Fluttertoast.showToast(msg: "Passwords doesn't match",backgroundColor: Colors.white54,textColor: Colors.black);
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('SignUp Here',style: TextStyle(fontWeight: FontWeight.bold)),
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
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextForm(
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
                      TextForm(
                        keyboardType: TextInputType.visiblePassword,
                        autofocus: false,
                        obscureText: true,
                        icon: Icon(Icons.lock,color: Colors.white),
                        labelText: 'Confirm Password',
                        controller: confirmPasswordController,
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
                                  confirmPassword = confirmPasswordController.text;
                                });

                                registration();
                              }
                            },
                            child: Text('SignUp')),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?"),

                          TextButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                              },
                              child: Text('Login')),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
