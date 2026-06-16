import 'package:flutter/material.dart';

Widget drawerTitle({
  required BuildContext context,
  required GlobalKey<ScaffoldState> key,
}) {
  final TextStyle txtStyle = TextStyle(
    color: Theme.of(context).appBarTheme.foregroundColor,
    fontSize: 26,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.05,
  );
  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).appBarTheme.backgroundColor,
    ),
    child: Padding(
      padding: EdgeInsetsGeometry.only(top: 39.2, bottom: 4.8),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.only(left: 8.0),
            child: IconButton(
              onPressed: () {
                key.currentState?.closeEndDrawer();
              },
              icon: Icon(
                Icons.clear,
                fontWeight: FontWeight(700),
                size: 30.0,
                color: Theme.of(context).appBarTheme.foregroundColor,
              ),
            ),
          ),
          SizedBox(width: 18.0),
          Text('Меню', style: txtStyle),
        ],
      ),
    ),
  );
}
