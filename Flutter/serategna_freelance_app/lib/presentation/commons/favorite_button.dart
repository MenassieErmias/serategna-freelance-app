import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serategna_freelance_app/bloc/favorite_bloc/bloc.dart';

class FavoriteButton extends StatelessWidget {
  final String id;
  final bool detail;
  const FavoriteButton(this.id, {this.detail = false});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteBloc, FavoriteState>(
      listener: (context, state) {
        if (state is FavoriteOperationFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${state.message}')));
        }
      },
      builder: (context, state) {
        if (state is FavoriteLoadSuccess) {
          final favorites = state.favorites;
          bool isFavorited = false;
          favorites.forEach((favorite) {
            if (favorite.job["_id"] == id) {
              isFavorited = true;
              return;
            }
          });
          return Container(
            height: detail ? 50 : 40,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey)),
            child: IconButton(
                iconSize: detail ? 30 : 25,
                onPressed: () {
                  isFavorited
                      ? ""
                      : BlocProvider.of<FavoriteBloc>(context)
                          .add(AddFavorite(id));
                },
                icon: Icon(
                  isFavorited ? Icons.favorite : Icons.favorite_outline,
                  color: isFavorited ? Colors.red : Colors.black45,
                )),
          );
        }
        return Container(
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: IconButton(
                onPressed: () {}, icon: Icon(Icons.favorite_outline)));
      },
    );
  }
}
