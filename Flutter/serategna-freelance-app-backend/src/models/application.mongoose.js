import mongoose from 'mongoose';
import { STATUS } from '../constants/enums.constants.js';

const applicationSchema = mongoose.Schema(
  {
    jobId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Job',
      required: true,
    },
    freelancerId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'User',
      required: true,
    },
    employerId: {
      type: String,
      required: true,
    },
    coverLetter: {
      type: String,
      required: true,
    },
    applicationStatus: {
      type: String,
      default: STATUS.PENDING,
      enum: Object.values(STATUS),
    },
  },
  {
    timestamps: true,
  }
);

const ApplicationModel = mongoose.model('Application', applicationSchema);

export default ApplicationModel;
