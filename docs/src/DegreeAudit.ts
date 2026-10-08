// DegreeAudit class
class DegreeAudit {
  private studentName: string;
  private requirementsList: Requirement[];

  constructor(studentName: string) {
    this.studentName = studentName;
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
}