import NextAuth from "next-auth";
import Google from "next-auth/providers/google";
import Credentials from "next-auth/providers/credentials";
import bcrypt from "bcryptjs";
import pool from "@/app/lib/db";
import type { RowDataPacket } from "mysql2";

type UserRow = RowDataPacket & {
  id: number;
  email: string;
  password_hash: string | null;
  name: string | null;
  last_name: string | null;
};

export const { handlers, signIn, signOut, auth } = NextAuth({
  providers: [
    Google,

    Credentials({
      credentials: {
        email: {},
        password: {},
      },

      async authorize(credentials) {
        const email = credentials.email as string;
        const password = credentials.password as string;

        if (!email || !password) {
          return null;
        }

        const [rows] = await pool.query<UserRow[]>(
          `SELECT id, email, password_hash, name, last_name
           FROM \`user\`
           WHERE email = ?
           LIMIT 1`,
          [email]
        );

        if (rows.length === 0) {
          return null;
        }

        const user = rows[0];

        if (!user.password_hash) {
          return null;
        }

        const validPassword = await bcrypt.compare(
          password,
          user.password_hash
        );

        if (!validPassword) {
          return null;
        }

        return {
          id: String(user.id),
          email: user.email,
          name: user.name,
        };
      },
    }),
  ],
});