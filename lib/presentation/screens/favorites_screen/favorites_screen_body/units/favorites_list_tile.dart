import 'package:flutter/material.dart';
import '../../../../custom_widgets/custom_buttons/favorites_tile_actions_buttons/delete_favorite_object/delete_favorite_object_icon_button.dart';

ListTile unitFavorites({
  required BuildContext context,
  required List<String> dataList,
  required int index,
}) {
  final TextStyle txtStyle = TextStyle(
    color: Theme.of(context).textTheme.bodyLarge?.color,
    fontWeight: FontWeight(400),
    fontSize: 17.0,
  );
  return ListTile(
    visualDensity: const VisualDensity(vertical: -4),
    title: Align(
      alignment: Alignment.centerLeft,
      child: Text(dataList[index], style: txtStyle),
    ),

    trailing: DeleteFavObjIconButton(cityName: dataList[index]),
  );
}
