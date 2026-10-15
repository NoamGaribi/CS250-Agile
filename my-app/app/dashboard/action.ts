"use server"
import{ auth } from "@/auth";
import { redirect } from "next/navigation";
import { DegreeAudit } from "@/app/lib/DegreeAudit";
import { saveDegreeAudit } from "@/app/lib/repos/AuditRepository"
import { extractText, getDocumentProxy } from "unpdf";

// What the form shows after an upload attempt
export type UploadState = {
    status: "idle" | "success" | "error";
    message: string;
};

export async function uploadAudit(prevState: UploadState, formData : FormData): Promise<UploadState> {
    const session = await auth();
    if(!session?.user?.id) redirect("/");

    const file = formData.get("file");
    if(!(file instanceof File) || file.size == 0) {
        return { status: "error", message: "Please choose a file before uploading." };
    }

    const isPdf = file.type === "application/pdf";
    const isTxt = file.name.toLowerCase().endsWith(".txt");
    if (!isPdf && !isTxt) {
        return {
            status: "error",
            message: "Please upload a PDF or .txt file."
            };
        }
    
    try {

        let fileContent: string;
        if (isPdf) {
            const pdf = await getDocumentProxy(new Uint8Array(await file.arrayBuffer()));
            const { text } = await extractText(pdf, {mergePages: true});
            fileContent = text;
           } else {
            fileContent = await file.text(); 
           }
           
        const audit = new DegreeAudit(session.user.name ?? "", fileContent);
        const degreeId = 1;

        const auditImportId = await saveDegreeAudit (
            Number(session.user.id),
            degreeId,
            audit
        );
        return {
            status: "success",
            message: `"${file.name}" was saved (audit #${auditImportId}).`,
        };
    } catch (error) {
        console.error("Failed to save audit:", error);
        return { status: "error", message: "Upload failed. Please try again." };
    }
}