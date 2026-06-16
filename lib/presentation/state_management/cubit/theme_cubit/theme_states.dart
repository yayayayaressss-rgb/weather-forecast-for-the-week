import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../common/app_theme/app_theme.dart';

sealed class ThemeState extends Equatable {
  final ThemeData? theme;

  const ThemeState({this.theme});
}

final class ThemeStateLight extends ThemeState {
  @override
  final ThemeData? theme = AppTheme.desertLight;

  ThemeStateLight();

  @override
  List<Object?> get props => [theme];
}

final class ThemeStateDark extends ThemeState {
  @override
  final ThemeData? theme = AppTheme.forestDark;

  ThemeStateDark();

  @override
  List<Object?> get props => [theme];
}
