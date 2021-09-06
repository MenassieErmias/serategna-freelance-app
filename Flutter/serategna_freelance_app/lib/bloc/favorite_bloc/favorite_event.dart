import 'package:equatable/equatable.dart';
import 'package:serategna_freelance_app/data_layer/models/favorite_model.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();
}

class FavoriteLoad extends FavoriteEvent {
  const FavoriteLoad();

  @override
  List<Object> get props => [];
}

class AddFavorite extends FavoriteEvent {
  final String jobId;
  const AddFavorite(this.jobId);

  @override
  List<Object> get props => [jobId];

  @override
  String toString() => 'Favorite added';
}

class RemoveFavorite extends FavoriteEvent {
  final FavoriteModel favorite;
  const RemoveFavorite({this.favorite});

  @override
  List<Object> get props => [favorite];

  @override
  toString() => 'Favorite Deleted {favorite: $favorite}';
}
