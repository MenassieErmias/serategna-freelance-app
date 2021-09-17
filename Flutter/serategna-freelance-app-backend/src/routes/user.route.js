import { Router } from 'express';
import {
  httpCreateUser,
  httpLoginUser,
  httpDeleteUser,
  httpDeleteUsers,
  httpGetUsers,
  httpGetUser,
  httpUpdateSelf,
  httpGetEmployers,
  httpGetFreeLancers,
} from '../controllers/user.controllers.js';
import { isAdmin } from '../middlewares/roles.middleware.js';
import { errorCatcher } from '../middlewares/error.js';
import { isAuthenticated } from '../middlewares/isAuthenticated..js';
const router = Router();

router
  .route('/')
  .post(errorCatcher(httpCreateUser))
  .get(httpGetUsers)
  .delete(errorCatcher(isAdmin), errorCatcher(httpDeleteUsers));
router
  .route('/update')
  .put(errorCatcher(isAuthenticated), errorCatcher(httpUpdateSelf));
router
  .route('/employers')
  .get(
    errorCatcher(isAuthenticated),
    errorCatcher(isAdmin),
    errorCatcher(httpGetEmployers)
  );
router
  .route('/freelancers')
  .get(
    errorCatcher(isAuthenticated),
    errorCatcher(isAdmin),
    errorCatcher(httpGetFreeLancers)
  );
router
  .route('/:id')
  .get(errorCatcher(isAuthenticated), errorCatcher(httpGetUser))
  .delete(
    errorCatcher(isAuthenticated),
    errorCatcher(isAdmin),
    errorCatcher(httpDeleteUser)
  );
router.route('/login').post(errorCatcher(httpLoginUser));

export default router;
