import mongoose from 'mongoose';
import { ROLE } from '../constants/enums.constants.js';
const userSchema = mongoose.Schema(
  {
    fullName: {
      type: String,
      required: true,
    },
    email: {
      type: String,
      required: true,
      unique: true,
    },
    password: {
      type: String,
      required: true,
    },
    profession: {
      type: String,
    },
    role: {
      type: String,
      required: true,
      enum: Object.values(ROLE),
    },
    phoneNumber: String,
    token: String,
    tokenExpiration: Date,
  },
  {
    timestamps: true,
  }
);

const UserModel = mongoose.model('User', userSchema);

export default UserModel;
