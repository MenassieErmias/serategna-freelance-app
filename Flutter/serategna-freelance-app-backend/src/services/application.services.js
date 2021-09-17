import ApplicationModel from '../models/application.mongoose.js';
import { getFilterdJob } from './jobs.services.js';
import { getUser } from './user.services.js';

async function createApplication(body, freelancerId) {
  const job = await getFilterdJob({ _id: body.jobId });
  return ApplicationModel.create({
    ...body,
    freelancerId,
    employerId: job.employer['_id'],
  });
}

async function getApplications() {
  return ApplicationModel.find().populate('freelancerId').populate('jobId');
}

async function getJobApplications(jobId) {
  return ApplicationModel.find({ jobId: jobId })
    .populate('freelancerId')
    .populate('jobId');
}

async function getOwnApplications(freelancerId) {
  return ApplicationModel.find({ freelancerId })
    .populate('freelancerId')
    .populate('jobId');
}

async function getAllEmployerPostsApplications(employerId) {
  return ApplicationModel.find({ employerId: employerId })
    .populate('freelancerId')
    .populate({ path: 'jobId', populate: { path: 'employer' } });
}

async function getApplication(filter) {
  return ApplicationModel.findOne(filter)
    .populate('freelancerId')
    .populate('jobId');
}

async function updateApplication(id, body) {
  return ApplicationModel.updateOne({ _id: id }, body);
}

async function deleteApplication(id) {
  return ApplicationModel.findByIdAndDelete(id);
}

async function deleteApplications() {
  return ApplicationModel.deleteMany();
}
export {
  createApplication,
  getApplications,
  getJobApplications,
  getOwnApplications,
  getAllEmployerPostsApplications,
  getApplication,
  updateApplication,
  deleteApplication,
  deleteApplications,
};
