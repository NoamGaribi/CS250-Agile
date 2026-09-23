import bcrypt from "bcryptjs";
import pool, { isDuplicateEmail } from "@/app/lib/db";
import type { ResultSetHeader } from "mysql2";

// API route for handling user signup

export async function POST(request: Request) {
  try {
    const { email, password, name, last_name } = await request.json();

    if (!email || !password) {
      return Response.json(
        { error: "Email and password are required" },
        { status: 400 }
      );
    }

    // Hash the password before storing it in the database
    const passwordHash = await bcrypt.hash(password, 12);

    // Insert the new user into the database
    const [result] = await pool.query<ResultSetHeader>(
      `INSERT INTO \`user\`
       (email, password_hash, name, last_name)
       VALUES (?, ?, ?, ?)`,
      [email, passwordHash, name ?? null, last_name ?? null]
    );

    return Response.json(
      {
        id: result.insertId,
        email,
        name,
        last_name,
      },
      { status: 201 }
    );
  } catch (error) {
    // The UNIQUE index on email is what rejects a taken address.
    if (isDuplicateEmail(error)) {
      return Response.json(
        { error: "Email already registered" },
        { status: 409 }
      );
    }

    console.error("Signup error:", error);

    return Response.json(
      { error: "Server error" },
      { status: 500 }
    );
  }
}