import mongoose from 'mongoose';
const jobSchema = mongoose.Schema(
  {
    employer: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'User',
      required: true,
    },
    title: {
      type: String,
      required: true,
    },
    salary: {
      type: Number,
      required: true,
    },
    company: {
      type: String,
      required: true,
    },
    position: {
      type: String,
      default: 0,
    },
    description: {
      type: String,
      required: true,
    },
    jobType: {
      type: String,
      required: true,
    },
    isAcceptingApplication: {
      type: Boolean,
      default: true,
    },
  },
  {
    timestamps: true,
  }
);

const JobModel = mongoose.model('Job', jobSchema);

export default JobModel;
