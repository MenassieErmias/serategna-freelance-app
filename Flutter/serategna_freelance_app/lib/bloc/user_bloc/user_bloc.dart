import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serategna_freelance_app/constants/constants.dart';
import 'package:serategna_freelance_app/data_layer/repository/user_repo.dart';
import 'package:serategna_freelance_app/bloc/user_bloc/bloc.dart';
import 'package:serategna_freelance_app/utils/pref_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepo userRepo;
  UserBloc({@required this.userRepo}) : super(FormInitState());
  LocallyStored locallyStored = LocallyStored();
  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (event is StartEvent) yield FormInitState();
    if (event is LoginButtonPressed) {
      print("here in login");
      yield LoadingState();
      try {
        final user = await userRepo.loginUser(event.user);
        print('useris $user');
        if (user.role == Constants.ADMIN) {
          pref.setString("token", user.token);
          pref.setString("role", Constants.ADMIN);
          pref.setString("id", user.id);
          yield AdminLoginSucessState(user: user);
        } else if (user.role == Constants.EMPLOYER) {
          pref.setString("token", user.token);
          pref.setString("role", Constants.EMPLOYER);
          pref.setString("id", user.id);
          yield EmployerLoginSucessState(user: user);
        } else {
          pref.setString("token", user.token);
          pref.setString("role", Constants.FREELANCER);
          pref.setString("id", user.id);
          yield FreelancerLoginSucessState(user: user);
        }
      } catch (e) {
        yield UserFailureState(message: '${e}');
      }
    }
    if (event is RegisterButtonPressed) {
      yield LoadingState();
      try {
        await userRepo.registerUser(event.user);
        yield UserRegisterSucessState();
      } catch (e) {
        yield UserFailureState(message: '${e}');
      }
    }
    if (event is EmployersLoad) {
      yield LoadingState();
      try {
        final users = await userRepo.getEmployers();
        // print('user 1 : $users[0]');
        print("on the employer load bloc $users");
        yield UsersLoadSucessState(users);
      } catch (e) {
        yield UserFailureState(message: '${e}');
      }
    }
    if (event is FreelancersLoad) {
      yield LoadingState();
      try {
        final users = await userRepo.getFreelancers();
        // print('user 1 : $users[0]');
        print("on the freelancer load bloc $users");
        yield UsersLoadSucessState(users);
      } catch (e) {
        yield UserFailureState(message: '${e}');
      }
    }
    if (event is UserSelfUpdate) {
      yield LoadingState();
      try {
        await userRepo.updateSelf(event.user);
        yield UserUpdateSucessState();
      } catch (e) {
        yield UserFailureState(message: '${e}');
      }
    }

    if (event is FreelancerDelete) {
      yield LoadingState();
      try {
        await userRepo.deleteUser(event.user.id);
        final users = await userRepo.getFreelancers();
        yield UsersLoadSucessState(users);
      } catch (e) {
        yield UserFailureState(message: '${e}');
      }
    }
    if (event is EmployerDelete) {
      yield LoadingState();
      try {
        print("user id in employerdelete ${event.user.id}");
        await userRepo.deleteUser(event.user.id);
        final users = await userRepo.getEmployers();
        yield UsersLoadSucessState(users);
      } catch (e) {
        yield UserFailureState(message: '${e}');
      }
    }
    if (event is Logout) {
      yield LoadingState();
      try {
        await locallyStored.logout();
        yield UserLoggedOutState();
      } catch (_) {
        yield UserFailureState(message: 'Failed to logout user');
      }
    }

    if (event is LoggedInUser) {
      yield LoadingState();
      try {
        final user = await userRepo.getUserByID(event.id);
        print("loggedin state: $user");
        yield LoggedInUserSuccessState(user: user);
      } catch (e) {
        yield UserFailureState(message: '${e}');
      }
    }
  }
}
