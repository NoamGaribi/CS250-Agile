import type { DegreeAudit } from "./DegreeAudit";
import type { DegreeProgress } from "./DegreeProgress";

export class Student {
    private name: string;
    private email: string;

    private currentAudit: DegreeAudit | null = null;

    constructor(name: string, email: string) {
        this.name = name;
        this.email = email;
    } 

    public importAudit (audit: DegreeAudit): DegreeProgress {
        throw new Error("Not implemented yet");
    }
}