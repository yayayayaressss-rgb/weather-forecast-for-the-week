import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/favorite_cubit/favorite_cubit.dart';

import '../../../../state_management/cubit/favorite_cubit/favorite_states.dart';

class FavoriteIconButton extends StatefulWidget {
  final String cityName;
  final VoidCallback removeLogicAction;

  const FavoriteIconButton({
    super.key,
    required this.cityName,
    required this.removeLogicAction,
  });

  @override
  State<StatefulWidget> createState() => FavoriteIconButtonState();
}

class FavoriteIconButtonState extends State<FavoriteIconButton> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteCubit>().checkFavoriteStatus(
      cityName: widget.cityName,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (mounted) {
      context.read<FavoriteCubit>().checkFavoriteStatus(
        cityName: widget.cityName,
      );
    }

    return BlocBuilder<FavoriteCubit, FavoriteStates>(
      builder: (context, state) {
        final isFavorite = state is Favorite;
        return IconButton(
          onPressed: () {
            if (isFavorite) {
              widget.removeLogicAction();
              context.read<FavoriteCubit>().deleteFromFavorite(
                cityName: widget.cityName,
              );
            } else {
              context.read<FavoriteCubit>().addToFavorite(
                cityName: widget.cityName,
              );
            }
          },
          icon: Icon(
            Icons.star,
            color: isFavorite
                ? Colors.amber
                : Theme.of(context).colorScheme.primary,
          ),
        );
      },
    );
  }
}
