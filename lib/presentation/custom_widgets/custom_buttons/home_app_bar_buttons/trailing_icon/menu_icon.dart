import 'package:flutter/material.dart';

class MyMenuIcon extends StatelessWidget {
  final VoidCallback action;

  const MyMenuIcon({super.key, required this.action});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(left: 6.0),
      child: IconButton(
        icon: Icon(
          Icons.menu,
          color: Theme.of(context).appBarTheme.foregroundColor,
        ),
        onPressed: () {
          action();
        },
      ),
    );
  }
}
