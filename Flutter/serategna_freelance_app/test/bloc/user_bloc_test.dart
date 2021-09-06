import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:serategna_freelance_app/bloc/user_bloc/bloc.dart';
import 'package:serategna_freelance_app/data_layer/models/user_model.dart';
import 'package:serategna_freelance_app/data_layer/repository/user_repo.dart';
import 'package:serategna_freelance_app/utils/pref_functions.dart';

class MockUserRepo extends Mock implements UserRepo, LocallyStored {}

void main() {
  MockUserRepo mockUserRepo = MockUserRepo();

  setUp(() {});

  group('User', () {
    final UserModel freelancer = UserModel(
      email: "aa@gmail.com",
      fullName: "Aaa Bbb",
      id: "n43n238n434n34r3n4",
      phoneNumber: "0912345678",
      profession: "app developer",
      token: "suhsdf8bffbdsiufbdsiufbds.dfdsfdsf.fdf",
      role: "FREELANCER",
      password: "123",
    );
    final UserModel employer = UserModel(
      email: "aa@gmail.com",
      fullName: "Aaa Bbb",
      id: "n43n238n434n34r3n4",
      phoneNumber: "0912345678",
      profession: "app developer",
      token: "suhsdf8bffbdsiufbdsiufbds.dfdsfdsf.fdf",
      role: "EMPLOYER",
      password: "123",
    );
    final UserModel admin = UserModel(
      email: "aa@gmail.com",
      fullName: "Aaa Bbb",
      id: "n43n238n434n34r3n4",
      phoneNumber: "0912345678",
      profession: "app developer",
      token: "suhsdf8bffbdsiufbdsiufbds.dfdsfdsf.fdf",
      role: "ADMIN",
      password: "123",
    );
    List<UserModel> freelancerList = [freelancer, freelancer];
    List<UserModel> employerList = [employer, employer];
    blocTest<UserBloc, UserState>(
      'emits [LoadingState(), EmployerLoginSucessState()] when LoginButtonPressed is successful',
      build: () {
        when(mockUserRepo.loginUser(employer))
            .thenAnswer((_) async => Future.value(employer));
        return UserBloc(userRepo: mockUserRepo);
      },
      act: (bloc) {
        bloc.add(LoginButtonPressed(user: employer));
      },
      expect: () => [
        LoadingState(),
        EmployerLoginSucessState(user: employer),
      ],
    );
    blocTest<UserBloc, UserState>(
      'emits [LoadingState(), FreelancerLoginSucessState()] when LoginButtonPressed is successful',
      build: () {
        when(mockUserRepo.loginUser(freelancer))
            .thenAnswer((_) async => Future.value(freelancer));
        return UserBloc(userRepo: mockUserRepo);
      },
      act: (bloc) {
        bloc.add(LoginButtonPressed(user: freelancer));
      },
      expect: () => [
        LoadingState(),
        FreelancerLoginSucessState(user: freelancer),
      ],
    );
    blocTest<UserBloc, UserState>(
      'emits [LoadingState(), AdminLoginSucessState()] when LoginButtonPressed is successful',
      build: () {
        when(mockUserRepo.loginUser(admin))
            .thenAnswer((_) async => Future.value(admin));
        return UserBloc(userRepo: mockUserRepo);
      },
      act: (bloc) {
        bloc.add(LoginButtonPressed(user: admin));
      },
      expect: () => [
        LoadingState(),
        AdminLoginSucessState(user: admin),
      ],
    );
    blocTest<UserBloc, UserState>(
      'emits [LoadingState(), UserRegisterSucessState()] when RegisterButtonPressed is successful',
      build: () {
        when(mockUserRepo.registerUser(freelancer))
            .thenAnswer((_) async => Future.value(freelancer));
        return UserBloc(userRepo: mockUserRepo);
      },
      act: (bloc) {
        bloc.add(RegisterButtonPressed(user: freelancer));
      },
      expect: () => [
        LoadingState(),
        UserRegisterSucessState(),
      ],
    );
    blocTest<UserBloc, UserState>(
      'emits [LoadingState(), UserUpdateSucessState()] when UserSelfUpdate is successful',
      build: () {
        when(mockUserRepo.updateSelf(freelancer))
            .thenAnswer((_) async => Future.value());
        return UserBloc(userRepo: mockUserRepo);
      },
      act: (bloc) {
        bloc.add(UserSelfUpdate(user: freelancer));
      },
      expect: () => [
        LoadingState(),
        UserUpdateSucessState(),
      ],
    );
    blocTest<UserBloc, UserState>(
      'emits [LoadingState(), UsersLoadSucessState(null)] when FreelancerDelete is successful',
      build: () {
        when(mockUserRepo.deleteUser(freelancer.id))
            .thenAnswer((_) async => Future.value());
        return UserBloc(userRepo: mockUserRepo);
      },
      act: (bloc) {
        bloc.add(FreelancerDelete(user: freelancer));
      },
      expect: () => [
        LoadingState(),
        UsersLoadSucessState(null),
      ],
    );
    blocTest<UserBloc, UserState>(
      'emits [LoadingState(), UsersLoadSucessState(null)] when EmployerDelete is successful',
      build: () {
        when(mockUserRepo.deleteUser(employer.id))
            .thenAnswer((_) async => Future.value());
        return UserBloc(userRepo: mockUserRepo);
      },
      act: (bloc) {
        bloc.add(EmployerDelete(user: employer));
      },
      expect: () => [
        LoadingState(),
        UsersLoadSucessState(null),
      ],
    );
    blocTest<UserBloc, UserState>(
      'emits [LoadingState(), LoggedInUserSuccessState()] when LoggedInUser is successful',
      build: () {
        when(mockUserRepo.getUserByID(employer.id))
            .thenAnswer((_) async => Future.value(employer));
        return UserBloc(userRepo: mockUserRepo);
      },
      act: (bloc) {
        bloc.add(LoggedInUser(id: employer.id));
      },
      expect: () => [
        LoadingState(),
        LoggedInUserSuccessState(user: employer),
      ],
    );
    blocTest<UserBloc, UserState>(
      'emits [LoadingState(), UserLoggedOutState()] when Logout is successful',
      build: () {
        when(mockUserRepo.logout()).thenAnswer((_) async => Future.value());
        return UserBloc(userRepo: mockUserRepo);
      },
      act: (bloc) {
        bloc.add(Logout());
      },
      expect: () => [
        LoadingState(),
        UserLoggedOutState(),
      ],
    );
  });
}
