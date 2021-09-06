import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serategna_freelance_app/bloc/user_bloc/bloc.dart';
import 'package:serategna_freelance_app/presentation/commons/profile_update_form.dart';
import 'package:serategna_freelance_app/presentation/commons/users_list.dart';
import 'package:serategna_freelance_app/utils/pref_functions.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  LocallyStored locallyStored = LocallyStored();
  Future<void> loadUser() async {
    final userId = await locallyStored.prefUser();
    BlocProvider.of<UserBloc>(context).add(LoggedInUser(id: userId));
  }

  @override
  void initState() {
    print("init");
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
            print("loading");
            return Center(child: CircularProgressIndicator());
          }
          if (state is LoggedInUserSuccessState) {
            print("loaded");
            final user = state.user;
            return ListTile(
              onTap: () {},
              title: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  UsersList(
                    text: "fullName: ",
                    value: user.fullName,
                  ),
                  UsersList(
                    text: "Email: ",
                    value: user.email,
                  ),
                  UsersList(
                    text: "Profession: ",
                    value: user.profession != null ? user.profession : "",
                  ),
                  UsersList(
                    text: "Phone Number: ",
                    value: user.phoneNumber,
                  ),
                  UsersList(
                    text: "Role: ",
                    value: user.role,
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
              subtitle: FlatButton(
                color: Colors.cyan,
                child: Text("Edit"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileUpdateForm(user: user)));
                },
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
