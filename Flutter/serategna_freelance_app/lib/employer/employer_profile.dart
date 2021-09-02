import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serategna_freelance_app/bloc/job_bloc/bloc.dart';
import 'package:serategna_freelance_app/bloc/job_bloc/job_bloc.dart';
import 'package:serategna_freelance_app/bloc/user_bloc/bloc.dart';
import 'package:serategna_freelance_app/models/employer_list.dart';

class EmployerProfile extends StatefulWidget {
  @override
  _EmployerProfileState createState() => _EmployerProfileState();
}

class _EmployerProfileState extends State<EmployerProfile> {
  List<EmployersList> employers = [
    EmployersList(
        name: 'Abebe Beso',
        profession: 'Graphic Designer',
        phoneNumber: '0912457856',
        email: 'abebe@beso.com'),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        title: Text('Profile'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is LoggedInUserSuccessState) {
            final user = state.user;
            return ListTile(
              onTap: () {},
              title: Text('\nName: ' +
                  user.fullName +
                  '\n'
                      'Role: ' +
                  user.role +
                  '\n'
                      'Phone Number: ' +
                  user.phoneNumber +
                  '\n'
                      'email: ' +
                  user.email +
                  '\n'),
              subtitle: Column(
                children: <Widget>[
                  Container(
                      child: Row(
                    children: <Widget>[
                      FlatButton(
                        color: Colors.cyan,
                        child: Text("Edit"),
                        onPressed: () {},
                      ),
                    ],
                  ))
                ],
              ),
              leading: CircleAvatar(
                  // backgroundImage: AssetImage('assets/${locations[index].flag}'),
                  ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
