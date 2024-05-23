import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget{
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String label;
  Widget? prefixIcon;
  Widget? suffixIcon;
  String? Function(String?)? validator;

  CustomTextFormField({
    required this.controller,
    required this.keyboardType,
    this.obscureText = false,
    required this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(fontSize: 20.0, color: Colors.white,),
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white,),
        prefixIcon: const Icon(
          Icons.lock,
          color: Colors.white,
        ),
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              width: 2.0,
              color: Colors.white,
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              width: 3.0,
              color: Colors.blue,
            )
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              width: 3.0,
              color: Colors.red,
            )
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              width: 3.0,
              color: Colors.red,
            )
        ),
      ),
      validator: validator,
    );
  }

}