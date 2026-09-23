import Link from "next/link";
import { signIn } from "@/auth";
import bcrypt from "bcryptjs";
import pool, { isDuplicateEmail } from "@/app/lib/db";
import { redirect } from "next/navigation";

type SignUpProps = {
  searchParams: Promise<{
    error?: string;
  }>;
};

// Sign Up Page Component
export default async function SignUp({ searchParams }: SignUpProps) {
  const { error } = await searchParams;

  const errorMessage =
    error === "MissingFields"
      ? "All fields are required."
      : error === "PasswordsDoNotMatch"
        ? "Passwords do not match."
        : error === "PasswordTooShort"
          ? "Password must be at least 8 characters."
          : error === "EmailExists"
            ? "An account with this email already exists."
            : error === "SignupError"
              ? "We could not create your account. Please try again."
              : null;

  return (
    <div className="flex min-h-screen items-center justify-center bg-red-50 px-4">
      <div className="w-full max-w-md rounded-2xl border border-red-100 bg-white p-8 shadow-lg">
        <h1 className="mb-6 text-3xl font-semibold">
          Create Account
        </h1>

        {errorMessage && (
          <div
            role="alert"
            className="mb-5 rounded-lg border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700"
          >
            {errorMessage}
          </div>
        )}

        {/* Sign Up Form */}
        <form
          className="space-y-5"
          action={async (formData) => {
            "use server";

            const fullName = String(formData.get("name") ?? "").trim();
            const email = String(formData.get("email") ?? "")
              .trim()
              .toLowerCase();
            const password = String(formData.get("password") ?? "");
            const confirmPassword = String(
              formData.get("confirmPassword") ?? ""
            );

            if (!fullName || !email || !password || !confirmPassword) {
              redirect("/signup?error=MissingFields");
            }

            if (password !== confirmPassword) {
              redirect("/signup?error=PasswordsDoNotMatch");
            }

            if (password.length < 8) {
              redirect("/signup?error=PasswordTooShort");
            }

            const nameParts = fullName.split(/\s+/);
            const firstName = nameParts[0];
            const lastName =
              nameParts.length > 1
                ? nameParts.slice(1).join(" ")
                : null;

            const passwordHash = await bcrypt.hash(password, 12);

            try {
              await pool.query(
                `INSERT INTO \`user\`
                 (email, password_hash, name, last_name)
                 VALUES (?, ?, ?, ?)`,
                [email, passwordHash, firstName, lastName]
              );
            } catch (error) {
              if (isDuplicateEmail(error)) {
                redirect("/signup?error=EmailExists");
              }

              console.error("Signup error:", error);
              redirect("/signup?error=SignupError");
            }

            // The new account now exists, so credentials login should succeed.
            // If it does, Auth.js redirects to /dashboard.
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
