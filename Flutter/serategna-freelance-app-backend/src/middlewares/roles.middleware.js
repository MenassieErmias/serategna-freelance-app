import { ROLE } from '../constants/enums.constants.js';
import { ErrorResponse } from '../utils/errorResponse.js';

export async function isEmployer(req, _, next) {
  if (req.user?.role !== ROLE.EMPLOYER)
    throw new ErrorResponse('Not authorized to perform this action', 403);
  next();
}

export async function isAdmin(req, _, next) {
  console.log(`looooog ${req.user?.role}`);
  if (req.user?.role !== ROLE.ADMIN)
    throw new ErrorResponse('Not authorized to perform this action', 403);
  next();
}
