import type { DegreeAudit } from "./DegreeAudit";
import type { Requirement } from "./Requirement";
// MySDSUAuditWebsite class
export class MySDSUAuditWebsite {
  private pages: Document[];
  private studentName: string;
  private degreeAudit: DegreeAudit;

  constructor(
    pages: Document[],
    studentName: string,
    degreeAudit: DegreeAudit
  ) {
    this.pages = pages;
    this.studentName = studentName;
    this.degreeAudit = degreeAudit;
  }

  public getPages(): Document[] {
    throw new Error("Not implemented");
  }

  public getPage(page: number): Document {
    throw new Error("Not implemented");
  }

  public getStudentName(): string {
    throw new Error("Not implemented");
  }

  public findRequirement(page: Document): Requirement {
    throw new Error("Not implemented");
  }

  public addRequirementToAudit(requirement: Requirement): void {
    throw new Error("Not implemented");
  }
}