import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import '../../entities/meteo_enity/meteo_enity.dart';
import '../../repositories_interface/remote_data_repo.dart';

const String FAVORITKEY = 'favorite';

class FavoritesUseCase {
  final SharedPreferences _sharedPreferences;
  final RemoteDataRepo _aRepo;

  FavoritesUseCase({
    required RemoteDataRepo dataRepo,
    required SharedPreferences sharedPreferences,
  })
      : _sharedPreferences = sharedPreferences,
        _aRepo = dataRepo;

  Future<bool> checkFavoriteOrNo(String cityName) async {
    final listToCheck = _sharedPreferences.getStringList(FAVORITKEY) ?? [];
    return listToCheck.contains(cityName);
  }

  Future<void> addCityToFavorites(String cityName) async {
    final List<String> currentFavoritesList =
        _sharedPreferences.getStringList(FAVORITKEY) ?? [];

    if (!currentFavoritesList.contains(cityName)) {
      currentFavoritesList.add(cityName);
      await _sharedPreferences.setStringList(FAVORITKEY, currentFavoritesList);
    }
  }

  Future<void> deleteFromFavorites(String cityName) async {
    try {
      final List<String> currentFavoritesList =
          _sharedPreferences.getStringList(FAVORITKEY) ?? [];

      if (currentFavoritesList.remove(cityName)) {
        await _sharedPreferences.setStringList(
          FAVORITKEY,
          currentFavoritesList,
        );
      }
    } catch (e) {

    }
  }

  Future<List<String>> getFavoritesList() async {
    return _sharedPreferences.getStringList(FAVORITKEY) ?? [];
  }
}
