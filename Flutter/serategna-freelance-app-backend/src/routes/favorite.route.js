import { Router } from 'express';
import {
  httpAddToFavorite,
  httpGetFavorite,
  httpGetFavorites,
  httpRemoveFromFavorites,
} from '../controllers/favorite.controllers.js';
import { errorCatcher } from '../middlewares/error.js';
import { isAuthenticated } from '../middlewares/isAuthenticated..js';
const router = Router();

router
  .route('/')
  .post(errorCatcher(isAuthenticated), errorCatcher(httpAddToFavorite))
  .get(errorCatcher(isAuthenticated), errorCatcher(httpGetFavorites));
router
  .route('/:id')
  .delete(errorCatcher(isAuthenticated), errorCatcher(httpRemoveFromFavorites))
  .get(errorCatcher(isAuthenticated), errorCatcher(httpGetFavorite));
export default router;
