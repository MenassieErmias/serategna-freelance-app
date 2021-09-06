import 'package:meta/meta.dart';
import 'package:serategna_freelance_app/bloc/favorite_bloc/bloc.dart';
import 'package:serategna_freelance_app/data_layer/data_provider/favorite_data_provider.dart';
import 'package:serategna_freelance_app/data_layer/models/favorite_model.dart';

class FavoriteRepo {
  final FavoriteDataProvider favoriteDataProvider;
  FavoriteRepo({@required this.favoriteDataProvider});

  Future<void> addToFavorites(String jobId) async {
    return favoriteDataProvider.addToFavorites(jobId);
  }

  Future<List<FavoriteModel>> getFavorites() async {
    return favoriteDataProvider.getFavorites();
  }

  Future<void> removeFromFavorites(String id) async {
    return favoriteDataProvider.removeFromFavorites(id);
  }
}
