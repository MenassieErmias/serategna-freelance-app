import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serategna_freelance_app/bloc/favorite_bloc/bloc.dart';
import 'package:serategna_freelance_app/presentation/commons/jobDetail.dart';
import 'package:serategna_freelance_app/data_layer/models/job_model.dart';

class FreelancerFavorites extends StatefulWidget {
  @override
  _FreelancerFavoritesState createState() => _FreelancerFavoritesState();
}

class _FreelancerFavoritesState extends State<FreelancerFavorites> {
  @override
  void initState() {
    BlocProvider.of<FavoriteBloc>(context).add(FavoriteLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        title: Text('Favorites'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocConsumer<FavoriteBloc, FavoriteState>(
        listener: (context, state) {
          if (state is FavoriteOperationFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('${state.message}')));
          }
        },
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.indigo,
              ),
            );
          }
          if (state is FavoriteLoadSuccess) {
            final favorites = state.favorites;
            return ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 1.0, horizontal: 4.0),
                    child: Card(
                      child: ListTile(
                        onTap: () {},
                        title: Text('\nTitle: ' +
                            favorites[index].job["title"] +
                            '\n'
                                'Salary: ETB ' +
                            favorites[index].job["salary"].toString() +
                            '\n'),
                        subtitle: Column(
                          children: <Widget>[
                            Container(
                                child: Row(
                              children: <Widget>[
                                FlatButton(
                                  color: Colors.amber,
                                  child: Text("Details"),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (_) => JobsDetails(
                                                  job: JobModel(
                                                      title: favorites[index]
                                                          .job["title"],
                                                      salary: favorites[index]
                                                          .job["salary"],
                                                      company: favorites[index]
                                                          .job["company"],
                                                      position: favorites[index]
                                                          .job["position"],
                                                      employer: favorites[index]
                                                          .job["employer"],
                                                      jobType: favorites[index]
                                                          .job["jobType"],
                                                      id: favorites[index]
                                                          .job["_id"],
                                                      createdAt:
                                                          favorites[index]
                                                              .job["createdAt"],
                                                      isAcceptingApplication:
                                                          favorites[index].job[
                                                              "isAcceptingApplication"],
                                                      description: favorites[index]
                                                          .job["description"]),
                                                )));
                                  },
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                FlatButton(
                                  color: Colors.red[300],
                                  child: Text("Remove"),
                                  onPressed: () {
                                    BlocProvider.of<FavoriteBloc>(context).add(
                                        RemoveFavorite(
                                            favorite: favorites[index]));
                                  },
                                ),
                              ],
                            ))
                          ],
                        ),
                        leading: CircleAvatar(
                          child: Text(favorites[index]
                              .job["employer"]["fullName"]
                              .toString()
                              .substring(0, 1)
                              .toUpperCase()),
                          // backgroundImage: AssetImage('assets/${locations[index].flag}'),
                        ),
                      ),
                    ),
                  );
                });
          }
          return Container();
        },
      ),
    );
  }
}
