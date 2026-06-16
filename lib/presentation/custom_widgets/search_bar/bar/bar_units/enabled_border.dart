import 'package:flutter/material.dart';

OutlineInputBorder enabledBorder(BuildContext context) {
  return OutlineInputBorder(
    borderSide: BorderSide(width: 1.7, color: Theme.of(context).primaryColor),
  );
}
