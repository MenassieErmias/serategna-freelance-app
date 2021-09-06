import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serategna_freelance_app/bloc/user_bloc/bloc.dart';
import 'package:serategna_freelance_app/presentation/auth/login_screen.dart';
import 'package:serategna_freelance_app/bloc/job_bloc/bloc.dart';
import 'package:serategna_freelance_app/presentation/commons/jobDetail.dart';
import 'package:serategna_freelance_app/data_layer/models/job_model.dart';
import 'package:serategna_freelance_app/utils/pref_functions.dart';

class AdminJobsList extends StatefulWidget {
  @override
  _AdminJobsListState createState() => _AdminJobsListState();
}

class _AdminJobsListState extends State<AdminJobsList> {
  LocallyStored locallyStored = LocallyStored();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text('Jobs'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () async {
                BlocProvider.of<UserBloc>(context).add(Logout());
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false);
              },
              icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: BlocConsumer<JobBloc, JobState>(
        listener: (context, state) {
          if (state is JobOperationFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('${state.message}')));
          }
        },
        builder: (context, state) {
          if (state is JobLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is JobLoadSuccess) {
            final jobs = state.jobs;
            return ListView.builder(
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 1.0, horizontal: 4.0),
                    child: ListTile(
                      onTap: () {},
                      title: Text('\nTitle: ' +
                          jobs[index].title +
                          '\n'
                              'Salary: ' +
                          jobs[index].salary.toString() +
                          '\n'
                              'Job Type: ' +
                          jobs[index].jobType +
                          '\n'
                              'Company: ' +
                          jobs[index].company +
                          '\n'),
                      subtitle: Column(
                        children: <Widget>[
                          Container(
                              child: Row(
                            children: <Widget>[
                              FlatButton(
                                color: Colors.amber,
                                child: Text("Details"),
                                onPressed: () async {
                                  final role = await locallyStored.getRole();
                                  final userId = await locallyStored.prefUser();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => JobsDetails(
                                            job: JobModel(
                                                title: jobs[index].title,
                                                salary: jobs[index].salary,
                                                company: jobs[index].company,
                                                position: jobs[index].position,
                                                employer: jobs[index].employer,
                                                jobType: jobs[index].jobType,
                                                id: jobs[index].id,
                                                isAcceptingApplication:
                                                    jobs[index]
                                                        .isAcceptingApplication,
                                                description:
                                                    jobs[index].description),
                                            userId: userId,
                                            role: role,
                                          )));
                                },
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              FlatButton(
                                color: Colors.red,
                                child: Text("Delete"),
                                onPressed: () async {
                                  BlocProvider.of<JobBloc>(context)
                                      .add(JobDelete(job: jobs[index]));
                                },
                              ),
                            ],
                          ))
                        ],
                      ),
                      leading: Text(jobs[index].employer != null
                          ? jobs[index]
                              .employer["fullName"]
                              .toString()
                              .substring(0, 1)
                              .toUpperCase()
                          : ""),
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
