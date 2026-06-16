import 'package:flutter/material.dart';

class DefaultIcon extends StatelessWidget {
  final VoidCallback action;

  const DefaultIcon({required this.action, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: action,
      icon: Icon(
        Icons.location_on,
        color: Theme.of(context).appBarTheme.foregroundColor,
      ),
    );
  }
}
