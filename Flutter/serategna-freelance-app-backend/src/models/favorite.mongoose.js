import mongoose from 'mongoose';

const favoriteSchema = mongoose.Schema(
  {
    jobId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Job',
      required: true,
    },
    freelancerId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'User',
      required: true,
    },
  },
  {
    timestamps: true,
  }
);

const FavoriteModel = mongoose.model('Favorite', favoriteSchema);

export default FavoriteModel;
