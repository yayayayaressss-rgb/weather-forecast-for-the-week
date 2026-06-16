import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'unit_interface.dart';

ListTile metrics({required BuildContext context}) {
  const String txt = 'Единицы измерения';
  final Icon icon = Icon(
    Icons.straighten,
    color: Theme.of(context).iconTheme.color,
  );
  return tileUnitInterface(
    context: context,
    title: txt,
    icon: icon,
    action: () {
      context.go('/metric');
    },
  );
}
