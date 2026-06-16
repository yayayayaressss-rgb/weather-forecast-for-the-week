import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/bloc/bloc.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/bloc/events/events.dart';

class BackToFavoritesIcon extends StatelessWidget {
  final bool isMetric;

  const BackToFavoritesIcon({super.key, required this.isMetric});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<MyBloc>().add(GetAllFavoritesCityData(isMetric: isMetric));
      },
      icon: Icon(
        Icons.arrow_back,
        color: Theme.of(context).appBarTheme.foregroundColor,
      ),
    );
  }
}
