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
    <div className="flex min-h-screen items-center justify-center bg-red-50 px-4">
      <div className="w-full max-w-md rounded-2xl border border-red-100 bg-white p-8 text-center shadow-lg">

        <h1 className="text-3xl font-semibold text-zinc-900">
          To Be Continued
        </h1>

        <p className="mt-2 text-sm text-zinc-500">
          Signed in as {session.user?.email}
        </p>

        <form
          action={async () => {
            "use server";
            await signOut({ redirectTo: "/" });
          }}
        >
          <button
            type="submit"
            className="mt-6 w-full rounded-lg border border-red-600 py-3 font-medium text-red-600 transition hover:bg-red-50"
          >
            Sign Out
          </button>
        </form>

      </div>
    </div>
  );
}
