import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serategna_freelance_app/bloc/application_bloc/bloc.dart';
import 'package:serategna_freelance_app/bloc/user_bloc/bloc.dart';
import 'package:serategna_freelance_app/models/application_model.dart';

class Apply extends StatefulWidget {
  final bool apply;
  final ApplicationModel application;
  final String jobId;
  const Apply({Key key, this.apply, this.application, this.jobId})
      : super(key: key);

  @override
  _ApplyState createState() => _ApplyState();
}

class _ApplyState extends State<Apply> {
  final _formKey = GlobalKey<FormState>();

  Map<String, dynamic> applicationData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Details'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 100, 30, 50),
            child: BlocListener<ApplicationBloc, ApplicationState>(
              listener: (context, state) {
                if (state is ApplicationOperationFailure) {
                  if (state is ApplicationOperationFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${state.message}')));
                  }
                }
                if (state is ApplicationLoadSuccess) {
                  Navigator.pop(context);
                }
              },
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Apply.',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      maxLines: 10,
                      initialValue: this.widget.apply
                          ? ""
                          : this.widget.application.coverLetter,
                      decoration: InputDecoration(
                        labelText:
                            'Introduce yourself and explain why you are qualified for this job',
                        hintText: 'Cover Letter',
                        focusColor: Color(0xff4064f3),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Theme.of(context).cardTheme.color,
                      ),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter your cover letter' : null,
                      onSaved: (val) =>
                          setState(() => applicationData["coverLetter"] = val),
                    ),
                    SizedBox(height: 10.0),
                    RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        color: Colors.green[400],
                        child: Text(
                          this.widget.apply ? 'Post' : 'update',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          final form = _formKey.currentState;
                          if (form.validate()) {
                            print('coverLetter:, desciption: , ');

                            form.save();
                            ApplicationModel applicationModel =
                                ApplicationModel(
                              id: this.widget.application != null
                                  ? this.widget.application.id
                                  : "",
                              coverLetter: applicationData["coverLetter"],
                            );
                            ApplicationEvent event = this.widget.apply
                                ? ApplicationCreate(
                                    applicationModel, this.widget.jobId)
                                : ApplicationUpdate(applicationModel);
                            BlocProvider.of<ApplicationBloc>(context)
                                .add(event);
                          }
                        }),
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
