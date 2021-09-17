import {
  createUser,
  deleteUser,
  deleteUsers,
  getEmployers,
  getFreeLancers,
  getUser,
  getUsers,
  loginUser,
  updateSelf,
} from '../services/user.services.js';

async function httpGetUsers(req, res) {
  res.status(200).json(await getUsers());
}

async function httpGetUser(req, res) {
  console.log(req.params.id);
  console.log(await getUser({ _id: req.params.id }));
  res.status(200).json(await getUser({ _id: req.params.id }));
}
async function httpGetFreeLancers(req, res) {
  console.log(await getFreeLancers());
  res.status(200).json(await getFreeLancers());
}
async function httpGetEmployers(req, res) {
  console.log('employer');
  res.status(200).json(await getEmployers());
}

async function httpDeleteUser(req, res) {
  console.log(req.params.id);
  res.status(200).json(await deleteUser(req.params.id));
}

async function httpDeleteUsers(req, res) {
  res.status(200).json(await deleteUsers());
}

async function httpUpdateSelf(req, res) {
  res.status(200).json(await updateSelf(req.user._id, req.body));
}

async function httpCreateUser(req, res) {
  console.log(req.body);

  return res.status(201).json(await createUser(req.body));
}

async function httpLoginUser(req, res) {
  console.log(req.body);
  return res.status(200).json(await loginUser(req.body));
}

export {
  httpCreateUser,
  httpLoginUser,
  httpDeleteUser,
  httpGetFreeLancers,
  httpGetEmployers,
  httpUpdateSelf,
  httpDeleteUsers,
  httpGetUsers,
  httpGetUser,
};
