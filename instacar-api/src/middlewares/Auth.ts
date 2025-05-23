import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';
import { IAuthRequest } from '../types';
import { MESSAGES } from '../utils/messages';

export const authMiddleware = (
  req: IAuthRequest,
  res: Response,
  next: NextFunction
): void => {
  const authHeader = req.headers.authorization;
  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    res.status(403).json({ message: MESSAGES.AUTH.NO_TOKEN });
    return;
  }

  const token = authHeader.split(' ')[1];

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET as string) as {
      userId: string;
    };

    req.user = decoded;

    next();
  } catch (error) {
    res.status(401).json({ message: MESSAGES.AUTH.INVALID_TOKEN });
  }
};

export default authMiddleware;
