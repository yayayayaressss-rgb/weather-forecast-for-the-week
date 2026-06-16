import 'package:forecast_app_pet_proj/data/repositories_data_impl/favorite_repo.dart';

class FavoritesUseCase {
  final FavoriteRepoIMPL _aRepo;

  FavoritesUseCase({required FavoriteRepoIMPL aRepo}) : _aRepo = aRepo;

  Future<bool> checkFavoriteOrNo(String cityName) async {
    return _aRepo.checkFavoriteOrNo(cityName);
  }

  Future<void> addCityToFavorites(String cityName) async {
    _aRepo.addCityToFavorites(cityName);
  }

  Future<void> deleteFromFavorites(String cityName) async {
    _aRepo.deleteFromFavorites(cityName);
  }

  Future<List<String>> getFavoritesList() async {
    return _aRepo.getFavoritesList();
  }
}
