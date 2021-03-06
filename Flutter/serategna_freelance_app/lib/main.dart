import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serategna_freelance_app/bloc/application_bloc/bloc.dart';
import 'package:serategna_freelance_app/bloc/favorite_bloc/bloc.dart';
import 'package:serategna_freelance_app/bloc/job_bloc/bloc.dart';
import 'package:serategna_freelance_app/presentation/commons/splash_screen.dart';
import 'package:serategna_freelance_app/data_layer/data_provider/application_data_provider.dart';
import 'package:serategna_freelance_app/data_layer/data_provider/favorite_data_provider.dart';
import 'package:serategna_freelance_app/data_layer/data_provider/job_data_provider.dart';
import 'package:serategna_freelance_app/data_layer/data_provider/user_data_provider.dart';
import 'package:serategna_freelance_app/data_layer/repository/application_repo.dart';
import 'package:serategna_freelance_app/data_layer/repository/favorite_repo.dart';
import 'package:serategna_freelance_app/data_layer/repository/job_repo.dart';
import 'package:serategna_freelance_app/data_layer/repository/user_repo.dart';
import 'package:serategna_freelance_app/bloc/user_bloc/bloc.dart';
import 'package:http/http.dart' as http;

void main() {
  final UserRepo userRepo =
      UserRepo(userDataProvider: UserDataProvider(httpClient: http.Client()));
  final JobRepo jobRepo =
      JobRepo(jobDataProvider: JobDataProvider(httpClient: http.Client()));
  final ApplicationRepo applicationRepo = ApplicationRepo(
      applicationDataProvider:
          ApplicationDataProvider(httpClient: http.Client()));
  final FavoriteRepo favoriteRepo = FavoriteRepo(
      favoriteDataProvider: FavoriteDataProvider(httpClient: http.Client()));
  runApp(MyApp(
      userRepo: userRepo,
      jobRepo: jobRepo,
      applicationRepo: applicationRepo,
      favoriteRepo: favoriteRepo));
}

class MyApp extends StatelessWidget {
  MyApp(
      {@required this.userRepo,
      @required this.jobRepo,
      @required this.applicationRepo,
      @required this.favoriteRepo});
  final UserRepo userRepo;
  final JobRepo jobRepo;
  final ApplicationRepo applicationRepo;
  final FavoriteRepo favoriteRepo;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<UserRepo>(create: (context) => userRepo),
          RepositoryProvider<JobRepo>(create: (context) => jobRepo),
          RepositoryProvider<ApplicationRepo>(
              create: (context) => applicationRepo),
          RepositoryProvider<FavoriteRepo>(create: (context) => favoriteRepo)
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) =>
                    UserBloc(userRepo: userRepo)..add(StartEvent())),
            BlocProvider(create: (context) => JobBloc(jobRepo: jobRepo)),
            BlocProvider(
                create: (context) =>
                    ApplicationBloc(applicationRepo: applicationRepo)),
            BlocProvider(
                create: (context) => FavoriteBloc(favoriteRepo: favoriteRepo)),
          ],
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: SplashScreen(),
          ),
        ));
  }
}
