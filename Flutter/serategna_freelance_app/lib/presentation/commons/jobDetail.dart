import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serategna_freelance_app/bloc/favorite_bloc/bloc.dart';
import 'package:serategna_freelance_app/bloc/job_bloc/bloc.dart';
import 'package:serategna_freelance_app/constants/constants.dart';
import 'package:serategna_freelance_app/presentation/commons/detail.dart';
import 'package:serategna_freelance_app/presentation/commons/favorite_button.dart';
import 'package:serategna_freelance_app/presentation/commons/jobsList.dart';
import 'package:serategna_freelance_app/presentation/commons/users_list.dart';
import 'package:serategna_freelance_app/presentation/employer/add_job.dart';
import 'package:serategna_freelance_app/presentation/freelancer/application_form.dart';
import 'package:serategna_freelance_app/data_layer/models/job_model.dart';
import 'package:serategna_freelance_app/utils/time_difference.dart';

Widget get size_5 => SizedBox(
      height: 5,
    );

Widget get divider => Divider(
      thickness: 2,
    );

class JobsDetails extends StatelessWidget {
  final JobModel job;
  final String role, userId;

  const JobsDetails({Key key, this.job, this.role, this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.purple[900],
          title: Text('Details'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  divider,
                  size_5,
                  Text(
                    job.position,
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  size_5,
                  Text(
                    'Posted ${timeDifference(job.createdAt)}',
                    style: TextStyle(fontSize: 13),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // Text(data)
                  Text(
                    job.description,
                    style: TextStyle(
                      fontSize: 16,
                      wordSpacing: 1.1,
                      letterSpacing: 0.7,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomRow(
                    first: CustomColumn(
                      text1: 'ETB ${job.salary}',
                      text2: 'Salary',
                    ),
                    second: CustomColumn(
                      text1: job.jobType,
                      text2: 'Job Type',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomRow(
                    first: CustomColumn(
                      text1: job.company,
                      text2: 'Company',
                    ),
                    second: CustomColumn(
                      text1: job.isAcceptingApplication ? 'Yes' : 'No',
                      text2: 'Is Accepting',
                    ),
                  ),
                  size_5,
                  divider,

                  Text(
                    'About The Employer',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  size_5,
                  UsersList(
                    text: 'Name: ',
                    value: job.employer['fullName'],
                  ),
                  UsersList(
                    text: 'Email: ',
                    value: job.employer['email'],
                  ),
                  size_5,
                  divider
                ],
              ),
              role == "Constants.EMPLOYER" && userId == job.employer["_id"]
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                          Container(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.blue),
                                  fixedSize: MaterialStateProperty.all(Size(
                                      MediaQuery.of(context).size.width / 2.5,
                                      MediaQuery.of(context).size.height / 17)),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.symmetric(
                                          horizontal: 50, vertical: 15))),
                              child: Text("Edit"),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddJob(
                                              createJob: false,
                                              job: job,
                                            )));
                              },
                            ),
                          ),
                          Container(
                            child: BlocListener<JobBloc, JobState>(
                              listener: (context, state) {
                                if (state is JobOperationFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('${state.message}')));
                                }
                                if (state is JobLoadSuccess) {
                                  Navigator.pop(context);
                                }
                              },
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.red),
                                    fixedSize: MaterialStateProperty.all(Size(
                                        MediaQuery.of(context).size.width / 2.5,
                                        MediaQuery.of(context).size.height /
                                            17)),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.symmetric(
                                            horizontal: 50, vertical: 15))),
                                child: Text("Delete"),
                                onPressed: () {
                                  BlocProvider.of<JobBloc>(context)
                                      .add(JobDelete(job: job));
                                },
                              ),
                            ),
                          ),
                        ])
                  : role == Constants.ADMIN
                      ? SizedBox()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.green),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50))),
                                    fixedSize: MaterialStateProperty.all(Size(
                                        MediaQuery.of(context).size.width / 1.5,
                                        MediaQuery.of(context).size.height /
                                            17)),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.symmetric(
                                            horizontal: 50, vertical: 15))),
                                child: Text("Apply"),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Apply(
                                              apply: true, jobId: job.id)));
                                },
                              ),
                            ),
                            FavoriteButton(
                              job.id,
                              detail: true,
                            )
                          ],
                        )
            ],
          ),
        ));
  }
}
