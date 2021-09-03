import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:serategna_freelance_app/auth/login_screen.dart';
import 'package:serategna_freelance_app/bloc/job_bloc/bloc.dart';
import 'package:serategna_freelance_app/commons/jobDetail.dart';
import 'package:serategna_freelance_app/employer/add_job.dart';
import 'package:serategna_freelance_app/models/job_model.dart';
import 'package:serategna_freelance_app/utils/pref_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployerJobsList extends StatefulWidget {
  static const routeName = '/employerJobList';
  @override
  _EmployerJobsListState createState() => _EmployerJobsListState();
}

class _EmployerJobsListState extends State<EmployerJobsList> {
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
        backgroundColor: Colors.green[500],
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
                    child: Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      child: ListTile(
                        onTap: () async {
                          final role = await getRole();
                          final userId = await prefUser();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => JobsDetails(
                                    userId: userId,
                                    role: role,
                                    job: JobModel(
                                        title: jobs[index].title,
                                        salary: jobs[index].salary,
                                        company: jobs[index].company,
                                        position: jobs[index].position,
                                        employer: jobs[index].employer,
                                        jobType: jobs[index].jobType,
                                        id: jobs[index].id,
                                        isAcceptingApplication:
                                            jobs[index].isAcceptingApplication,
                                        description: jobs[index].description)),
                              ));
                        },
                        title: Text(
                            jobs[index].title != null ? jobs[index].title : ""),
                        subtitle: Text(jobs[index].description != null
                            ? jobs[index].description
                            : ""),
                        leading: CircleAvatar(
                          // backgroundImage: AssetImage('assets/${locations[index].flag}'),
                          child: Text("A"),
                        ),
                      ),
                      secondaryActions: [
                        IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () => BlocProvider.of<JobBloc>(context)
                              .add(JobDelete(job: jobs[index])),
                        ),
                        IconSlideAction(
                          caption: 'Update',
                          color: Colors.grey,
                          icon: Icons.delete,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider.value(
                                          value:
                                              BlocProvider.of<JobBloc>(context),
                                          child: AddJob(
                                            createJob: false,
                                            job: jobs[index],
                                          ),
                                        )));
                          },
                        )
                      ],
                    ),
                  );
                });
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => AddJob(
                    createJob: true,
                  )));
        },
        tooltip: 'Add Job',
        child: Icon(Icons.add),
      ),
    );
  }
}
