import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:serategna_freelance_app/bloc/job_bloc/bloc.dart';
import 'package:serategna_freelance_app/data_layer/models/job_model.dart';
import 'package:serategna_freelance_app/data_layer/repository/job_repo.dart';

class MockJobRepo extends Mock implements JobRepo {}

void main() {
  MockJobRepo mockJobRepo = MockJobRepo();
  setUp(() {});
  group('job', () {
    JobModel job = JobModel(
        id: "nsdbyfsd5f",
        title: "sdfubdsfs",
        description: "dsfbdsyf",
        position: "sdfysdufs",
        company: "sndufsdyufgsdy",
        jobType: 'permanent',
        salary: 200,
        employer: <String, dynamic>{
          "fullName": "ans",
          "email": "a.g@com",
          "role": "Employer",
          '_id': 'dsds'
        });
    List<JobModel> jobList = [job, job];
    blocTest<JobBloc, JobState>(
      'emits [JobLoading(),JobLoadSuccess()] when JobLoad is added.',
      build: () {
        when(mockJobRepo.getJobs()).thenAnswer((_) async => jobList);
        return JobBloc(jobRepo: mockJobRepo);
      },
      act: (bloc) => bloc.add(JobLoad()),
      expect: () => [JobLoading(), JobLoadSuccess(jobList)],
    );
    blocTest<JobBloc, JobState>(
      'emits [JobLoadSuccess(jobList)] when JobCreate is added.',
      build: () {
        when(mockJobRepo.createJob(job)).thenAnswer((_) async => job);
        return JobBloc(jobRepo: mockJobRepo);
      },
      act: (bloc) => bloc.add(JobCreate(job)),
      expect: () => [JobLoadSuccess(jobList)],
    );
    blocTest<JobBloc, JobState>(
      'emits [JobLoadSuccess(jobList)] when JobUpdate is added.',
      build: () {
        when(mockJobRepo.updateJob(job)).thenAnswer((_) async => jobList);
        return JobBloc(jobRepo: mockJobRepo);
      },
      act: (bloc) => bloc.add(JobUpdate(job)),
      expect: () => [JobLoadSuccess(jobList)],
    );
    blocTest<JobBloc, JobState>(
      'emits [JobByIdLoadSuccess(job)] when JobDetail is added.',
      build: () {
        when(mockJobRepo.getJobByID(job.id)).thenAnswer((_) async => job);
        return JobBloc(jobRepo: mockJobRepo);
      },
      act: (bloc) => bloc.add(JobDetail(job.id)),
      expect: () => [JobByIdLoadSuccess(job: job)],
    );
    blocTest<JobBloc, JobState>(
      'emits [JobLoadSuccess(jobList)] when JobDelete is added.',
      build: () {
        when(mockJobRepo.deleteJob(job.id))
            .thenAnswer((_) async => Future.value());
        return JobBloc(jobRepo: mockJobRepo);
      },
      act: (bloc) => bloc.add(JobDelete(job: job)),
      expect: () => [JobLoadSuccess(jobList)],
    );
  });
}
