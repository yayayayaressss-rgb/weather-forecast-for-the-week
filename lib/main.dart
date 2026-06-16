import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/bloc/bloc.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/bloc/events/events.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/bottom_card_change_cubit/bottom_card_change_cubit.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/favorite_cubit/favorite_cubit.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/metric_cubit/metric_cubit.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/network_check_cub/network_cubit.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/theme_cubit/theme_cubit.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/theme_cubit/theme_states.dart';
import 'common/routes/app_router.dart';
import 'core/DI/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getStart();
  runApp(const MyApp02());
}

class MyApp02 extends StatelessWidget {
  const MyApp02({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _providers(context),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            routerConfig: goRouter(context: context),
            title: 'Weather App',
            theme: context.watch<ThemeCubit>().state.theme,
            darkTheme: context.watch<ThemeCubit>().state.theme,
            themeMode: ThemeMode.system,
          );
        },
      ),
    );
  }
}

List<BlocProvider<Object?>> _providers(BuildContext context) {
  final list = [
    BlocProvider<MetricCubit>(create: (context) => MetricCubit()),
    BlocProvider<FavoriteCubit>(
      create: (context) => FavoriteCubit(useCase: getIt()),
    ),
    BlocProvider<BottomCardCubit>(
      create: (context) => BottomCardCubit(useCase: getIt()),
    ),
    BlocProvider<ThemeCubit>(
      create: (context) => getIt<ThemeCubit>()..changeTheme(),
    ),
    BlocProvider<NetworkCubit>(
      create: (context) => getIt<NetworkCubit>()..check(),
    ),
    BlocProvider<MyBloc>(
      create: (context) =>
          getIt<MyBloc>()..add(GetAllFavoritesCityData(isMetric: true)),
    ),
  ];
  return list;
}
