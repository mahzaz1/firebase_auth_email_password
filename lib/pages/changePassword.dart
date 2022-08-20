import 'package:firebase/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/textForm.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  final _formKey = GlobalKey<FormState>();

  var newPassword = '';

  final newPasswordController = TextEditingController();

  void dispose(){
    newPasswordController.dispose();
    super.dispose();
  }

  final currentUser = FirebaseAuth.instance.currentUser;

  changePassword() async{

    try{
      await currentUser!.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              content: Text("Password Changed Successfully",
                textAlign: TextAlign.center,)
          )
      );

    Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));

    }catch(e){}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
            child: Column(
              children: [
                TextForm(
                  keyboardType: TextInputType.visiblePassword,
                  autofocus: false,
                  obscureText: true,
                  icon: Icon(Icons.remove_red_eye_rounded,color: Colors.white),
                  labelText: 'Password',
                  controller: newPasswordController,
                  validator: (value){

                    if(value == null || value.isEmpty ) {
                      return 'Please Enter password';
                    }
                    return null;

                  },
                ),

                ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        setState(() {
                          newPassword = newPasswordController.text;
                        });
                        changePassword();
                      }
                    },
                    child: Text('Change Password')),
              ],
            )),
      ),
    );
  }
}
