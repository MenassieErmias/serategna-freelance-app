import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serategna_freelance_app/bloc/application_bloc/bloc.dart';
import 'package:serategna_freelance_app/presentation/commons/detail.dart';
import 'package:serategna_freelance_app/data_layer/models/application_model.dart';

class ApplicationDetail extends StatefulWidget {
  final ApplicationModel application;

  const ApplicationDetail({Key key, this.application}) : super(key: key);
  @override
  _ApplicationDetailState createState() => _ApplicationDetailState();
}

class _ApplicationDetailState extends State<ApplicationDetail> {
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
          title: Text('Application Detail'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailRow(
                      title: "Job Title:   ",
                      data: widget.application.job["title"],
                    ),
                    DetailRow(
                      title: "Salary:   ",
                      data: widget.application.job["salary"].toString(),
                    ),
                    DetailRow(
                      title: "company:   ",
                      data: widget.application.job["company"],
                    ),
                    DetailRow(
                      title: "Position:   ",
                      data: widget.application.job["position"],
                    ),
                    DetailRow(
                      title: "Description:   ",
                      data: widget.application.job["description"],
                    ),
                    DetailRow(
                      title: "Job Type:   ",
                      data: widget.application.job["jobType"],
                    ),
                    Divider(
                      height: 10,
                      thickness: 2,
                    ),
                    DetailRow(
                        title: 'Applicant',
                        data: widget.application.freelancer["fullName"]),
                    DetailRow(
                        title: 'Status',
                        data:
                            widget.application.applicationStatus.toLowerCase()),
                    DetailRow(
                        title: 'Cover Letter',
                        data: widget.application.coverLetter),
                  ],
                ),
              ),
              BlocListener<ApplicationBloc, ApplicationState>(
                listener: (context, state) {
                  if (state is ApplicationOperationFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${state.message}')));
                  }
                  if (state is ApplicationLoadSuccess) {
                    Navigator.pop(context);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                            fixedSize: MaterialStateProperty.all(Size(
                                MediaQuery.of(context).size.width / 2.5,
                                MediaQuery.of(context).size.height / 17)),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 15))),
                        child: Text(
                            widget.application.applicationStatus == "PENDING"
                                ? "Accept"
                                : "Pend"),
                        onPressed: () {
                          widget.application.applicationStatus == "PENDING"
                              ? BlocProvider.of<ApplicationBloc>(context).add(
                                  ApplicationUpdate(
                                      widget.application, "ACCEPTED"))
                              : BlocProvider.of<ApplicationBloc>(context).add(
                                  ApplicationUpdate(
                                      widget.application, "PENDING"));
                        },
                      ),
                    ),
                    Container(
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                            fixedSize: MaterialStateProperty.all(Size(
                                MediaQuery.of(context).size.width / 2.5,
                                MediaQuery.of(context).size.height / 17)),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 15))),
                        child: Text("Reject"),
                        onPressed: () {
                          BlocProvider.of<ApplicationBloc>(context).add(
                              ApplicationUpdate(
                                  widget.application, "REJECTED"));
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
