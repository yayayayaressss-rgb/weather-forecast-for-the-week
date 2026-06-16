import 'package:flutter/material.dart';

OutlineInputBorder errorBorder(BuildContext context) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      width: 1.7,
      color: Theme.of(context).colorScheme.error,
    ),
  );
}
