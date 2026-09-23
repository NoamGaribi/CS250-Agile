import { signIn } from "@/auth";
import Link from "next/link";

export default function Home() {
  return (
    <div className="flex min-h-screen items-center justify-center bg-red-50 px-4">
      <div className="w-full max-w-md rounded-2xl border border-red-100 bg-white p-8 shadow-lg">

        <div className="mb-8 text-center">
          <div className="mx-auto mb-5 flex h-14 w-14 items-center justify-center rounded-xl bg-red-600 text-2xl font-bold text-white">
            DE
          </div>

          <h1 className="text-3xl font-semibold text-zinc-900">
            Degree Evaluation
          </h1>

          <p className="mt-2 text-sm text-zinc-500">
            Sign in to view and manage your academic progress
          </p>
        </div>

        {/* Email / Password Login */}
        <form
          className="space-y-5"
          action={async (formData) => {
            "use server";

            await signIn("credentials", {
              email: formData.get("email"),
              password: formData.get("password"),
              redirectTo: "/dashboard",
            });
          }}
        >
          <div>
            <label
              htmlFor="email"
              className="mb-2 block text-sm font-medium text-zinc-700"
            >
              Student Email
            </label>

            <input
              id="email"
              name="email"
              type="email"
              required
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
              name="password"
              type="password"
              required
              placeholder="Enter your password"
              className="w-full rounded-lg border border-zinc-300 px-4 py-3 text-zinc-900 outline-none transition focus:border-red-500 focus:ring-2 focus:ring-red-100"
            />
          </div>

          <div className="flex items-center justify-between">
            <label className="flex items-center gap-2 text-sm text-zinc-600">
              <input type="checkbox" className="accent-red-600" />
              Remember me
            </label>

            <button
              type="button"
              className="text-sm font-medium text-red-600 hover:underline"
            >
              Forgot password?
            </button>
          </div>

          <button
            type="submit"
            className="w-full rounded-lg bg-red-600 py-3 font-medium text-white transition hover:bg-red-700"
          >
            Sign In
          </button>
        </form>

        {/* Sign Up */}
        <div className="mt-6 text-center">
          <p className="text-sm text-zinc-600">
            Don&apos;t have an account?
          </p>

          <Link
            href="/signup"
            className="mt-3 mx-auto w-40 block rounded-lg border border-red-600 py-3 font-medium text-xs text-red-600 transition hover:bg-red-50"
          >
            Create Account
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