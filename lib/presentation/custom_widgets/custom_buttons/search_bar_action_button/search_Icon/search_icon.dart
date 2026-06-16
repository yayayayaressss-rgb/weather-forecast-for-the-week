import 'package:flutter/material.dart';

IconButton searchIcon(VoidCallback action) {
  return IconButton(onPressed: action, icon: Icon(Icons.search));
}
