import type { DegreeProgress } from "./DegreeProgress"
import type { PlanningPreferences } from "./PlanningPreferences";
interface Course {
  courseCode: string;
  title: string;
  credits: number;
  prerequisites: string[];
}


export class CourseRecommender {
  private progress: DegreeProgress;
  private preferences: PlanningPreferences;

  constructor(
    progress: DegreeProgress,
    preferences: PlanningPreferences
  ) {
    this.progress = progress;
    this.preferences = preferences;
  }

  public recommendCourses(catalog: Course[]): Course[] {
    // Method stub
    return [];
  }

  public isEligible(course: Course): boolean {
    // Method stub
    return false;
  }
}