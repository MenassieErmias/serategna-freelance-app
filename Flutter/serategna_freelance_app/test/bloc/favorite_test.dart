import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:serategna_freelance_app/bloc/favorite_bloc/bloc.dart';
import 'package:serategna_freelance_app/data_layer/models/favorite_model.dart';
import 'package:serategna_freelance_app/data_layer/repository/favorite_repo.dart';

class MockFavoriteRepo extends Mock implements FavoriteRepo {}

void main() {
  MockFavoriteRepo mockFavoriteRepo = MockFavoriteRepo();
  setUp(() {});
  group('favorite', () {
    FavoriteModel favorite = FavoriteModel(
      id: "nsdbyfsd5f",
      job: <String, dynamic>{
        "id": "nsdbyfsd5f",
        "title": "sdfubdsfs",
        "description": "dsfbdsyf",
        "position": "sdfysdufs",
        "company": "sndufsdyufgsdy",
        "jobType": 'permanent',
        "salary": 200,
        "employer": <String, dynamic>{
          "fullName": "ans",
          "email": "a.g@com",
          "role": "Employer",
          '_id': 'dsds'
        }
      },
    );
    List<FavoriteModel> favoriteList = [favorite, favorite];
    blocTest<FavoriteBloc, FavoriteState>(
      'emits [FavoriteLoading(),FavoriteLoadSuccess()] when FavoriteLoad is added.',
      build: () {
        when(mockFavoriteRepo.getFavorites())
            .thenAnswer((_) async => favoriteList);
        return FavoriteBloc(favoriteRepo: mockFavoriteRepo);
      },
      act: (bloc) => bloc.add(FavoriteLoad()),
      expect: () => [FavoriteLoading(), FavoriteLoadSuccess(favoriteList)],
    );
    blocTest<FavoriteBloc, FavoriteState>(
      'emits [FavoriteLoadSuccess(favoriteList)] when AddFavorite is added.',
      build: () {
        when(mockFavoriteRepo.addToFavorites(favorite.job["id"]))
            .thenAnswer((_) async => favorite);
        return FavoriteBloc(favoriteRepo: mockFavoriteRepo);
      },
      act: (bloc) => bloc.add(AddFavorite(favorite.job["id"])),
      expect: () => [FavoriteLoadSuccess(favoriteList)],
    );
    blocTest<FavoriteBloc, FavoriteState>(
      'emits [FavoriteLoadSuccess(favoriteList)] when RemoveFavorite is added.',
      build: () {
        when(mockFavoriteRepo.removeFromFavorites(favorite.id))
            .thenAnswer((_) async => Future.value());
        return FavoriteBloc(favoriteRepo: mockFavoriteRepo);
      },
      act: (bloc) => bloc.add(RemoveFavorite(favorite: favorite)),
      expect: () => [FavoriteLoadSuccess(favoriteList)],
    );
  });
}
