import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomtextFormField extends StatelessWidget {
  CustomtextFormField(
      {super.key,
      this.obscureText = false,
       this.onChanged, 
       this.hintText});
  String? hintText;
  bool obscureText;
  Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: (data) {
        if (data!.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      onChanged: onChanged,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
