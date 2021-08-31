import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serategna_freelance_app/auth/login_screen.dart';
import 'package:serategna_freelance_app/auth/userForm.dart';
import 'package:serategna_freelance_app/bloc/user_bloc/bloc.dart';

class Register extends StatelessWidget {
  static String routeName = '/register';
  @override
  Widget build(BuildContext context) {
    final msg = BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is LoadingState)
        return Center(
          child: CircularProgressIndicator(),
        );
      else
        return Container();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserRegisterSucessState)
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false);
          if (state is UserFailureState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('${state.message}')));
          }
        },
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 24),
            children: [
              UserForm(
                login: false,
              ),
              msg,
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginPage.routeName);
                  },
                  child: Text('Already have an account? Login'))
            ],
          ),
        ),
      ),
    );
  }
}
