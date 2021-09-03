import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serategna_freelance_app/bloc/application_bloc/bloc.dart';
import 'package:serategna_freelance_app/repository/application_repo.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  final ApplicationRepo applicationRepo;

  ApplicationBloc({@required this.applicationRepo})
      : assert(applicationRepo != null),
        super(ApplicationLoading());

  @override
  Stream<ApplicationState> mapEventToState(ApplicationEvent event) async* {
    if (event is ApplicationLoad) {
      yield ApplicationLoading();
      try {
        final applications = await applicationRepo.getApplications();
        print(applications);
        yield ApplicationLoadSuccess(applications);
      } catch (e) {
        yield ApplicationOperationFailure(message: "$e");
      }
    }
    if (event is ApplicationCreate) {
      try {
        await applicationRepo.createApplication(event.application, event.jobId);
        final applications = await applicationRepo.getApplications();
        yield ApplicationLoadSuccess(applications);
        // yield ApplicationLoadSuccess(applications);
      } catch (e) {
        yield ApplicationOperationFailure(message: "$e");
      }
    }

    if (event is ApplicationUpdate) {
      try {
        await applicationRepo.updateApplication(event.application);
        final applications = await applicationRepo.getApplications();
        yield ApplicationLoadSuccess(applications);
      } catch (e) {
        yield ApplicationOperationFailure(message: "$e");
      }
    }
    if (event is ApplicationDelete) {
      try {
        await applicationRepo.deleteApplication(event.application.id);
        final applications = await applicationRepo.getApplications();
        yield ApplicationLoadSuccess(applications);
      } catch (e) {
        yield ApplicationOperationFailure(message: "$e");
      }
    }
  }
}
