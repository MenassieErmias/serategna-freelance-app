import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serategna_freelance_app/bloc/user_bloc/bloc.dart';
import 'package:serategna_freelance_app/constants/constants.dart';
import 'package:serategna_freelance_app/presentation/auth/login_screen.dart';
import 'package:serategna_freelance_app/bloc/job_bloc/bloc.dart';
import 'package:serategna_freelance_app/presentation/commons/favorite_button.dart';
import 'package:serategna_freelance_app/presentation/commons/jobDetail.dart';
import 'package:serategna_freelance_app/presentation/employer/add_job.dart';
import 'package:serategna_freelance_app/data_layer/models/job_model.dart';
import 'package:serategna_freelance_app/utils/pref_functions.dart';

class JobsList extends StatefulWidget {
  static const routeName = '/freelancerJobList';
  @override
  _JobsListState createState() => _JobsListState();
}

class _JobsListState extends State<JobsList> {
  LocallyStored locallyStored = LocallyStored();
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
          backgroundColor: Colors.green,
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
                    final job = jobs[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 1.0, horizontal: 4.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomRow(
                                first: Text(
                                  job.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 18),
                                ),
                                second: FavoriteButton(job.id),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              CustomRow(
                                first: CustomColumn(
                                  text1: 'ETB ${job.salary}',
                                  text2: 'Budget',
                                ),
                                second: CustomColumn(
                                  text1: job.position,
                                  text2: 'Job Position',
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                job.description,
                                style: TextStyle(letterSpacing: 1),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.green),
                                  ),
                                  child: Center(
                                    child: IconButton(
                                        onPressed: () async {
                                          final role =
                                              await locallyStored.getRole();
                                          final userId =
                                              await locallyStored.prefUser();
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) => JobsDetails(
                                                job: JobModel(
                                                    title: job.title,
                                                    salary: job.salary,
                                                    company: job.company,
                                                    position: job.position,
                                                    employer: job.employer,
                                                    jobType: job.jobType,
                                                    id: job.id,
                                                    createdAt: job.createdAt,
                                                    isAcceptingApplication: job
                                                        .isAcceptingApplication,
                                                    description:
                                                        job.description),
                                                userId: userId,
                                                role: role,
                                              ),
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.arrow_forward_ios)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
            return Container();
          },
        ),
        floatingActionButton: FutureBuilder(
          future: locallyStored.getRole(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data == Constants.EMPLOYER) {
                return FloatingActionButton(
                  backgroundColor: Colors.red,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => AddJob(
                              createJob: true,
                            )));
                  },
                  tooltip: 'Add Job',
                  child: Icon(Icons.add),
                );
              }
            }
            return Container();
          },
        ));
  }
}

class CustomRow extends StatelessWidget {
  final Widget first, second;

  const CustomRow({this.first, this.second});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: first),
        second,
      ],
    );
  }
}

class CustomColumn extends StatelessWidget {
  final String text1, text2;

  const CustomColumn({this.text1, this.text2});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          text2,
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
        )
      ],
    );
  }
}
