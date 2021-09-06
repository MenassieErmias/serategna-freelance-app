import {
  createJob,
  deleteJob,
  deleteJobs,
  getJob,
  getJobs,
  getOwnJobs,
  updateJob,
} from '../services/jobs.services.js';
import { ErrorResponse } from '../utils/errorResponse.js';
async function httpCreateJob(req, res) {
  console.log(req.body);
  res.status(201).json(await createJob(req.body, req.user._id));
}

async function httpGetJobs(req, res) {
  console.log(await getJobs());
  res.status(200).json(await getJobs());
}
async function httpOwnGetJobs(req, res) {
  console.log(await getOwnJobs(req.params.employerId));
  res.status(200).json(await getOwnJobs(req.params.employerId));
}

async function httpGetJob(req, res) {
  const jobExists = await getJob({ _id: req.params.id });
  if (!jobExists) {
    throw new ErrorResponse('Job does not exist', 404);
  }
  res.status(200).json(await getJob(req.params.id));
}

async function httpUpdateJob(req, res) {
  console.log('id' + req.user._id);
  const Job = await getJob(req.params.id);
  if (!Job) {
    throw new ErrorResponse('Job does not exist', 404);
  }
  if (Job.employer._id.toString() !== req.user._id.toString())
    throw new ErrorResponse("You're not authorized to do this", 403);

  res.status(200).json(await updateJob(Job.id, req.body));
}

async function httpDeleteJob(req, res) {
  const jobExists = await getJob({ _id: req.params.id });
  if (!jobExists) {
    throw new ErrorResponse('Job does not exist', 404);
  }
  res.status(200).json(await deleteJob(req.params.id));
}

async function httpDeleteJobs(req, res) {
  res.status(200).json(await deleteJobs());
}

export {
  httpCreateJob,
  httpUpdateJob,
  httpGetJobs,
  httpOwnGetJobs,
  httpGetJob,
  httpDeleteJob,
  httpDeleteJobs,
};
