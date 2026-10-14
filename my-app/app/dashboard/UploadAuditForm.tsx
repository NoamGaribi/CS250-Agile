"use client";

import { useActionState, useState } from "react";
import { uploadAudit, type UploadState } from "./action";

const initialState: UploadState = { status: "idle", message: "" };

// Shows the chosen file, a loading state, and the result
export default function UploadAuditForm() {
  const [state, formAction, pending] = useActionState(uploadAudit, initialState);
  const [fileName, setFileName] = useState<string | null>(null);
  const [savingName, setSavingName] = useState<string | null>(null);

  // React resets the file input after submitting, so clear our copy too
  // and remember the name to show while it saves
  function handleSubmit(formData: FormData) {
    setSavingName(fileName);
    setFileName(null);
    formAction(formData);
  }

  return (
    <form
      action={handleSubmit}
      className="mt-8 rounded-2xl border border-red-100 bg-white p-8 shadow-lg"
    >
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

        {/* Show the chosen file, or the prompt if nothing is picked yet */}
        {fileName ? (
          <>
            <span className="text-base font-medium text-zinc-900">{fileName}</span>
            <span className="mt-1 text-sm text-zinc-500">Click to choose a different file</span>
          </>
        ) : (
          <>
            <span className="text-base font-medium text-zinc-900">
              Click to choose your degree audit
            </span>
            <span className="mt-1 text-sm text-zinc-500">PDF or text file</span>
          </>
        )}

        <input
          id="file-upload"
          name="file"
          type="file"
          accept=".pdf,.txt"
          className="sr-only"
          onChange={(e) => setFileName(e.target.files?.[0]?.name ?? null)}
        />
      </label>

      <button
        type="submit"
        disabled={pending || !fileName}
        className="mt-6 flex w-full items-center justify-center gap-2 rounded-lg bg-red-600 py-3 font-medium text-white transition hover:bg-red-700 disabled:cursor-not-allowed disabled:opacity-60"
      >
        {pending && (
          <span
            className="h-4 w-4 animate-spin rounded-full border-2 border-white border-t-transparent"
            aria-hidden="true"
          />
        )}
        <span className="truncate">
          {pending ? `Saving ${savingName}...` : "Upload Audit"}
        </span>
      </button>

      {/* Result message after the upload finishes */}
      {!pending && state.status !== "idle" && (
        <div
          role="status"
          aria-live="polite"
          className={
            state.status === "success"
              ? "mt-5 rounded-lg border border-green-200 bg-green-50 px-4 py-3 text-sm text-green-700"
              : "mt-5 rounded-lg border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700"
          }
        >
          {state.status === "success" ? "Upload succeeded! " : ""}
          {state.message}
        </div>
      )}
    </form>
  );
}
