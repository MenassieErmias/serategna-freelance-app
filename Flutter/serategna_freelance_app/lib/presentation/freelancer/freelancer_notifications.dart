import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serategna_freelance_app/bloc/application_bloc/bloc.dart';

class FreelancerNotifications extends StatefulWidget {
  @override
  _FreelancerNotificationsState createState() =>
      _FreelancerNotificationsState();
}

class _FreelancerNotificationsState extends State<FreelancerNotifications> {
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
        backgroundColor: Colors.purple[900],
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
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 1.0, horizontal: 4.0),
                      child: Card(
                        child: ListTile(
                          onTap: () {},
                          title: Text('\nTitle: ' +
                              applications[index].job["title"] +
                              '\n'
                                  'Salary: ' +
                              applications[index].job["salary"].toString() +
                              '\n'
                                  'Job Type: ' +
                              applications[index].job["jobType"] +
                              '\n'
                                  'Company: ' +
                              applications[index].job["company"] +
                              '\n'),
                          subtitle: Text(
                            applications[index].applicationStatus == 'PENDING'
                                ? "${applications[index].applicationStatus}"
                                : "${applications[index].applicationStatus}! (Employer will contact you soon)\n",
                            style: TextStyle(
                                color: applications[index].applicationStatus ==
                                        "ACCEPTED"
                                    ? Colors.green
                                    : Colors.orange),
                          ),
                        ),
                      ));
                });
          }
          return Container();
        },
      ),
    );
  }
}
