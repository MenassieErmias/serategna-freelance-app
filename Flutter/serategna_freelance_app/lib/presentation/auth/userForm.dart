import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serategna_freelance_app/data_layer/models/user_model.dart';
import 'package:serategna_freelance_app/bloc/user_bloc/bloc.dart';

class UserForm extends StatefulWidget {
  UserForm({this.login});
  final bool login;
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> userData = {};
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              !this.widget.login
                  ? TextFormField(
                      validator: (value) {
                        if (value.isEmpty || value.length < 6) {
                          return 'Please enter a valid name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'name'),
                      onSaved: (value) {
                        setState(() {
                          userData["fullName"] = value;
                        });
                      })
                  : SizedBox.shrink(),
              TextFormField(
                  validator: (value) {
                    if (value.isEmpty ||
                        value.length < 6 ||
                        !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'email'),
                  onSaved: (value) {
                    setState(() {
                      userData["email"] = value;
                    });
                  }),
              TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty || value.length < 6) {
                      return 'Please enter a valid password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'password'),
                  onSaved: (value) {
                    setState(() {
                      userData["password"] = value;
                    });
                  }),
              TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty || value.length < 3) {
                      return 'Please enter a valid role';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'role'),
                  onSaved: (value) {
                    setState(() {
                      userData["role"] = value;
                    });
                  }),
              TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty || value.length < 3) {
                      return 'Please enter a valid profession';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'profession'),
                  onSaved: (value) {
                    setState(() {
                      userData["profession"] = value;
                    });
                  }),
              TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty || value.length < 6) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'phone number'),
                  onSaved: (value) {
                    setState(() {
                      userData["phoneNumber"] = value;
                    });
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    print("userData=> $userData");
                    final form = _formKey.currentState;
                    if (form.validate()) {
                      form.save();
                      final UserEvent event = RegisterButtonPressed(
                          user: UserModel(
                        fullName: userData["fullName"],
                        phoneNumber: userData["phoneNumber"],
                        password: userData["password"],
                        email: userData["email"],
                        role: userData["role"],
                        profession: userData["profession"],
                      ));
                      BlocProvider.of<UserBloc>(context).add(event);
                    }
                  },
                  label: this.widget.login ? Text("Login") : Text("Register"),
                  icon: this.widget.login
                      ? Icon(Icons.login)
                      : Icon(Icons.app_registration),
                ),
              ),
            ],
          )),
    );
  }
}
