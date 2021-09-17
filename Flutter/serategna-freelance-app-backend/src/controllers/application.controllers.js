import {
  createApplication,
  deleteApplication,
  deleteApplications,
  getAllEmployerPostsApplications,
  getApplication,
  getApplications,
  getJobApplications,
  getOwnApplications,
  updateApplication,
} from '../services/application.services.js';
import { ErrorResponse } from '../utils/errorResponse.js';

async function httpCreateApplication(req, res) {
  console.log(req.body);
  const alreadyApplied = await getApplication({
    $and: [
      {
        jobId: req.body.jobId,
      },
      {
        applicantId: req.user._id,
      },
    ],
  });
  console.log(alreadyApplied);
  if (alreadyApplied) throw new ErrorResponse('you have already applied', 400);

  return res.status(201).json(createApplication(req.body, req.user._id));
}

async function httpGetApplications(req, res) {
  console.log(req.params.query);
  return res.status(200).json(await getApplications());
}

async function httpGetJobApplications(req, res) {
  return res.status(200).json(await getJobApplications(req.params.jobId));
}
async function httpGetOwnApplications(req, res) {
  return res
    .status(200)
    .json(await getOwnApplications(req.params.freelancerId));
}

async function httpGetAllEmployerPostsApplications(req, res) {
  return res
    .status(200)
    .json(await getAllEmployerPostsApplications(req.params.employerId));
}

async function httpGetApplication(req, res) {
  const application = await getApplication({ _id: req.params.id });
  if (!application) {
    throw new ErrorResponse('Application does not exist', 404);
  }
  return res.status(200).json(application);
}

async function httpUpdateApplication(req, res) {
  const application = await getApplication({ _id: req.params.id });
  if (!application) {
    throw new ErrorResponse('Application does not exist', 404);
  }
  return res
    .status(200)
    .json(await updateApplication(application.id, req.body));
}

async function httpDeleteApplication(req, res) {
  const application = await getApplication({ _id: req.params.id });
  if (!application) {
    throw new ErrorResponse('Application does not exist', 404);
  }
  return res.status(200).json(await deleteApplication(req.params.id));
}

async function httpDeleteApplications(req, res) {
  const applicationsExist = await getApplications();
  if (!applicationsExist) {
    throw new ErrorResponse('There is no application', 404);
  }
  return res.status(200).json(await deleteApplications());
}

export {
  httpCreateApplication,
  httpGetApplications,
  httpGetJobApplications,
  httpGetOwnApplications,
  httpGetApplication,
  httpGetAllEmployerPostsApplications,
  httpUpdateApplication,
  httpDeleteApplication,
  httpDeleteApplications,
};
