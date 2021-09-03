import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serategna_freelance_app/bloc/user_bloc/bloc.dart';

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
                    title: Text('\nName: ' +
                        users[index].fullName +
                        '\n'
                            'Profession: ' +
                        users[index].profession +
                        '\n'
                            'Role: ' +
                        users[index].role +
                        '\n'
                            'Phone Number: ' +
                        users[index].phoneNumber +
                        '\n'
                            'Email: ' +
                        users[index].email +
                        '\n'),
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
