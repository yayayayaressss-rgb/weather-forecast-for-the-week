import 'package:flutter/material.dart';
import '../../../../../common/app_theme/colors_second.dart';

OutlineInputBorder focusedErrorBorder(BuildContext context) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(
      width: 2.0,
      color: Theme.of(context).colorScheme.error,
    ),
  );
}
