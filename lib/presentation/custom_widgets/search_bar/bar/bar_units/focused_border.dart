import 'package:flutter/material.dart';
import '../../../../../common/app_theme/colors_second.dart';

OutlineInputBorder focusedBorder(BuildContext context) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      width: 2.0,
      color: Theme.of(context).colorScheme.secondary,
    ),
  );
}
