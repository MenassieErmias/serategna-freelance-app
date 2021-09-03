import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serategna_freelance_app/bloc/favorite_bloc/bloc.dart';
import 'package:serategna_freelance_app/repository/favorite_repo.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepo favoriteRepo;

  FavoriteBloc({@required this.favoriteRepo})
      : assert(favoriteRepo != null),
        super(FavoriteLoading());

  @override
  Stream<FavoriteState> mapEventToState(FavoriteEvent event) async* {
    if (event is FavoriteLoad) {
      yield FavoriteLoading();
      try {
        final favorites = await favoriteRepo.getFavorites();
        print(favorites);
        yield FavoriteLoadSuccess(favorites);
      } catch (e) {
        yield FavoriteOperationFailure(message: "$e");
      }
    }
    if (event is AddFavorite) {
      try {
        await favoriteRepo.addToFavorites(event.jobId);
        final favorites = await favoriteRepo.getFavorites();
        yield FavoriteLoadSuccess(favorites);
      } catch (e) {
        yield FavoriteOperationFailure(message: "$e");
      }
    }

    if (event is RemoveFavorite) {
      try {
        print("from remove ${event.favorite.id}");
        await favoriteRepo.removeFromFavorites(event.favorite.id);
        final favorites = await favoriteRepo.getFavorites();
        yield FavoriteLoadSuccess(favorites);
      } catch (e) {
        yield FavoriteOperationFailure(message: "$e");
      }
    }
  }
}
