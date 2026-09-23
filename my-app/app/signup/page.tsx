import Link from "next/link";
import { signIn } from "@/auth";
import bcrypt from "bcryptjs";
import pool, { isDuplicateEmail } from "@/app/lib/db";

// Sign Up Page Component
export default function SignUp() {
  return (
    <div className="flex min-h-screen items-center justify-center bg-red-50 px-4">
      <div className="w-full max-w-md rounded-2xl border border-red-100 bg-white p-8 shadow-lg">

        <h1 className="mb-6 text-3xl font-semibold">
          Create Account
        </h1>
        {/* Sign Up Form */}
        <form
          className="space-y-5"
          action={async (formData) => {
            "use server";
            // Validate form data
            const fullName = String(formData.get("name") ?? "").trim();
            const email = String(formData.get("email") ?? "")
              .trim()
              .toLowerCase();
            // Ensure email is valid
            const password = String(formData.get("password") ?? "");
            const confirmPassword = String(
              formData.get("confirmPassword") ?? ""
            );

            if (!fullName || !email || !password) {
              throw new Error("All fields are required");
            }

            if (password !== confirmPassword) {
              throw new Error("Passwords do not match");
            }

            if (password.length < 8) {
              throw new Error("Password must be at least 8 characters");
            }
            const nameParts = fullName.split(/\s+/);
            const firstName = nameParts[0];
            const lastName =
              nameParts.length > 1
                ? nameParts.slice(1).join(" ")
                : null;
            // Hash the password before storing it in the database
            const passwordHash = await bcrypt.hash(password, 12);

            // Insert the new user, the database rejects a taken email
            try {
              await pool.query(
                `INSERT INTO \`user\`
                 (email, password_hash, name, last_name)
                 VALUES (?, ?, ?, ?)`,
                [email, passwordHash, firstName, lastName]
              );
            } catch (error) {
              if (isDuplicateEmail(error)) {
                throw new Error("An account with this email already exists");
              }

              throw error;
            }

            await signIn("credentials", {
              email,
              password,
              redirectTo: "/dashboard",
            });
          }}
        >
          <input
            name="name"
            type="text"
            placeholder="John Smith"
            required
            className="w-full rounded-lg border px-4 py-3"
          />

          <input
            name="email"
            type="email"
            placeholder="student@university.edu"
            required
            className="w-full rounded-lg border px-4 py-3"
          />

          <input
            name="password"
            type="password"
            placeholder="Create a password"
            required
            minLength={8}
            className="w-full rounded-lg border px-4 py-3"
          />

          <input
            name="confirmPassword"
            type="password"
            placeholder="Confirm your password"
            required
            minLength={8}
            className="w-full rounded-lg border px-4 py-3"
          />

          <button
            type="submit"
            className="w-full rounded-lg bg-red-600 py-3 text-white"
          >
            Create Account
          </button>
        </form>

        <div className="mt-6 text-center">
          <Link href="/" className="text-red-600">
            Back to Sign In
          </Link>
        </div>

      </div>
    </div>
  );
}