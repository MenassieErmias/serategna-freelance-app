import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:serategna_freelance_app/presentation/admin/admin_bottom_navigation.dart';
import 'package:serategna_freelance_app/presentation/auth/sign_up_screen.dart';
import 'package:serategna_freelance_app/presentation/employer/employer_bottom_navigation.dart';
import 'package:serategna_freelance_app/presentation/freelancer/freelancer_bottom_navigation.dart';
import 'package:serategna_freelance_app/data_layer/models/user_model.dart';
import 'package:serategna_freelance_app/bloc/user_bloc/bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  bool loading = false;
  bool _showPassword = false;
  String email = "";
  String password = "";
  String _error = '';
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;

    // void _showError(String error, context) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text(error),
    //     backgroundColor: Theme.of(context).errorColor,
    //   ));
    // }

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is FreelancerLoginSucessState)
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FreelancerBottomNavigationBar()),
                  (route) => false);
            if (state is AdminLoginSucessState)
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AdminBottomNavigationBar()),
                  (route) => false);
            if (state is EmployerLoginSucessState)
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EmployerBottomNavigationBar()),
                  (route) => false);
            if (state is UserFailureState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('${state.message}')));
            }
          },
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildEmailTextField(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        _buildPasswordTextField(),
                        SizedBox(height: 30),
                        _submitButton(context),
                        SizedBox(height: 5),
                        _createAccountLabel(),
                      ],
                    ),
                  ),
                )),
          ]),
        ));
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => SignUpPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(5),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: Color(0xff4064f3),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      controller: _emailController,
      onChanged: (value) {
        setState(() => email = value);
      },
      //validator: (value) => !isEmail(),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        prefixIcon: Icon(
          Icons.alternate_email,
          color: Theme.of(context).iconTheme.color,
        ),
        border: InputBorder.none,
        filled: true,
        fillColor: Theme.of(context).cardTheme.color,
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      controller: _passwordController,
      validator: (value) =>
          value.length < 6 ? 'Incorrect Email and/or Password' : null,
      onChanged: (value) {
        setState(() => password = value);
      },
      obscureText: !this._showPassword,
      decoration: InputDecoration(
        labelText: 'Password',
        focusColor: Color(0xff4064f3),
        border: InputBorder.none,
        filled: true,
        fillColor: Theme.of(context).cardTheme.color,
        prefixIcon: Icon(
          Icons.security,
          color: Theme.of(context).iconTheme.color,
        ),
        suffixIcon: IconButton(
          icon: this._showPassword
              ? FaIcon(FontAwesomeIcons.eye)
              : FaIcon(FontAwesomeIcons.eyeSlash),
          color: Theme.of(context).iconTheme.color,
          onPressed: () {
            setState(() => this._showPassword = !this._showPassword);
          },
        ),
      ),
    );
  }

  Widget _submitButton(context) {
    return InkWell(
      onTap: () {
        final form = _formKey.currentState;
        if (form.validate()) {
          print('validated');
          form.save();
          BlocProvider.of<UserBloc>(context).add(LoginButtonPressed(
              user: UserModel(
            password: password,
            email: email,
          )));
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.blue, Colors.purple])),
        child: Text('Login',
            style: TextStyle(color: Colors.white, fontSize: 18.0)),
      ),
    );
  }
}
