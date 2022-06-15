import 'package:flutter/material.dart';

Widget input(Icon icon, String hint, TextEditingController controller, bool obscure){
  return Container(
    padding: EdgeInsets.only(left: 20, right: 20),
    child: TextField(
      controller: controller,
      obscureText: obscure,
      style: TextStyle(fontSize: 20, color: Colors.black,),
      decoration: InputDecoration(
          fillColor: Color.fromRGBO(144, 188, 218, 1.0),
          filled: true,
          hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87),
          hintText: hint,
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 3,
              )
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black54,
                width: 1,
              )
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: IconTheme(
              data: IconThemeData(
                color: Colors.black,
              ),
              child: icon,
            ),
          )
      ),
    ),
  );
}