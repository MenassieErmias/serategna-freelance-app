import {
  addToFavorites,
  getFavorite,
  getFavorites,
  removeFromFavorites,
} from '../services/favorite.services.js';

async function httpAddToFavorite(req, res) {
  console.log(req.body);
  res.status(201).json(await addToFavorites(req.body.jobId, req.user._id));
}

async function httpGetFavorite(req, res) {
  res.status(200).json(await getFavorite(req.params.id));
}

async function httpRemoveFromFavorites(req, res) {
  res.status(200).json(await removeFromFavorites(req.params.id));
}

async function httpGetFavorites(req, res) {
  res.status(200).json(await getFavorites(req.user._id));
}

export {
  httpAddToFavorite,
  httpGetFavorite,
  httpRemoveFromFavorites,
  httpGetFavorites,
};
