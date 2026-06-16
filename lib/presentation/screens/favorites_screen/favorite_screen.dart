import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/network_check_cub/network_cubit.dart';

import 'favorite_screen_app_bar.dart';
import 'favorites_screen_body/favorites_body.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<StatefulWidget> createState() => FavoriteScreenState();
}

class FavoriteScreenState extends State<FavoriteScreen> {
  String addedCity = '';

  @override
  void initState() {
    super.initState();
    context.read<NetworkCubit>().check();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: favoritesAppBar(context: context, cityName: addedCity),
      body: FavoritesBody(),
    );
  }
}
