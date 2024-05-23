import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {

  final void Function() onPressed;
  final String text;

  const CustomMaterialButton({required this.onPressed, required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(30.0),
        ),
        width: double.infinity,
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
