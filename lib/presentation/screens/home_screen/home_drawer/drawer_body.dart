import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:forecast_app_pet_proj/presentation/screens/home_screen/home_drawer/units/menu_body_units/favorites_dir_row.dart';
import 'package:forecast_app_pet_proj/presentation/screens/home_screen/home_drawer/units/menu_body_units/metric_settings_dir_row.dart';
import 'package:forecast_app_pet_proj/presentation/screens/home_screen/home_drawer/units/menu_body_units/theme_settings_dir_row.dart';
import 'drawer_title.dart';

Drawer drawer({
  required BuildContext context,
  required GlobalKey<ScaffoldState> key,
}) {
  return Drawer(
    backgroundColor: Theme.of(context).cardTheme.color,
    child: ListView(
      padding: EdgeInsets.zero,
      dragStartBehavior: DragStartBehavior.down,
      children: [
        drawerTitle(context: context, key: key),
        Column(
          children: [
            theme(context: context),
            favorites(context: context, key: key),
            metrics(context: context),
          ],
        ),
      ],
    ),
  );
}
