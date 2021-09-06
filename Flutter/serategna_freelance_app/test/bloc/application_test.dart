import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:serategna_freelance_app/bloc/application_bloc/bloc.dart';
import 'package:serategna_freelance_app/data_layer/models/application_model.dart';
import 'package:serategna_freelance_app/data_layer/repository/application_repo.dart';

class MockApplicationRepo extends Mock implements ApplicationRepo {}

void main() {
  MockApplicationRepo mockApplicationRepo = MockApplicationRepo();
  setUp(() {});
  group('application', () {
    ApplicationModel application = ApplicationModel(
        id: "nsdbyfsd5f",
        coverLetter: "dsfbdsyf",
        applicationStatus: "Pending",
        job: <String, dynamic>{
          "id": "nsdbyfsd5f",
          "title": "sdfubdsfs",
          "description": "dsfbdsyf",
          "position": "sdfysdufs",
          "company": "sndufsdyufgsdy",
          "jobType": 'permanent',
          "salary": 200,
          "employer": <String, dynamic>{
            "fullName": "ans",
            "email": "a.g@com",
            "role": "Employer",
            '_id': 'dsds'
          }
        },
        freelancer: <String, dynamic>{
          "fullName": "ans",
          "email": "a.g@com",
          "role": "Employer",
          '_id': 'dsds'
        });
    List<ApplicationModel> applicationList = [application, application];
    blocTest<ApplicationBloc, ApplicationState>(
      'emits [ApplicationLoading(),ApplicationLoadSuccess()] when ApplicationLoad is added.',
      build: () {
        when(mockApplicationRepo.getApplications())
            .thenAnswer((_) async => applicationList);
        return ApplicationBloc(applicationRepo: mockApplicationRepo);
      },
      act: (bloc) => bloc.add(ApplicationLoad()),
      expect: () =>
          [ApplicationLoading(), ApplicationLoadSuccess(applicationList)],
    );
    blocTest<ApplicationBloc, ApplicationState>(
      'emits [ApplicationLoadSuccess(applicationList)] when ApplicationCreate is added.',
      build: () {
        when(mockApplicationRepo.createApplication(
                application, application.job["id"]))
            .thenAnswer((_) async => application);
        return ApplicationBloc(applicationRepo: mockApplicationRepo);
      },
      act: (bloc) =>
          bloc.add(ApplicationCreate(application, application.job["id"])),
      expect: () => [ApplicationLoadSuccess(applicationList)],
    );
    blocTest<ApplicationBloc, ApplicationState>(
      'emits [ApplicationLoadSuccess(applicationList)] when ApplicationUpdate is added.',
      build: () {
        when(mockApplicationRepo.updateApplication(application, "ACCEPTED"))
            .thenAnswer((_) async => applicationList);
        return ApplicationBloc(applicationRepo: mockApplicationRepo);
      },
      act: (bloc) => bloc.add(ApplicationUpdate(application, "ACCEPTED")),
      expect: () => [ApplicationLoadSuccess(applicationList)],
    );
    blocTest<ApplicationBloc, ApplicationState>(
      'emits [ApplicationLoadSuccess(applicationList)] when ApplicationDelete is added.',
      build: () {
        when(mockApplicationRepo.deleteApplication(application.id))
            .thenAnswer((_) async => Future.value());
        return ApplicationBloc(applicationRepo: mockApplicationRepo);
      },
      act: (bloc) => bloc.add(ApplicationDelete(application: application)),
      expect: () => [ApplicationLoadSuccess(applicationList)],
    );
  });
}
