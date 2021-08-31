import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serategna_freelance_app/bloc/job_bloc/bloc.dart';
import 'package:serategna_freelance_app/repository/job_repo.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final JobRepo jobRepository;

  JobBloc({@required this.jobRepository})
      : assert(jobRepository != null),
        super(JobLoading());

  @override
  Stream<JobState> mapEventToState(JobEvent event) async* {
    if (event is JobLoad) {
      yield JobLoading();
      try {
        final jobs = await jobRepository.getJobs();
        yield JobLoadSuccess(jobs);
      } catch (e) {
        yield JobOperationFailure(message: "$e");
      }
    }
    if (event is JobCreate) {
      try {
        await jobRepository.createJob(event.job);
        final jobs = await jobRepository.getJobs();
        yield JobLoadSuccess(jobs);
        // yield JobLoadSuccess(jobs);
      } catch (e) {
        yield JobOperationFailure(message: "$e");
      }
    }

    if (event is JobUpdate) {
      try {
        await jobRepository.updateJob(event.job);
        final jobs = await jobRepository.getJobs();
        yield JobLoadSuccess(jobs);
      } catch (e) {
        yield JobOperationFailure(message: "$e");
      }
    }
    if (event is JobDelete) {
      try {
        await jobRepository.deleteJob(event.job.id);
        final jobs = await jobRepository.getJobs();
        yield JobLoadSuccess(jobs);
      } catch (e) {
        yield JobOperationFailure(message: "$e");
      }
    }
  }
}
