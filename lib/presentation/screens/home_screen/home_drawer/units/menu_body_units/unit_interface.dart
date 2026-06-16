import 'package:flutter/material.dart';

ListTile tileUnitInterface({
  required BuildContext context,
  required String title,
  required Widget icon,
  required VoidCallback action,
}) {
  final TextStyle txtStyle = TextStyle(
    color: Theme.of(context).textTheme.bodyLarge?.color,
    fontSize: 18.0,
    fontWeight: FontWeight(350),
  );
  const EdgeInsets contentPadding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 5.0,
  );
  const EdgeInsetsGeometry trailingPadding = EdgeInsetsGeometry.only(
    right: 12.0,
  );
  final Widget titleWidget = Align(
    alignment: Alignment.centerLeft,
    child: Text(title, style: txtStyle),
  );
  return ListTile(
    visualDensity: VisualDensity.compact,
    onTap: () {
      action();
    },
    contentPadding: contentPadding,
    title: titleWidget,
    trailing: Padding(padding: trailingPadding, child: icon),
  );
}
