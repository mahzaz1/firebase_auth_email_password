
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class TextForm extends StatelessWidget {
  const TextForm({Key? key,
    required this.controller,
    required this.labelText, required this.icon,
    required this.validator,
    this.obscureText = false,
    this.autofocus, this.keyboardType,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final Icon icon;
  final String? Function(String?)? validator;
  final bool obscureText ;
  final bool? autofocus;
  final TextInputType? keyboardType;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
          style:  TextStyle(color: Colors.white),
        obscureText: obscureText,
        keyboardType: keyboardType,
        controller: controller,
        autofocus: false,
        decoration: InputDecoration(
            labelText: labelText,
            suffixIcon: icon),
        validator: validator
      ),
    );
  }
}
