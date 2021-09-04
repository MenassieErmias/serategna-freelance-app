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
      body: Container(
        child: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => AddJob(
                      createJob: true,
                    )));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
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
