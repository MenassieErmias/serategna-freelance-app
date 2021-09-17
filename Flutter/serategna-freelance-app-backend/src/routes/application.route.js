import { Router } from 'express';
import {
  httpCreateApplication,
  httpDeleteApplication,
  httpDeleteApplications,
  httpGetAllEmployerPostsApplications,
  httpGetApplication,
  httpGetApplications,
  httpGetJobApplications,
  httpGetOwnApplications,
  httpUpdateApplication,
} from '../controllers/application.controllers.js';
import { errorCatcher } from '../middlewares/error.js';
import { isAuthenticated } from '../middlewares/isAuthenticated..js';
import { isEmployer } from '../middlewares/roles.middleware.js';

const router = Router();
router
  .route('/')
  .post(errorCatcher(isAuthenticated), errorCatcher(httpCreateApplication))
  .get(errorCatcher(isAuthenticated), errorCatcher(httpGetApplications))
  .delete(errorCatcher(isAuthenticated), errorCatcher(httpDeleteApplications));
router
  .route('/:id')
  .get(errorCatcher(isAuthenticated), errorCatcher(httpGetApplication))
  .put(errorCatcher(isAuthenticated), errorCatcher(httpUpdateApplication))
  .delete(errorCatcher(isAuthenticated), errorCatcher(httpDeleteApplication));
router
  .route('/job/:jobId')
  .get(errorCatcher(isAuthenticated), errorCatcher(httpGetJobApplications));
router
  .route('/own/:freelancerId')
  .get(errorCatcher(isAuthenticated), errorCatcher(httpGetOwnApplications));

router
  .route('/employer/:employerId')
  .get(
    errorCatcher(isAuthenticated),
    errorCatcher(isEmployer),
    errorCatcher(httpGetAllEmployerPostsApplications)
  );

export default router;
