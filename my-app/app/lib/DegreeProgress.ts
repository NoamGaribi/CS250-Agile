export class DegreeProgress {
  private completedCourseCodes: string[];
  private remainingRequirements: string[];

  constructor(
    completedCourseCodes: string[],
    remainingRequirements: string[]
  ) {
    this.completedCourseCodes = completedCourseCodes;
    this.remainingRequirements = remainingRequirements;
  }

  public getCompletedCourseCodes(): string[] {
    return this.completedCourseCodes;
  }

  public getRemainingRequirements(): string[] {
    return this.remainingRequirements;
  }

  public hasCompleted(courseCode: string): boolean {
    return this.completedCourseCodes.includes(courseCode);
  }

  public needsRequirement(requirementName: string): boolean {
    return this.remainingRequirements.includes(requirementName);
  }
}