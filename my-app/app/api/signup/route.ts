import bcrypt from "bcryptjs";
import pool from "@/app/lib/db";

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
    const [existing]: any = await pool.query(
      "SELECT id FROM `user` WHERE email = ? LIMIT 1",
      [email]
    );

    if (existing.length > 0) {
      return Response.json(
        { error: "Email already registered" },
        { status: 409 }
      );
    }

    // Hash the password before storing it in the database
    const passwordHash = await bcrypt.hash(password, 12);

    // Insert the new user into the database
    const [result]: any = await pool.query(
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
    console.error("Signup error:", error);

    return Response.json(
      { error: "Server error" },
      { status: 500 }
    );
  }
}