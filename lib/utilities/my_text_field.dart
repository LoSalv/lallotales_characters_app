import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextFieldWithLabel extends StatelessWidget {
  const MyTextFieldWithLabel({
    this.initialValue,
    this.label,
    this.labelWeight,
    this.inputType,
    this.textAlign,
    this.onChanged,
    this.padding,
    this.showError = false,
    this.errorText,
    this.onSubmitted,
  });

  final String initialValue;
  final String label;
  final EdgeInsetsGeometry padding;
  final FontWeight labelWeight;
  final TextInputType inputType;
  final TextAlign textAlign;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final bool showError;
  final String errorText;

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).disabledColor,
      ),
      borderRadius: BorderRadius.circular(15),
    );

    final OutlineInputBorder errBorder = OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.red,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(15),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: TextField(
        onChanged: onChanged ?? (String value) {},
        onSubmitted: onSubmitted ?? (String value) {},
        controller: TextEditingController(text: initialValue),
        textAlign: textAlign ?? TextAlign.left,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
          // filled: true,
          // fillColor: Theme.of(context).accentColor,
          // focusColor: Theme.of(context).accentColor,
          errorText: showError ? errorText : null,
          errorBorder: errBorder,
          focusedErrorBorder: errBorder,
          contentPadding: padding ?? const EdgeInsets.fromLTRB(20, 30, 20, 0),
          isDense: true,
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: border,
          focusedBorder: border,
          labelStyle: TextStyle(
            fontSize: 20,
            color: showError ? Colors.red : Theme.of(context).accentColor,
            fontWeight: labelWeight ?? FontWeight.normal,
          ),
        ),
        keyboardType: inputType ?? TextInputType.multiline,
        maxLines: null,
      ),
    );
  }
}

class MyTextFieldWithPrefix extends StatelessWidget {
  const MyTextFieldWithPrefix(
      {this.initialValue, this.prefix, this.inputType, this.center = false});

  final String initialValue;
  final String prefix;
  final TextInputType inputType;
  final bool center;

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).accentColor,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(25.0),
    );

    return TextField(
      controller: TextEditingController(text: initialValue),
      textAlign: center ? TextAlign.center : TextAlign.left,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
          child: Text(
            prefix,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.blue,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        prefixIconConstraints: const BoxConstraints(),
        enabledBorder: border,
        focusedBorder: border,
      ),
      keyboardType: inputType ?? TextInputType.name,
    );
  }
}
