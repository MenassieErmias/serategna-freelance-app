import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serategna_freelance_app/repository/user_repo.dart';
import 'package:serategna_freelance_app/user_bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepo userRepo;
  UserBloc({@required this.userRepo})
      : assert(userRepo != null),
        super(FormInitState());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (event is StartEvent) yield FormInitState();
    if (event is LoginButtonPressed) {
      yield LoadingState();
      try {
        final user = await userRepo.loginUser(event.user);
        print('useris $user');
        if (user.role == "ADMIN") {
          pref.setString("token", user.token);
          pref.setString("role", "ADMIN");
          pref.setString("id", user.id);
          yield AdminLoginSucessState(user: user);
        } else if (user.role == "EMPLOYER") {
          pref.setString("token", user.token);
          pref.setString("role", "EMPLOYER");
          pref.setString("id", user.id);
          yield EmployerLoginSucessState(user: user);
        } else {
          pref.setString("token", user.token);
          pref.setString("role", "FREELANCER");
          pref.setString("id", user.id);
          yield FreelancerLoginSucessState(user: user);
        }
      } catch (e) {
        yield UserFailureState(message: '${e.message}');
      }
    }
    if (event is RegisterButtonPressed) {
      yield LoadingState();
      try {
        await userRepo.registerUser(event.user);
        final users = await userRepo.getUsers();
        yield UsersLoadSucessState(users);
        yield UserRegisterSucessState();
      } catch (e) {
        yield UserFailureState(message: '${e.message}');
      }
    }
    if (event is UsersLoad) {
      yield LoadingState();
      try {
        final users = await userRepo.getUsers();
        // print('user 1 : $users[0]');
        print("on the user load bloc $users");
        yield UsersLoadSucessState(users);
      } catch (e) {
        yield UserFailureState(message: '${e.message}');
      }
    }
    if (event is UserUpdate) {
      yield LoadingState();
      try {
        await userRepo.updateUser(event.user);
        final users = await userRepo.getUsers();
        yield UsersLoadSucessState(users);
      } catch (e) {
        yield UserFailureState(message: '${e.message}');
      }
    }
    if (event is UserSelfUpdate) {
      yield LoadingState();
      try {
        await userRepo.updateSelf(event.user);
      } catch (e) {
        yield UserFailureState(message: '${e.message}');
      }
    }

    if (event is UserDelete) {
      yield LoadingState();
      try {
        await userRepo.deleteUser(event.user.id);
        final users = await userRepo.getUsers();
        yield UsersLoadSucessState(users);
      } catch (e) {
        yield UserFailureState(message: '${e.message}');
      }
    }

    if (event is LoggedInUser) {
      try {
        final user = await userRepo.getUserByID(event.id);
        print("loggedin state: $user");
        yield LoggedInUserSuccessState(user: user);
      } catch (e) {
        yield UserFailureState(message: '${e.message}');
      }
    }
  }
}
