import 'package:firebase/pages/signUp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../components/textForm.dart';
import 'login.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

  final _formKey = GlobalKey<FormState>();

  var email = '';

  var emailController = TextEditingController();

  void dispose(){
    emailController.dispose();
    super.dispose();
  }

  resetPassword() async{
    try{

      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

        Fluttertoast.showToast(msg: 'Email has been sent!',backgroundColor: Colors.white54,textColor: Colors.black);

      Navigator.of(context).pop();


    }on FirebaseAuthException catch(e){
        Fluttertoast.showToast(msg: e.toString(),backgroundColor: Colors.white54,textColor: Colors.black);
      if(e.code == 'user-not-found'){


        Fluttertoast.showToast(msg: 'User Not Found',backgroundColor: Colors.white54,textColor: Colors.black);
      }
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
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
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Reset link will be sent your email id',textAlign: TextAlign.center,textScaleFactor: 1.9,),
                  SizedBox(height: 10,),

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


                  SizedBox(height: 10,),

                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: (){
                          if(_formKey.currentState!.validate()){
                            setState(() {
                              email = emailController.text;
                            });
                            resetPassword();
                          }
                        },
                        child: Text('Send Email')),
                  ),
                  SizedBox(height: 10,),
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
                  ),
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
        ),
      ),
    );
  }
}
