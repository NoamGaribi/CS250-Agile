import type { DegreeAudit } from "./DegreeAudit";
import type { DegreeProgress } from "./DegreeProgress";
import { PlanningPreferences } from "./PlanningPreferences";

export class Student {
    private name: string;
    private email: string;
    private studentID: string; 

    private currentAudit: DegreeAudit | null = null;

    constructor(name: string, email: string, studentID: string) {
        this.name = name;
        this.email = email;
        this.studentID = studentID;
    } 

    public importAudit (audit: DegreeAudit): DegreeProgress {
        throw new Error("Not implemented yet");
    }

    public getPreferences(): PlanningPreferences {
        throw new Error("Not implemented yet");
    }

    public updatePreferences(preferences: PlanningPreferences): void {
        throw new Error("Not implemented yet");
    }

    public viewPreferences(){
        throw new Error("Not implemented yet");
    }
}