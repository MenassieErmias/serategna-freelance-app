import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serategna_freelance_app/bloc/user_bloc/bloc.dart';
import 'package:serategna_freelance_app/commons/profile_update_form.dart';
import 'package:serategna_freelance_app/utils/pref_functions.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<void> loadUser() async {
    final userId = await prefUser();
    print("user id is: $userId");
    BlocProvider.of<UserBloc>(context).add(LoggedInUser(id: userId));
  }

  @override
  void initState() {
    loadUser();
    super.initState();
  }

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
        body: BlocConsumer<UserBloc, UserState>(builder: (context, state) {
          if (state is LoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is LoggedInUserSuccessState) {
            final user = state.user;
            print("user is:  $user");
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
                          '\n' +
                          'profession: ' +
                          user.profession !=
                      null
                  ? user.profession
                  : "" + '\n'),
              subtitle: Column(
                children: <Widget>[
                  Container(
                      child: Row(
                    children: <Widget>[
                      FlatButton(
                        color: Colors.cyan,
                        child: Text("Edit"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProfileUpdateForm(user: user)));
                        },
                      ),
                    ],
                  ))
                ],
              ),
              leading: CircleAvatar(
                child: Text(user.fullName.substring(0, 1).toUpperCase()),
                // backgroundImage: AssetImage('assets/${locations[index].flag}'),
              ),
            );
          }
          return Container();
        }, listener: (context, state) {
          if (state is UserFailureState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('${state.message}')));
          }
        }));
  }
}
