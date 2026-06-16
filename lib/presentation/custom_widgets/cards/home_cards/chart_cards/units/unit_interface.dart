import 'package:flutter/material.dart';

Widget unitInterface({required Widget child}) {
  BoxDecoration decoration = BoxDecoration(
    borderRadius: BorderRadius.circular(8.0),
    color: Colors.grey.withOpacity(0.3),
  );
  return Expanded(
    child: Container(
      padding: EdgeInsetsGeometry.all(10.0),
      decoration: decoration,
      child: child,
    ),
  );
}
