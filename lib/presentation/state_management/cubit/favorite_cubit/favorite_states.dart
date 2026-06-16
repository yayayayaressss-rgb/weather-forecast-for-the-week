import 'package:equatable/equatable.dart';

sealed class FavoriteStates extends Equatable {
  final bool favorite;

  const FavoriteStates({required this.favorite});

  @override
  List<Object?> get props => [favorite];
}

final class Favorite extends FavoriteStates {
  @override
  const Favorite({required super.favorite});

  @override
  List<Object?> get props => [favorite];
}

final class UnFavorite extends FavoriteStates {
  const UnFavorite({required super.favorite});

  @override
  List<Object?> get props => [favorite];
}

class GetListFavorites extends FavoriteStates {
  final List<String> favoritesList;

  const GetListFavorites({
    required super.favorite,
    this.favoritesList = const [],
  });
}
