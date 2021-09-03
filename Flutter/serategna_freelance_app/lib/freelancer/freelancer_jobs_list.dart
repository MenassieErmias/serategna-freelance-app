import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serategna_freelance_app/auth/login_screen.dart';
import 'package:serategna_freelance_app/bloc/favorite_bloc/bloc.dart';
import 'package:serategna_freelance_app/bloc/job_bloc/bloc.dart';
import 'package:serategna_freelance_app/freelancer/freelancer_jobs_details.dart';
import 'package:serategna_freelance_app/models/job_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FreelancerJobsList extends StatefulWidget {
  static const routeName = '/freelancerJobList';
  @override
  _FreelancerJobsListState createState() => _FreelancerJobsListState();
}

class _FreelancerJobsListState extends State<FreelancerJobsList> {
  @override
  void initState() {
    BlocProvider.of<JobBloc>(context).add(JobLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        title: Text('Jobs'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.remove("token");
                pref.remove("role");
                pref.remove("id");
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
                    child: Card(
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
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                FreelancerJobsDetails(
                                                  job: JobModel(
                                                      title: jobs[index].title,
                                                      salary:
                                                          jobs[index].salary,
                                                      company:
                                                          jobs[index].company,
                                                      position:
                                                          jobs[index].position,
                                                      employer:
                                                          jobs[index].employer,
                                                      jobType:
                                                          jobs[index].jobType,
                                                      id: jobs[index].id,
                                                      isAcceptingApplication: jobs[
                                                              index]
                                                          .isAcceptingApplication,
                                                      description: jobs[index]
                                                          .description),
                                                )));
                                  },
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ))
                          ],
                        ),
                        leading: CircleAvatar(
                          child: Text(jobs[index]
                              .employer["fullName"]
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
