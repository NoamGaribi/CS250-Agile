import { PlanningPreferences } from "./PlanningPreferences";
import { Requirement } from "./Requirement";
import { Course } from "./Course";
class Roadmap {
  private studentPreferences: PlanningPreferences;
  private allCourses: string[];
  private requirementsNeeded: Requirement[];

  constructor(
    studentPreferences: PlanningPreferences,
    allCourses: string[],
    requirementsNeeded: Requirement[]
  ) {
    this.studentPreferences = studentPreferences;
    this.allCourses = allCourses;
    this.requirementsNeeded = requirementsNeeded;
  }

  public getPreferences(): PlanningPreferences {
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