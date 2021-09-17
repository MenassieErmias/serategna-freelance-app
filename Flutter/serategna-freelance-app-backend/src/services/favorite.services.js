import FavoriteModel from '../models/favorite.mongoose.js';
import { ErrorResponse } from '../utils/errorResponse.js';

async function addToFavorites(jobId, freelancerId) {
  const fav = await FavoriteModel.findOne({
    $and: [
      {
        jobId: jobId,
      },
      {
        freelancerId: freelancerId,
      },
    ],
  });
  if (fav) throw new ErrorResponse('you already favorite this', 400);
  return FavoriteModel.create({ jobId, freelancerId });
}
async function getFavorite(id) {
  return FavoriteModel.findById(id);
}
async function removeFromFavorites(id) {
  return FavoriteModel.findByIdAndDelete(id);
}

async function getFavorites(freelancerId) {
  return FavoriteModel.find({ freelancerId }).populate({
    path: 'jobId',
    populate: { path: 'employer' },
  });
}

export { addToFavorites, getFavorite, removeFromFavorites, getFavorites };
