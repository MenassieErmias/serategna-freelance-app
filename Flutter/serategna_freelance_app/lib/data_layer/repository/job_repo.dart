import 'package:meta/meta.dart';
import 'package:serategna_freelance_app/data_layer/data_provider/job_data_provider.dart';
import 'package:serategna_freelance_app/data_layer/models/job_model.dart';

class JobRepo {
  final JobDataProvider jobDataProvider;
  JobRepo({@required this.jobDataProvider});

  Future<JobModel> getJobByID(String id) async {
    return jobDataProvider.getJobByID(id);
  }

  Future<void> createJob(JobModel job) async {
    return jobDataProvider.createJob(job);
  }

  Future<void> updateJob(JobModel job) async {
    return jobDataProvider.updateJob(job);
  }

  Future<void> deleteJob(String id) async {
    return jobDataProvider.deleteJob(id);
  }

  Future<List<JobModel>> getJobs() async {
    return jobDataProvider.getJobs();
  }
}
