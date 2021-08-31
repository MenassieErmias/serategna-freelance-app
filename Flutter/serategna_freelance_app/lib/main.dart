import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serategna_freelance_app/auth/login_screen.dart';
import 'package:serategna_freelance_app/admin/admin_employer_list.dart';
import 'package:serategna_freelance_app/admin/admin_freelancer_list.dart';
import 'package:serategna_freelance_app/admin/admin_jobs_list.dart';
import 'package:serategna_freelance_app/data_provider/user_data_provider.dart';
import 'package:serategna_freelance_app/employer/add_job.dart';
import 'package:serategna_freelance_app/employer/employer_notifications.dart';
import 'package:serategna_freelance_app/employer/employer_profile.dart';
import 'package:serategna_freelance_app/freelancer/Freelancer_profile.dart';
import 'package:serategna_freelance_app/freelancer/freelancer_favourites.dart';
import 'package:serategna_freelance_app/freelancer/freelancer_jobs_details.dart';
import 'package:serategna_freelance_app/freelancer/freelancer_jobs_list.dart';
import 'package:serategna_freelance_app/freelancer/freelancer_notifications.dart';
import 'package:serategna_freelance_app/repository/user_repo.dart';
import 'package:serategna_freelance_app/bloc/user_bloc/bloc.dart';
import 'employer/employer_jobs_list.dart';
import 'freelancer/freelancer_bottom_navigation.dart';
import 'package:http/http.dart' as http;

void main() {
  final UserRepo userRepo =
      UserRepo(userDataProvider: UserDataProvider(httpClient: http.Client()));
  runApp(MyApp(
    userRepo: userRepo,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({
    @required this.userRepo,
    // @required this.stationRepository,
    // @required this.postRepository
  });
  // assert(stationRepository != null);
  final UserRepo userRepo;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<UserRepo>(create: (context) => userRepo),
          // RepositoryProvider<StationRepository>(
          //     create: (context) => stationRepository),
          // RepositoryProvider(create: (context) => postRepository),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) =>
                    UserBloc(userRepo: userRepo)..add(StartEvent())),
            // BlocProvider(
            //     create: (context) =>
            //         StationBloc(stationRepository: stationRepository)
            //           ..add(StationLoad())),
            // BlocProvider(
            //     create: (context) =>
            //         PostBloc(postRepository: postRepository)..add(PostLoad())),
            // BlocProvider(
            //     create: (context) => NearbyBloc(
            //         stationRepository: stationRepository)
            //       ..add(NearbyLoad(currentCoordinate: '9.044559, 38.7580017')))
          ],
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: LoginPage(),
          ),
        ));
  }
}
