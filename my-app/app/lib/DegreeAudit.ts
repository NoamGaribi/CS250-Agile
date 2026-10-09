import type { Requirement } from "./Requirement";
import type {DegreeProgress} from "./DegreeProgress"
// DegreeAudit class
export class DegreeAudit {
  private studentName: string;
  private fileContent: string;
  private requirementsList: Requirement[];

  constructor(studentName: string, fileContent: string) {
    this.studentName = studentName;
    this.fileContent = fileContent;
    this.requirementsList = [];
  }

  public getRequirement(): Requirement[] {
    throw new Error("Not implemented");
  }

  public getStudentName(): string {
    throw new Error("Not implemented");
  }

  public addRequirement(newRequirement: Requirement): void {
    throw new Error("Not implemented");
  }

  public toString(): string {
    throw new Error("Not implemented");
  }

  public extractProgress(): DegreeProgress {
    throw new Error("Not implemented");
  }
}