import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serategna_freelance_app/bloc/application_bloc/bloc.dart';
import 'package:serategna_freelance_app/bloc/favorite_bloc/bloc.dart';
import 'package:serategna_freelance_app/bloc/job_bloc/bloc.dart';
import 'package:serategna_freelance_app/commons/detail.dart';
import 'package:serategna_freelance_app/employer/add_job.dart';
import 'package:serategna_freelance_app/freelancer/application_form.dart';
import 'package:serategna_freelance_app/models/job_model.dart';

class JobsDetails extends StatefulWidget {
  final JobModel job;
  final String role, userId;

  const JobsDetails({Key key, this.job, this.role, this.userId})
      : super(key: key);
  @override
  _JobsDetailsState createState() => _JobsDetailsState();
}

class _JobsDetailsState extends State<JobsDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("from details ${widget.job}");
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
              widget.role == "EMPLOYER" &&
                      widget.userId == widget.job.employer["_id"]
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
                                              job: widget.job,
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
                                      .add(JobDelete(job: widget.job));
                                },
                              ),
                            ),
                          ),
                        ])
                  : widget.role == "ADMIN"
                      ? SizedBox()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: ElevatedButton(
                                style: ButtonStyle(
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
                                              apply: true,
                                              jobId: widget.job.id)));
                                },
                              ),
                            ),
                            BlocConsumer<FavoriteBloc, FavoriteState>(
                              listener: (context, state) {
                                if (state is FavoriteOperationFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('${state.message}')));
                                }
                              },
                              builder: (context, state) {
                                if (state is FavoriteLoadSuccess) {
                                  final favorites = state.favorites;
                                  bool isFavorited = false;
                                  favorites.forEach((element) {
                                    if (element.job["_id"] == widget.job.id) {
                                      isFavorited = true;
                                      return;
                                    }
                                  });
                                  return Container(
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.circle),
                                    child: IconButton(
                                        onPressed: () {
                                          isFavorited
                                              ? ""
                                              : BlocProvider.of<FavoriteBloc>(
                                                      context)
                                                  .add(AddFavorite(
                                                      widget.job.id));
                                        },
                                        icon: Icon(
                                          isFavorited
                                              ? Icons.favorite
                                              : Icons.favorite_outline,
                                          color: isFavorited
                                              ? Colors.red
                                              : Colors.black,
                                        )),
                                  );
                                }
                                return Container(
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.circle),
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.favorite_outline)));
                              },
                            )
                          ],
                        )
            ],
          ),
        ));
  }
}
