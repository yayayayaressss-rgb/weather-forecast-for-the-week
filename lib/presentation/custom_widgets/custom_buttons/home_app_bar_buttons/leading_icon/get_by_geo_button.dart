import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/network_check_cub/network_cubit.dart';
import '../../../../state_management/bloc/bloc.dart';
import '../../../../state_management/bloc/events/events.dart';
import '../../../../state_management/bloc/states/states.dart';
import '../../../../state_management/cubit/metric_cubit/metric_cubit.dart';
import 'back_to_favorites_icon.dart';
import 'circular_gear_icon.dart';
import 'default_icon.dart';

class GetByGeoButton extends StatefulWidget {
  final bool isMetric;

  const GetByGeoButton({super.key, required this.isMetric});

  @override
  State<StatefulWidget> createState() => GetByGeoButtonState();
}

class GetByGeoButtonState extends State<GetByGeoButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  bool _isLoading = false;

  void letsEvent() {
    context.read<NetworkCubit>().check();
    final isMetric = context.read<MetricCubit>().state.isMetric;
    context.read<MyBloc>().add(GetByGeoEvent(isMetric: isMetric));
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMetric = context.watch<MetricCubit>().state.isMetric;
    return BlocBuilder<MyBloc, StateW>(
      builder: (context, state) {
        final isLoading = state is LoadingState;
        if (isLoading && !_isLoading) {
          _animationController.repeat();
          _isLoading = true;
        } else if (!isLoading && _isLoading) {
          _animationController.stop();
          _animationController.reset();
          _isLoading = false;
        }
        if (state is FailureState) {
          return BackToFavoritesIcon(isMetric: isMetric);
        }
        return switch (state) {
          LoadedSingle() =>
            state.favoritesIsEmpty
                ? CircularGear(
                    action: () {
                      letsEvent();
                    },
                    controller: _animationController,
                  )
                : BackToFavoritesIcon(isMetric: isMetric),
          LoadingState() => CircularGear(
            action: () {
              letsEvent();
            },
            controller: _animationController,
          ),
          EmptyState() => DefaultIcon(
            action: () {
              letsEvent();
            },
          ),
          _ => DefaultIcon(
            action: () {
              log('gettt');
              letsEvent();
            },
          ),
        };
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
