import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/network_check_cub/network_cubit.dart';

class RefreshNetworkConnectionButton extends StatelessWidget {
  const RefreshNetworkConnectionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<NetworkCubit>().check();
      },
      icon: Icon(
        Icons.refresh,
        color: Colors.red,
        size: 40.0,
        fontWeight: FontWeight(600),
      ),
    );
  }
}
