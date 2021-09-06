import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serategna_freelance_app/bloc/user_bloc/bloc.dart';
import 'package:serategna_freelance_app/data_layer/models/user_model.dart';

class ProfileUpdateForm extends StatefulWidget {
  final UserModel user;
  const ProfileUpdateForm({Key key, this.user}) : super(key: key);

  @override
  _ProfileUpdateFormState createState() => _ProfileUpdateFormState();
}

class _ProfileUpdateFormState extends State<ProfileUpdateForm> {
  final _formKey = GlobalKey<FormState>();

  Map<String, dynamic> userData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        title: Text('Update profile'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 100, 30, 50),
            child: BlocListener<UserBloc, UserState>(
              listener: (context, state) {
                if (state is UserFailureState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${state.message}')));
                }

                if (state is UserUpdateSucessState) {
                  Navigator.pop(context);
                }
              },
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: this.widget.user.fullName,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        focusColor: Color(0xff4064f3),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Theme.of(context).cardTheme.color,
                      ),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter your name' : null,
                      onSaved: (val) =>
                          setState(() => userData["fullName"] = val),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: this.widget.user.email,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        focusColor: Color(0xff4064f3),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Theme.of(context).cardTheme.color,
                      ),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter your email' : null,
                      onSaved: (val) => setState(() => userData["email"] = val),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: this.widget.user.profession,
                      decoration: InputDecoration(
                        labelText: 'Profession',
                        focusColor: Color(0xff4064f3),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Theme.of(context).cardTheme.color,
                      ),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter your profession' : null,
                      onSaved: (val) =>
                          setState(() => userData["profession"] = val),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: this.widget.user.phoneNumber,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        focusColor: Color(0xff4064f3),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Theme.of(context).cardTheme.color,
                      ),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter your phone number' : null,
                      onSaved: (val) =>
                          setState(() => userData["phoneNumber"] = val),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: this.widget.user.password,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        focusColor: Color(0xff4064f3),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Theme.of(context).cardTheme.color,
                      ),
                      validator: (val) {
                        if (!val.isEmpty && val.length < 6) {
                          return 'Please enter a valid password';
                        }
                        if (val.isEmpty) {
                          setState(() {
                            val = null;
                          });
                        }
                        return null;
                      },
                      onSaved: (val) =>
                          setState(() => userData["password"] = val),
                    ),
                    SizedBox(height: 10.0),
                    RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        color: Colors.green[400],
                        child: Text(
                          'update',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          final form = _formKey.currentState;
                          if (form.validate()) {
                            print("password: ${userData["password"]}");
                            form.save();
                            UserModel userModel = UserModel(
                              id: widget.user.id,
                              fullName: userData["fullName"],
                              email: userData["email"],
                              profession: userData["profession"],
                              phoneNumber: userData["phoneNumber"],
                              password: userData["password"] != null
                                  ? userData["password"]
                                  : null,
                            );
                            UserEvent event = UserSelfUpdate(user: userModel);
                            BlocProvider.of<UserBloc>(context).add(event);
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
