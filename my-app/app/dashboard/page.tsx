import { auth } from "@/auth";
import Link from "next/link";
import { redirect } from "next/navigation";

// Shared look for the three dashboard cards
const cardClass =
  "flex flex-col items-start rounded-2xl border border-red-100 bg-white p-6 text-left shadow-lg transition";

// Dashboard Page Component
export default async function Dashboard() {
  const session = await auth();

  // Send anyone who isn't signed in back to the login page
  if (!session) {
    redirect("/");
  }

  return (
    <>
      <h1 className="text-3xl font-semibold text-zinc-900">Dashboard</h1>
      <p className="mt-2 text-sm text-zinc-500">
        What would you like to do?
      </p>

      <div className="mt-8 grid gap-6 sm:grid-cols-3">
        {/* Set User Preferences (not wired up yet) */}
        <button type="button" className={`${cardClass} hover:border-red-300`}>
          <span className="text-lg font-semibold text-zinc-900">
            Set User Preferences
          </span>
          <span className="mt-2 text-sm text-zinc-500">
            Choose how you want your courses planned.
          </span>
          <span className="mt-4 rounded-full bg-zinc-100 px-3 py-1 text-xs font-medium text-zinc-500">
            Coming soon
          </span>
        </button>

        {/* Generate Custom Degree Roadmap (not wired up yet) */}
        <button type="button" className={`${cardClass} hover:border-red-300`}>
          <span className="text-lg font-semibold text-zinc-900">
            Generate Custom Degree Roadmap
          </span>
          <span className="mt-2 text-sm text-zinc-500">
            Build a semester-by-semester plan to graduation.
          </span>
          <span className="mt-4 rounded-full bg-zinc-100 px-3 py-1 text-xs font-medium text-zinc-500">
            Coming soon
          </span>
        </button>

        {/* Upload Degree Audit: goes to the upload page */}
        <Link
          href="/dashboard/upload"
          className={`${cardClass} hover:border-red-400 hover:shadow-xl`}
        >
          <span className="text-lg font-semibold text-zinc-900">
            Upload Degree Audit
          </span>
          <span className="mt-2 text-sm text-zinc-500">
            Import your audit so we can track your progress.
          </span>
          <span className="mt-4 rounded-full bg-red-600 px-3 py-1 text-xs font-medium text-white">
            Upload &rarr;
          </span>
        </Link>
      </div>
    </>
  );
}
