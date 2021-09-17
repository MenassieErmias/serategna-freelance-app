import { Router } from 'express';
import {
  httpCreateJob,
  httpDeleteJob,
  httpDeleteJobs,
  httpGetJob,
  httpGetJobs,
  httpOwnGetJobs,
  httpUpdateJob,
} from '../controllers/jobs.controllers.js';
import { errorCatcher } from '../middlewares/error.js';
import { isAuthenticated } from '../middlewares/isAuthenticated..js';
import { isEmployer } from '../middlewares/roles.middleware.js';
const router = Router();

router
  .route('/')
  .post(
    errorCatcher(isAuthenticated),
    errorCatcher(isEmployer),
    errorCatcher(httpCreateJob)
  )
  .get(errorCatcher(isAuthenticated), errorCatcher(httpGetJobs))
  .delete(
    errorCatcher(isAuthenticated),
    errorCatcher(isEmployer),
    errorCatcher(httpDeleteJobs)
  );

router
  .route('/:id')
  .get(errorCatcher(isAuthenticated), errorCatcher(httpGetJob))
  .put(
    errorCatcher(isAuthenticated),
    errorCatcher(isEmployer),
    errorCatcher(httpUpdateJob)
  )
  .delete(errorCatcher(isAuthenticated), errorCatcher(httpDeleteJob));
router
  .route('/own/:employerId')
  .get(
    errorCatcher(isAuthenticated),
    errorCatcher(isEmployer),
    errorCatcher(httpOwnGetJobs)
  );

export default router;
