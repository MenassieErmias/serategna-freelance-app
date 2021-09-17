import express from 'express';
import dotenv from 'dotenv';
import cors from 'cors';

import connectDatabase from './config/db.js';

import userRoutes from './routes/user.route.js';
import jobRoutes from './routes/jobs.route.js';
import applicationRoutes from './routes/application.route.js';
import favoriteRoutes from './routes/favorite.route.js';
import { errorHandler, notFound } from './middlewares/error.js';

dotenv.config();

connectDatabase();

const app = express();

app.use(cors());
app.use(express.json());

app.use('/users', userRoutes);
app.use('/jobs', jobRoutes);
app.use('/applications', applicationRoutes);
app.use('/favorites', favoriteRoutes);

app.use(notFound);
app.use(errorHandler);

export default app;
