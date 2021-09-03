import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serategna_freelance_app/bloc/job_bloc/bloc.dart';
import 'package:serategna_freelance_app/commons/detail.dart';
import 'package:serategna_freelance_app/freelancer/application_form.dart';
import 'package:serategna_freelance_app/models/job_model.dart';
import 'package:serategna_freelance_app/models/jobs_list.dart';

class FreelancerJobsDetails extends StatefulWidget {
  final JobModel job;

  const FreelancerJobsDetails({Key key, this.job}) : super(key: key);
  @override
  _FreelancerJobsDetailsState createState() => _FreelancerJobsDetailsState();
}

class _FreelancerJobsDetailsState extends State<FreelancerJobsDetails> {
  List<JobsList> jobs = [
    JobsList(
        titles: 'Graphics Designer',
        salary: '2000',
        jobType: 'Permanent',
        datePosted: '10/4/21',
        company: 'AZ Media'),
  ];
  int _currentIndex = 0;

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
      body: BlocConsumer<JobBloc, JobState>(
        listener: (context, state) {
          if (state is JobOperationFailure) {}
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailRow(
                      title: "Job Title:   ",
                      data: widget.job.title,
                    ),
                    DetailRow(
                      title: "Salary:   ",
                      data: widget.job.salary.toString(),
                    ),
                    DetailRow(
                      title: "company:   ",
                      data: widget.job.company,
                    ),
                    DetailRow(
                      title: "Position:   ",
                      data: widget.job.position,
                    ),
                    DetailRow(
                      title: "Description:   ",
                      data: widget.job.description,
                    ),
                    DetailRow(
                      title: "Job Type:   ",
                      data: widget.job.jobType,
                    ),
                    DetailRow(
                      title: "Posted by: ",
                      data: widget.job.employer["fullName"],
                    ),
                  ],
                ),
                Container(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(Size(
                            MediaQuery.of(context).size.width,
                            MediaQuery.of(context).size.height / 17)),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15))),
                    child: Text("Apply"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Apply(apply: true, jobId: widget.job.id)));
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
