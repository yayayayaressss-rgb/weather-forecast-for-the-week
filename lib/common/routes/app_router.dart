import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:forecast_app_pet_proj/common/routes/route_names.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/favorites_screen/favorite_screen.dart';
import '../../presentation/screens/home_screen/home_screen_build.dart';
import '../../presentation/screens/metrics_screen/metrics_screen.dart';

GoRouter goRouter({required BuildContext context}) {
  final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [_home(context), _favorites(context), _metric(context)],
  );
  return router;
}

GoRoute _home(BuildContext context) {
  return GoRoute(
    path: RoutersName.homePath,
    name: RoutersName.homeName,
    builder: (context, state) {
      return const HomeScreen();
    },
  );
}

GoRoute _favorites(BuildContext context) {
  return GoRoute(
    path: RoutersName.favoritesPath,
    name: RoutersName.favoritesName,
    builder: (context, state) {
      return const FavoriteScreen();
    },
  );
}

GoRoute _metric(BuildContext context) {
  return GoRoute(
    path: RoutersName.metricPath,
    name: RoutersName.metricName,
    builder: (context, state) {
      return const MetricsScreen();
    },
  );
}
