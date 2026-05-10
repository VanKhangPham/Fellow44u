import { User } from '@prisma/client';

import { prisma } from '../../config/db';

export const authRepository = {
  findByEmail(email: string): Promise<User | null> {
    return prisma.user.findUnique({
      where: { email },
    });
  },

  findById(userId: string): Promise<User | null> {
    return prisma.user.findUnique({
      where: { id: userId },
    });
  },

  create(input: {
    fullName: string;
    email: string;
    passwordHash: string;
  }): Promise<User> {
    return prisma.user.create({
      data: input,
    });
  },
};
