import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serategna_freelance_app/bloc/application_bloc/bloc.dart';
import 'package:serategna_freelance_app/presentation/commons/application_detail.dart';

class EmployerNotifications extends StatefulWidget {
  @override
  _EmployerNotificationsState createState() => _EmployerNotificationsState();
}

class _EmployerNotificationsState extends State<EmployerNotifications> {
  @override
  void initState() {
    BlocProvider.of<ApplicationBloc>(context).add(ApplicationLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        title: Text('Notifications'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocConsumer<ApplicationBloc, ApplicationState>(
        listener: (context, state) {
          if (state is ApplicationOperationFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('${state.message}')));
          }
        },
        builder: (context, state) {
          if (state is ApplicationLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.indigo,
              ),
            );
          }
          if (state is ApplicationLoadSuccess) {
            final applications = state.applications;
            return ListView.builder(
                itemCount: applications.length,
                itemBuilder: (context, index) {
                  final application = applications[index];
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ApplicationDetail(
                                    application: application,
                                  )));
                    },
                    title: Text('\nTitle: ' +
                        application.job["title"] +
                        '\n'
                            'Salary: ' +
                        application.job["salary"].toString() +
                        '\n'
                            'Job Type: ' +
                        application.job["jobType"] +
                        '\n'
                            'Date Posted: ' +
                        application.job["position"] +
                        '\n'
                            'Company: ' +
                        application.job["company"] +
                        '\n'
                            'Applicant: ' +
                        application.job["employer"]["fullName"]),
                    leading: Text(application.job["employer"]["fullName"]
                        .toString()
                        .substring(0, 1)
                        .toUpperCase()),
                  );
                });
          }
          return Container();
        },
      ),
    );
  }
}
