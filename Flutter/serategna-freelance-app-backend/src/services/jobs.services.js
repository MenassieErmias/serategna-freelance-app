import JobModel from '../models/jobs.mongoose.js';

async function createJob(body, employer) {
  return JobModel.create({
    ...body,
    employer,
  });
}

async function getJobs() {
  return JobModel.find().populate('employer', 'id fullName role email');
}

async function getOwnJobs(employer) {
  return JobModel.find({ employer }).populate(
    'employer',
    'id fullName role email'
  );
}

async function getFilterdJob(filter) {
  return JobModel.findOne(filter).populate('employer', 'id');
}

async function getJob(id) {
  return JobModel.findById(id).populate('employer', 'id fullName role email');
}

async function updateJob(id, body) {
  return JobModel.updateOne({ _id: id }, body);
}

async function deleteJob(id) {
  return JobModel.findByIdAndDelete(id);
}

async function deleteJobs() {
  return JobModel.deleteMany();
}

export {
  createJob,
  getJobs,
  getOwnJobs,
  getJob,
  getFilterdJob,
  updateJob,
  deleteJob,
  deleteJobs,
};
