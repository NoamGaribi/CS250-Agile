
class Roadmap {
  private studentPreferences: StudentPreferences;
  private allCourses: string[];
  private requirementsNeeded: Requirement[];

  constructor(
    studentPreferences: StudentPreferences,
    allCourses: string[],
    requirementsNeeded: Requirement[]
  ) {
    this.studentPreferences = studentPreferences;
    this.allCourses = allCourses;
    this.requirementsNeeded = requirementsNeeded;
  }

  public getPreferences(): StudentPreferences {
    throw new Error("Not implemented");
  }

  public getCourses(): Course[] {
    throw new Error("Not implemented");
  }

  public generateCoursesThatMatchPreferencesAndRequirements(): string[] {
    throw new Error("Not implemented");
  }

  public printRoadmap(): string {
    throw new Error("Not implemented");
  }
}