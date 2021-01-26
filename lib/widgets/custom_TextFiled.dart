import 'package:flutter/material.dart';
import '../constans.dart';

class CustomTextFiled extends StatelessWidget {
  final  IconData icon;
  final  String hint;
  final Function save;
  CustomTextFiled({ this.hint, this.icon, this.save}) ;

  String _erroMessage(String str){
    switch(str){
      case"Enter your name":return"Name is empty";
      case"Enter your email":return"Email is empty";
      case"Enter your password":return"Password is empty";
    }
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val){
        if(val.isEmpty){
          return _erroMessage(hint);
        // ignore: missing_return
        }

      },
      onSaved: save,
      obscureText: hint == "Enter your password"?true:false,
      cursorColor: kMainColor,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.white),
        ),
        fillColor: kSecondaryColor,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.white),
        ),
        border:OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.white),
        ),
        hintText: hint,
        prefixIcon: Icon(icon,color: kMainColor,),
      ),
    );
  }
}
