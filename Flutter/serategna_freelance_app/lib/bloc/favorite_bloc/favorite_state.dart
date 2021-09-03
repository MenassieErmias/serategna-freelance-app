import 'package:equatable/equatable.dart';
import 'package:serategna_freelance_app/models/favorite_model.dart';

class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoadSuccess extends FavoriteState {
  final List<FavoriteModel> favorites;

  FavoriteLoadSuccess([this.favorites = const []]);
  @override
  List<Object> get props => [favorites];
}

class FavoriteAddSuccess extends FavoriteState {
  @override
  List<Object> get props => [];
}

class FavoriteOperationFailure extends FavoriteState {
  final String message;
  FavoriteOperationFailure({this.message});
  @override
  List<Object> get props => [message];
}
