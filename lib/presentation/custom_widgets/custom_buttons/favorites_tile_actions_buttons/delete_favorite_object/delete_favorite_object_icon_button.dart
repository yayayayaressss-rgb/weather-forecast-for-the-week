import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/favorite_cubit/favorite_cubit.dart';

class DeleteFavObjIconButton extends StatelessWidget {
  final String cityName;

  const DeleteFavObjIconButton({super.key, required this.cityName});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<FavoriteCubit>().deleteFromFavorite(cityName: cityName);
      },
      icon: Icon(
        Icons.delete,
        color: Theme.of(context).appBarTheme.foregroundColor,
      ),
    );
  }
}
