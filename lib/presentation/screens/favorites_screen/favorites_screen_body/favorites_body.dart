import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app_pet_proj/presentation/screens/favorites_screen/favorites_screen_body/units/favorites_list_tile.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/favorite_cubit/favorite_cubit.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/favorite_cubit/favorite_states.dart';

class FavoritesBody extends StatelessWidget {
  const FavoritesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteStates>(
      builder: (context, state) {
        if (state is GetListFavorites) {
          return ListView.builder(
            itemCount: state.favoritesList.length,
            itemBuilder: (context, index) {
              return unitFavorites(
                context: context,
                dataList: state.favoritesList,
                index: index,
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
