import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories_interface/favorite_repo_inter.dart';

const String FAVORITKEY = 'favorite';

class FavoriteRepoIMPL implements FavoriteRepo {
  final SharedPreferences _sharedPreferences;

  const FavoriteRepoIMPL({required SharedPreferences sharedPreferences})
    : _sharedPreferences = sharedPreferences;

  @override
  Future<void> addCityToFavorites(String cityName) async {
    final List<String> currentFavoritesList =
        _sharedPreferences.getStringList(FAVORITKEY) ?? [];

    if (!currentFavoritesList.contains(cityName)) {
      currentFavoritesList.add(cityName);
      await _sharedPreferences.setStringList(FAVORITKEY, currentFavoritesList);
    }
  }

  @override
  Future<bool> checkFavoriteOrNo(String? cityName) async {
    final listToCheck = _sharedPreferences.getStringList(FAVORITKEY) ?? [];
    return listToCheck.contains(cityName);
  }

  @override
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
      log('Failure in deleteFromFavorites : ${e.toString()}');
    }
  }

  @override
  Future<List<String>> getFavoritesList() async {
    return _sharedPreferences.getStringList(FAVORITKEY) ?? [];
  }
}
