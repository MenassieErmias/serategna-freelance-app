import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serategna_freelance_app/bloc/application_bloc/bloc.dart';
import 'package:serategna_freelance_app/bloc/job_bloc/bloc.dart';
import 'package:serategna_freelance_app/commons/splash_screen.dart';
import 'package:serategna_freelance_app/data_provider/application_data_provider.dart';
import 'package:serategna_freelance_app/data_provider/job_data_provider.dart';
import 'package:serategna_freelance_app/data_provider/user_data_provider.dart';
import 'package:serategna_freelance_app/repository/application_repo.dart';
import 'package:serategna_freelance_app/repository/job_repo.dart';
import 'package:serategna_freelance_app/repository/user_repo.dart';
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
  runApp(MyApp(
    userRepo: userRepo,
    jobRepo: jobRepo,
    applicationRepo: applicationRepo,
  ));
}

class MyApp extends StatelessWidget {
  MyApp(
      {@required this.userRepo,
      @required this.jobRepo,
      @required this.applicationRepo});
  final UserRepo userRepo;
  final JobRepo jobRepo;
  final ApplicationRepo applicationRepo;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<UserRepo>(create: (context) => userRepo),
          RepositoryProvider<JobRepo>(create: (context) => jobRepo),
          RepositoryProvider<ApplicationRepo>(
              create: (context) => applicationRepo),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) =>
                    UserBloc(userRepo: userRepo)..add(StartEvent())),
            BlocProvider(
                create: (context) => JobBloc(jobRepo: jobRepo)..add(JobLoad())),
            BlocProvider(
                create: (context) =>
                    ApplicationBloc(applicationRepo: applicationRepo)
                      ..add(ApplicationLoad())),
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
