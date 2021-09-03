import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serategna_freelance_app/bloc/job_bloc/bloc.dart';
import 'package:serategna_freelance_app/repository/job_repo.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final JobRepo jobRepo;

  JobBloc({@required this.jobRepo})
      : assert(jobRepo != null),
        super(JobLoading());

  @override
  Stream<JobState> mapEventToState(JobEvent event) async* {
    if (event is JobLoad) {
      yield JobLoading();
      try {
        final jobs = await jobRepo.getJobs();
        print(jobs);
        yield JobLoadSuccess(jobs);
      } catch (e) {
        yield JobOperationFailure(message: "$e");
      }
    }
    if (event is JobCreate) {
      try {
        await jobRepo.createJob(event.job);
        final jobs = await jobRepo.getJobs();
        yield JobLoadSuccess(jobs);
        // yield JobLoadSuccess(jobs);
      } catch (e) {
        yield JobOperationFailure(message: "$e");
      }
    }

    if (event is JobUpdate) {
      try {
        await jobRepo.updateJob(event.job);
        final jobs = await jobRepo.getJobs();
        yield JobLoadSuccess(jobs);
      } catch (e) {
        yield JobOperationFailure(message: "$e");
      }
    }
    if (event is JobDetail) {
      try {
        final job = await jobRepo.getJobByID(event.id);
        yield JobByIdLoadSuccess(job: job);
      } catch (e) {
        yield JobOperationFailure(message: "$e");
      }
    }
    if (event is JobDelete) {
      try {
        await jobRepo.deleteJob(event.job.id);
        final jobs = await jobRepo.getJobs();
        yield JobLoadSuccess(jobs);
      } catch (e) {
        yield JobOperationFailure(message: "$e");
      }
    }
  }
}
