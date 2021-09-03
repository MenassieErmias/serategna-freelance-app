import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serategna_freelance_app/auth/login_screen.dart';
import 'package:serategna_freelance_app/bloc/job_bloc/bloc.dart';
import 'package:serategna_freelance_app/freelancer/freelancer_jobs_details.dart';
import 'package:serategna_freelance_app/models/jobs_list.dart';

class FreelancerJobsList extends StatefulWidget {
  static const routeName = '/freelancerJobList';
  @override
  _FreelancerJobsListState createState() => _FreelancerJobsListState();
}

class _FreelancerJobsListState extends State<FreelancerJobsList> {
  List<JobsList> jobs = [
    JobsList(
        titles: 'Graphics Designer',
        salary: '2000',
        jobType: 'Permanent',
        datePosted: '10/4/21',
        company: 'AZ Media'),
    JobsList(
        titles: 'Graphics Designer',
        salary: '2000',
        jobType: 'Permanent',
        datePosted: '10/4/21',
        company: 'AZ Media'),
    JobsList(
        titles: 'Graphics Designer',
        salary: '2000',
        jobType: 'Permanent',
        datePosted: '10/4/21',
        company: 'AZ Media'),
    JobsList(
        titles: 'Graphics Designer',
        salary: '2000',
        jobType: 'Permanent',
        datePosted: '10/4/21',
        company: 'AZ Media'),
    JobsList(
        titles: 'Graphics Designer',
        salary: '2000',
        jobType: 'Permanent',
        datePosted: '10/4/21',
        company: 'AZ Media'),
    JobsList(
        titles: 'Graphics Designer',
        salary: '2000',
        jobType: 'Permanent',
        datePosted: '10/4/21',
        company: 'AZ Media'),
    JobsList(
        titles: 'Graphics Designer',
        salary: '2000',
        jobType: 'Permanent',
        datePosted: '10/4/21',
        company: 'AZ Media'),
    JobsList(
        titles: 'Graphics Designer',
        salary: '2000',
        jobType: 'Permanent',
        datePosted: '10/4/21',
        company: 'AZ Media'),
  ];

  int _currentIndex = 0;
  @override
  void initState() {
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
                                                  job: jobs[index],
                                                )));
                                  },
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                FlatButton(
                                  color: Colors.lime,
                                  child: Text("Favourite"),
                                  onPressed: () {},
                                ),
                              ],
                            ))
                          ],
                        ),
                        leading: CircleAvatar(
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
