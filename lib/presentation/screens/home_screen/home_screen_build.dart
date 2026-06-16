import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/bloc/bloc.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/metric_cubit/metric_cubit.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/metric_cubit/metric_states.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/network_check_cub/network_cubit.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/network_check_cub/network_states.dart';
import '../../custom_widgets/cards/home_cards/disconnected_display/disconnected_display.dart';
import '../../state_management/bloc/events/events.dart';
import 'home_app_bar.dart';
import 'home_drawer/drawer_body.dart';
import 'home_screen_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    context.read<NetworkCubit>().check();
    final isMetric = context.read<MetricCubit>().state.isMetric;
    context.read<MyBloc>().add(GetDataFromCache(isMetric: isMetric));
  }

  @override
  Widget build(BuildContext context) {
    final isMetric = context.watch<MetricCubit>().state.isMetric;
    return BlocBuilder<NetworkCubit, NetworkState>(
      builder: (context, state) {
        return switch (state) {
          NetworkInitial() => HomeScreenPostCheck(
            scaffoldKey: _scaffoldKey,
            isMetric: isMetric,
          ),
          Disconnected() => Scaffold(
            key: _scaffoldKey,
            endDrawer: drawer(context: context, key: _scaffoldKey),
            appBar: homeAppBar(
              context: context,
              key: _scaffoldKey,
              isMetric: true,
            ),
            body: Center(child: DisconnectedDisplay()),
          ),
          Connected() => BlocBuilder<MetricCubit, MetricState>(
            builder: (context, state) {
              return HomeScreenPostCheck(
                scaffoldKey: _scaffoldKey,
                isMetric: state.isMetric,
              );
            },
          ),
        };
      },
    );
  }
}

class HomeScreenPostCheck extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool isMetric;

  const HomeScreenPostCheck({
    super.key,
    required this.scaffoldKey,
    required this.isMetric,
  });

  @override
  State<StatefulWidget> createState() => HomeScreenPostCheckState();
}

class HomeScreenPostCheckState extends State<HomeScreenPostCheck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      endDrawer: drawer(context: context, key: widget.scaffoldKey),
      appBar: homeAppBar(
        context: context,
        key: widget.scaffoldKey,
        isMetric: widget.isMetric,
      ),
      body: HomeScreenBody(isMetric: widget.isMetric),
    );
  }
}
