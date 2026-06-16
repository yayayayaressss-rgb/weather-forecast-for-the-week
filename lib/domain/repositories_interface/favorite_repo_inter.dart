abstract class FavoriteRepo {
  Future<bool> checkFavoriteOrNo(String cityName);

  Future<void> addCityToFavorites(String cityName);

  Future<void> deleteFromFavorites(String cityName);

  Future<List<String>> getFavoritesList();
}
