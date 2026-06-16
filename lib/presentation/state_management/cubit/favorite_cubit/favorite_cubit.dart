import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app_pet_proj/domain/use_cases/favorites_use_case/favorites_use_case.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/favorite_cubit/favorite_states.dart';

class FavoriteCubit extends Cubit<FavoriteStates> {
  final FavoritesUseCase _useCase;

  FavoriteCubit({required FavoritesUseCase useCase})
    : _useCase = useCase,
      super(UnFavorite(favorite: false));

  Future<void> addToFavorite({required String cityName}) async {
    _useCase.addCityToFavorites(cityName);
    log(
      '$cityName added to fav, favList contains elements cont : ${_useCase.checkFavoriteOrNo(cityName).toString()}',
    );
    emit(Favorite(favorite: true));
  }

  Future<void> deleteFromFavorite({required String cityName}) async {
    _useCase.deleteFromFavorites(cityName);
    emit(UnFavorite(favorite: false));
    await getFavoritesList();
  }

  Future<void> getFavoritesList() async {
    final List<String> list = await _useCase.getFavoritesList();
    emit(GetListFavorites(favoritesList: list, favorite: true));
  }

  Future<void> checkFavoriteStatus({required String cityName}) async {
    if (await _useCase.checkFavoriteOrNo(cityName)) {
      emit(Favorite(favorite: true));
    } else {
      emit(UnFavorite(favorite: false));
    }
  }
}
