import 'package:meta/meta.dart';
import 'package:serategna_freelance_app/data_provider/application_data_provider.dart';
import 'package:serategna_freelance_app/models/application_model.dart';

class ApplicationRepo {
  final ApplicationDataProvider applicationDataProvider;
  ApplicationRepo({@required this.applicationDataProvider});

  Future<ApplicationModel> getApplicationByID(String id) async {
    return applicationDataProvider.getApplicationByID(id);
  }

  Future<ApplicationModel> createApplication(
      ApplicationModel application, String jobId) async {
    return applicationDataProvider.createApplication(application, jobId);
  }

  Future<void> updateApplication(ApplicationModel application) async {
    return applicationDataProvider.updateApplication(application);
  }

  Future<void> deleteApplication(String id) async {
    return applicationDataProvider.deleteApplication(id);
  }

  Future<List<ApplicationModel>> getApplications() async {
    return applicationDataProvider.getApplications();
  }

  Future<List<ApplicationModel>> getJobApplications(String jobId) async {
    return applicationDataProvider.getJobApplications(jobId);
  }
}
