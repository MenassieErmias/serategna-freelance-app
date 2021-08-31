import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serategna_freelance_app/bloc/job_bloc/bloc.dart';
import 'package:serategna_freelance_app/bloc/user_bloc/bloc.dart';
import 'package:serategna_freelance_app/models/job_model.dart';

class AddJob extends StatefulWidget {
  final bool createJob;
  final JobModel job;

  const AddJob({Key key, this.createJob, this.job}) : super(key: key);

  @override
  _AddJobState createState() => _AddJobState();
}

class _AddJobState extends State<AddJob> {
  final _formKey = GlobalKey<FormState>();

  // form values
  String _currentName;
  String _currentBrand;
  String _currentManufacturingCompany;
  String _currentPrice;
  String _currentDescription;
  String _currentManufactringDate;
  String _currentExpireDate;
  String docId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 100, 30, 50),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Add a new Job.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue:
                        this.widget.createJob ? "" : this.widget.job.title,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      focusColor: Color(0xff4064f3),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Theme.of(context).cardTheme.color,
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Please Enter Title' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue:
                        this.widget.createJob ? "" : this.widget.job.salary,
                    decoration: InputDecoration(
                      labelText: 'Salary',
                      focusColor: Color(0xff4064f3),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Theme.of(context).cardTheme.color,
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Please Enter Salary' : null,
                    onChanged: (val) => setState(() => _currentPrice = val),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue:
                        this.widget.createJob ? "" : this.widget.job.company,
                    decoration: InputDecoration(
                      labelText: 'Company',
                      focusColor: Color(0xff4064f3),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Theme.of(context).cardTheme.color,
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Please enter Company Name' : null,
                    onChanged: (val) =>
                        setState(() => _currentManufacturingCompany = val),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue:
                        this.widget.createJob ? "" : this.widget.job.position,
                    decoration: InputDecoration(
                      labelText: 'Position',
                      focusColor: Color(0xff4064f3),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Theme.of(context).cardTheme.color,
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Please Enter Position' : null,
                    onChanged: (val) => setState(() => _currentBrand = val),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue: this.widget.createJob
                        ? ""
                        : this.widget.job.description,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      focusColor: Color(0xff4064f3),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Theme.of(context).cardTheme.color,
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Please enter Description' : null,
                    onChanged: (val) =>
                        setState(() => _currentDescription = val),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue:
                        this.widget.createJob ? "" : this.widget.job.jobType,
                    decoration: InputDecoration(
                      labelText: 'Job Type',
                      focusColor: Color(0xff4064f3),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Theme.of(context).cardTheme.color,
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Please enter Job Type' : null,
                    onChanged: (val) =>
                        setState(() => _currentManufactringDate = val),
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 160),
                      color: Colors.green[400],
                      child: Text(
                        'Post',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        final form = _formKey.currentState;
                        if (form.validate()) {
                          print(
                              'title:$_currentName, desciption: $_currentDescription, ');

                          form.save();
                          JobModel jobModel = JobModel(
                              title: _currentName,
                              description: _currentDescription,
                              salary: int.parse(_currentPrice),
                              company: _currentManufacturingCompany,
                              jobType: _currentManufactringDate,
                              position: _currentBrand);
                          JobEvent event = this.widget.createJob
                              ? JobCreate(jobModel)
                              : JobUpdate(jobModel);
                          BlocProvider.of<JobBloc>(context).add(event);
                          Navigator.pop(context);
                        }
                      }),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
