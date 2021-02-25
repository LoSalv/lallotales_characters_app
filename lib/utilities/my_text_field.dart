import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  MyTextField(
      {this.initialValue,
      this.label,
      this.labelWeight,
      this.inputType,
      this.center = false});

  final String initialValue;
  final String label;
  final FontWeight labelWeight;
  final TextInputType inputType;
  final bool center;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(text: initialValue),
      textAlign: center ? TextAlign.center : TextAlign.left,
      decoration: new InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 18,
          fontWeight: labelWeight != null ? labelWeight : FontWeight.normal,
        ),
      ),
      keyboardType: inputType != null ? inputType : TextInputType.name,
    );
  }
}
