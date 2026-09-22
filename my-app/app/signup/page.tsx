import Link from "next/link";
import { signIn } from "@/auth";

export default function SignUp() {
  return (
    <div className="flex min-h-screen items-center justify-center bg-red-50 px-4">
      <div className="w-full max-w-md rounded-2xl border border-red-100 bg-white p-8 shadow-lg">

        <div className="mb-8 text-center">
          <div className="mx-auto mb-5 flex h-14 w-14 items-center justify-center rounded-xl bg-red-600 text-2xl font-bold text-white">
            DE
          </div>

          <h1 className="text-3xl font-semibold text-zinc-900">
            Create Account
          </h1>

          <p className="mt-2 text-sm text-zinc-500">
            Create your Degree Evaluation account
          </p>
        </div>

        {/* Regular Sign Up */}
        <form className="space-y-5">
          <div>
            <label
              htmlFor="name"
              className="mb-2 block text-sm font-medium text-zinc-700"
            >
              Full Name
            </label>

            <input
              id="name"
              type="text"
              placeholder="John Smith"
              className="w-full rounded-lg border border-zinc-300 px-4 py-3 text-zinc-900 outline-none transition focus:border-red-500 focus:ring-2 focus:ring-red-100"
            />
          </div>

          <div>
            <label
              htmlFor="email"
              className="mb-2 block text-sm font-medium text-zinc-700"
            >
              Student Email
            </label>

            <input
              id="email"
              type="email"
              placeholder="student@university.edu"
              className="w-full rounded-lg border border-zinc-300 px-4 py-3 text-zinc-900 outline-none transition focus:border-red-500 focus:ring-2 focus:ring-red-100"
            />
          </div>

          <div>
            <label
              htmlFor="password"
              className="mb-2 block text-sm font-medium text-zinc-700"
            >
              Password
            </label>

            <input
              id="password"
              type="password"
              placeholder="Create a password"
              className="w-full rounded-lg border border-zinc-300 px-4 py-3 text-zinc-900 outline-none transition focus:border-red-500 focus:ring-2 focus:ring-red-100"
            />
          </div>

          <div>
            <label
              htmlFor="confirmPassword"
              className="mb-2 block text-sm font-medium text-zinc-700"
            >
              Confirm Password
            </label>

            <input
              id="confirmPassword"
              type="password"
              placeholder="Confirm your password"
              className="w-full rounded-lg border border-zinc-300 px-4 py-3 text-zinc-900 outline-none transition focus:border-red-500 focus:ring-2 focus:ring-red-100"
            />
          </div>

          <button
            type="submit"
            className="w-full rounded-lg bg-red-600 py-3 font-medium text-white transition hover:bg-red-700"
          >
            Create Account
          </button>
        </form>

        {/* OR Divider */}
        <div className="my-6 flex items-center">
          <div className="flex-1 border-t border-zinc-200" />
          <span className="px-4 text-sm text-zinc-400">OR</span>
          <div className="flex-1 border-t border-zinc-200" />
        </div>

        {/* Google Sign Up */}
        <form
          action={async () => {
            "use server";
            await signIn("google", { redirectTo: "/" });
          }}
        >
          <button
            type="submit"
            className="flex w-full items-center justify-center gap-3 rounded-lg border border-zinc-300 bg-white py-3 font-medium text-zinc-700 transition hover:bg-zinc-50"
          >
            <svg
              width="20"
              height="20"
              viewBox="0 0 24 24"
              aria-hidden="true"
            >
              <path
                fill="#4285F4"
                d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92a5.06 5.06 0 0 1-2.2 3.32v2.77h3.57c2.08-1.92 3.27-4.74 3.27-8.1z"
              />
              <path
                fill="#34A853"
                d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.24 1.06-3.71 1.06-2.87 0-5.3-1.94-6.17-4.54H2.15v2.84A11 11 0 0 0 12 23z"
              />
              <path
                fill="#FBBC05"
                d="M5.83 14.09A6.6 6.6 0 0 1 5.48 12c0-.73.13-1.43.35-2.09V7.07H2.15A11 11 0 0 0 1 12c0 1.77.42 3.44 1.15 4.93l3.68-2.84z"
              />
              <path
                fill="#EA4335"
                d="M12 5.38c1.62 0 3.06.56 4.2 1.64l3.15-3.15A10.6 10.6 0 0 0 12 1 11 11 0 0 0 2.15 7.07l3.68 2.84C6.7 7.32 9.13 5.38 12 5.38z"
              />
            </svg>

            Sign up with Google
          </button>
        </form>

        {/* Back to Login */}
        <div className="mt-6 text-center">
          <p className="text-sm text-zinc-600">
            Already have an account?
          </p>

          <Link
            href="/"
            className="mt-3 mx-auto block w-40 rounded-lg border border-red-600 py-2 text-sm font-medium text-red-600 transition hover:bg-red-50"
          >
            Sign In
          </Link>
        </div>

        <div className="mt-8 border-t border-zinc-100 pt-5 text-center">
          <p className="text-xs text-zinc-400">
            Degree Evaluation System
          </p>
        </div>
      </div>
    </div>
  );
}