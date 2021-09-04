import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serategna_freelance_app/bloc/user_bloc/bloc.dart';
import 'package:serategna_freelance_app/commons/users_list.dart';

class AdminFreelancersList extends StatefulWidget {
  @override
  _AdminFreelancersListState createState() => _AdminFreelancersListState();
}

class _AdminFreelancersListState extends State<AdminFreelancersList> {
  @override
  void initState() {
    BlocProvider.of<UserBloc>(context).add(FreelancersLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text('Freelancers'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocConsumer<UserBloc, UserState>(listener: (context, state) {
        if (state is UserFailureState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${state.message}')));
        }
      }, builder: (context, state) {
        if (state is LoadingState) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.indigo,
            ),
          );
        }
        if (state is UsersLoadSucessState) {
          final users = state.users;
          return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 1.0, horizontal: 4.0),
                  child: ListTile(
                    onTap: () {},
                    title: Column(
                      children: [
                        UsersList(
                          text: "Name:  ",
                          value: users[index].fullName,
                        ),
                        UsersList(
                          text: "Email:  ",
                          value: users[index].email,
                        ),
                        UsersList(
                            text: "Profession:  ",
                            value: users[index].profession != null
                                ? users[index].profession
                                : ""),
                        UsersList(
                          text: "Role:  ",
                          value: users[index].role.toLowerCase(),
                        ),
                        UsersList(
                          text: "Phone Number:  ",
                          value: users[index].phoneNumber,
                        ),
                      ],
                    ),
                    subtitle: Container(
                        child: Row(
                      children: <Widget>[
                        FlatButton(
                          color: Colors.red[400],
                          child: Text("Remove"),
                          onPressed: () {
                            BlocProvider.of<UserBloc>(context)
                                .add(FreelancerDelete(user: users[index]));
                          },
                        ),
                      ],
                    )),
                    leading: CircleAvatar(
                        // backgroundImage: AssetImage('assets/${locations[index].flag}'),
                        ),
                  ),
                );
              });
        }
        return Container();
      }),
    );
  }
}
