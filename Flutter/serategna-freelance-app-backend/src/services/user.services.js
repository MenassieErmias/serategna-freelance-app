import UserModel from '../models/user.mongoose.js';
import { ErrorResponse } from '../utils/errorResponse.js';
import {
  generatePasswordHash,
  validatePassword,
} from '../utils/hashpassword.js';
import { generateJWT } from '../utils/generateJWT.js';
import { ROLE } from '../constants/enums.constants.js';

async function getUser(filter, projection = {}) {
  return UserModel.findOne(filter, projection);
}

async function getUsers() {
  return UserModel.find();
}

async function getFreeLancers() {
  return UserModel.find({ role: ROLE.FREELANCER });
}

async function getEmployers() {
  return UserModel.find({ role: ROLE.EMPLOYER });
}

async function deleteUser(id) {
  const userExists = await getUser({ _id: id });
  if (!userExists) {
    throw new ErrorResponse('User does not exist', 404);
  }
  await UserModel.findByIdAndDelete(id);
  return {
    message: 'Success',
  };
}

async function updateSelf(id, body) {
  if (body.password) {
    body.password = await generatePasswordHash(body.password);
  }
  console.log(body);
  return await UserModel.updateOne({ _id: id }, body);
}

async function deleteUsers() {
  return UserModel.deleteMany();
}

async function createUser(user) {
  user.password = await generatePasswordHash(user.password);
  return UserModel.create(user);
}

async function loginUser({ email, password }) {
  const user = await getUser({ email });

  if (!user) throw new ErrorResponse('User not found', 404);
  const matchPassword = await validatePassword(password, user.password);

  if (!matchPassword) throw new ErrorResponse('Wrong credentials', 400);

  const token = await generateJWT(user._id);
  return {
    _id: user._id,
    fullName: user.fullName,
    email: user.email,
    role: user.role,
    profession: user.profession,
    phoneNumber: user.phoneNumber,
    token,
  };
}

export {
  getUser,
  getUsers,
  getFreeLancers,
  getEmployers,
  deleteUser,
  deleteUsers,
  updateSelf,
  createUser,
  loginUser,
};
