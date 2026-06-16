import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../state_management/cubit/favorite_cubit/favorite_cubit.dart';

PreferredSizeWidget favoritesAppBar({
  required BuildContext context,
  required String cityName,
}) {
  return AppBar(
    elevation: 4,
    backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
    centerTitle: true,
    leading: IconButton(
      onPressed: () {
        context.read<FavoriteCubit>().checkFavoriteStatus(cityName: cityName);
        context.go('/');
      },
      icon: Icon(
        Icons.arrow_back_outlined,
        color: Theme.of(context).appBarTheme.foregroundColor,
      ),
    ),
    title: _textTitle(context),
  );
}

Text _textTitle(BuildContext context) {
  final textStyle = TextStyle(
    color: Theme.of(context).appBarTheme.foregroundColor,
    fontSize: 26,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.05,
  );
  return Text(style: textStyle, 'Избранные города');
}
