import 'package:flutter/material.dart';

InputDecoration textFieldDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    // labelText: "Resevior Name",
    fillColor: Colors.white,
    focusedBorder: textFieldBorder(Colors.blue),
    enabledBorder: textFieldBorder(Colors.black12),
    errorBorder: textFieldBorder(Colors.red),
    focusedErrorBorder:  textFieldBorder(Colors.red),
    
  );
}

OutlineInputBorder textFieldBorder(Color providedColor) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: providedColor, width: 2.0),
    borderRadius: BorderRadius.circular(7.0),
  );
}
