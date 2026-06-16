import 'package:flutter/material.dart';
import '../../custom_widgets/custom_buttons/home_app_bar_buttons/leading_icon/get_by_geo_button.dart';
import '../../custom_widgets/custom_buttons/home_app_bar_buttons/trailing_icon/menu_icon.dart';

PreferredSizeWidget homeAppBar({
  required BuildContext context,
  required GlobalKey<ScaffoldState> key,
  required bool isMetric,
}) {
  return AppBar(
    elevation: 4,
    backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
    centerTitle: true,
    leading: GetByGeoButton(isMetric: isMetric),
    title: _textTitle(context),
    actions: [
      MyMenuIcon(
        action: () {
          key.currentState?.openEndDrawer();
        },
      ),
    ],
  );
}

Text _textTitle(BuildContext context) {
  final textStyle = TextStyle(
    color: Theme.of(context).appBarTheme.foregroundColor,
    fontSize: 26,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.05,
  );
  return Text(style: textStyle, 'Прогноз Погоды');
}
