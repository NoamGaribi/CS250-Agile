import type (DegreeProgress) from "./DegreeProgress"

export class DegreeAudit {
    private fileName: string;
    private fileContent: string; 

    private extractedProgress: DegreeProgress | null = null;

    constructor(fileName: string, fileContent: string){
        this.fileName = fileName;
        this.fileContent = fileContent;
    }

    public extractProgress(): DegreeProgress {
        throw new Error("Not implemented yet");
    }
}