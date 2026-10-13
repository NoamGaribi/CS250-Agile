import type { DegreeProgress } from "./DegreeProgress";
import type { PlanningPreferences } from "./PlanningPreferences";
import type { Course } from "./Course";

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
    const recommendations: Course[] = [];
    let totalCredits = 0;

    for (const course of catalog) {
      if (!this.isEligible(course)) {
        continue;
      }

      const satisfiesNeededRequirement =
        this.progress
          .getRemainingRequirements()
          .some((requirement) =>
            course.satisfiesRequirement(requirement)
          );

      if (!satisfiesNeededRequirement) {
        continue;
      }

      if (
        totalCredits + course.getCredits() >
        this.preferences.getCreditsPerSemester()
      ) {
        continue;
      }

      recommendations.push(course);
      totalCredits += course.getCredits();
    }

    return recommendations;
  }

  public isEligible(course: Course): boolean {
    return !this.progress.hasCompleted(
      course.getCourseCode()
    );
  }
}