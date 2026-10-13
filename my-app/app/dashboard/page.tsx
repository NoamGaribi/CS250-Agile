import { auth, signOut } from "@/auth";
import { redirect } from "next/navigation";

// Dashboard Page Component
export default async function Dashboard() {
  const session = await auth();

  // Send anyone who isn't signed in back to the login page
  if (!session) {
    redirect("/");
  }

  return (
    <div className="min-h-screen bg-red-50">
      {/* Top Bar */}
      <header className="border-b border-red-100 bg-white">
        <div className="mx-auto flex max-w-5xl items-center justify-between px-4 py-4">
          <div className="flex items-center gap-3">
            <div className="flex h-10 w-10 items-center justify-center rounded-lg bg-red-600 text-lg font-bold text-white">
              DE
            </div>
            <span className="text-lg font-semibold text-zinc-900">
              Degree Evaluation
            </span>
          </div>

          <div className="flex items-center gap-4">
            <span className="hidden text-sm text-zinc-500 sm:inline">
              {session.user?.email}
            </span>
            <form
              action={async () => {
                "use server";
                await signOut({ redirectTo: "/" });
              }}
            >
              <button
                type="submit"
                className="rounded-lg border border-red-600 px-4 py-2 text-sm font-medium text-red-600 transition hover:bg-red-50"
              >
                Sign Out
              </button>
            </form>
          </div>
        </div>
      </header>

      {/* Main Content */}
      <main className="mx-auto max-w-5xl px-4 py-10">
        <h1 className="text-3xl font-semibold text-zinc-900">Dashboard</h1>
        <p className="mt-2 text-sm text-zinc-500">
          Upload a file to get started with your degree evaluation.
        </p>

        {/* File upload without wiring it up*/}
        <div className="mt-8 rounded-2xl border border-red-100 bg-white p-8 shadow-lg">
          <label
            htmlFor="file-upload"
            className="flex cursor-pointer flex-col items-center justify-center rounded-xl border-2 border-dashed border-red-200 bg-red-50/50 px-6 py-14 text-center transition hover:border-red-400 hover:bg-red-50"
          >
            <div className="mb-4 flex h-14 w-14 items-center justify-center rounded-full bg-red-100">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                strokeWidth={1.8}
                stroke="currentColor"
                className="h-7 w-7 text-red-600"
                aria-hidden="true"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  d="M3 16.5v2.25A2.25 2.25 0 0 0 5.25 21h13.5A2.25 2.25 0 0 0 21 18.75V16.5m-13.5-9L12 3m0 0 4.5 4.5M12 3v13.5"
                />
              </svg>
            </div>

            <span className="text-base font-medium text-zinc-900">
              Click to choose a file
            </span>
            <span className="mt-1 text-sm text-zinc-500">
              or drag and drop it here
            </span>

            <input id="file-upload" name="file" type="file" className="sr-only" />
          </label>

          <button
            type="button"
            className="mt-6 w-full rounded-lg bg-red-600 py-3 font-medium text-white transition hover:bg-red-700"
          >
            Upload
          </button>
        </div>
      </main>
    </div>
  );
}
