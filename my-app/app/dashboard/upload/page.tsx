import { auth } from "@/auth";
import Link from "next/link";
import { redirect } from "next/navigation";
import UploadAuditForm from "../UploadAuditForm";

// Upload Degree Audit Page
export default async function UploadAuditPage() {
  const session = await auth();

  // Send anyone who isn't signed in back to the login page
  if (!session) {
    redirect("/");
  }

  return (
    <>
      <Link
        href="/dashboard"
        className="text-sm font-medium text-red-600 hover:text-red-700"
      >
        &larr; Back to Dashboard
      </Link>

      <h1 className="mt-4 text-3xl font-semibold text-zinc-900">
        Upload Degree Audit
      </h1>
      <p className="mt-2 text-sm text-zinc-500">
        Upload a file to get started with your degree evaluation.
      </p>

      {/* File upload: posts to the uploadAudit server action */}
      <UploadAuditForm />
    </>
  );
}
