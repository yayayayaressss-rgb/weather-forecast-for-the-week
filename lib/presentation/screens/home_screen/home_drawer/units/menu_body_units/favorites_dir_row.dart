import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/favorite_cubit/favorite_cubit.dart';
import 'package:go_router/go_router.dart';
import 'unit_interface.dart';

ListTile favorites({
  required BuildContext context,
  required GlobalKey<ScaffoldState> key,
}) {
  const String txt = 'Избранные Города';
  final Icon icon = Icon(Icons.star, color: Colors.amber);
  return tileUnitInterface(
    context: context,
    title: txt,
    icon: icon,
    action: () {
      Future.delayed(
        Duration(milliseconds: 300),
        () => key.currentState?.closeEndDrawer(),
      );
      context.read<FavoriteCubit>().getFavoritesList();
      context.go('/favorites');
    },
  );
}
