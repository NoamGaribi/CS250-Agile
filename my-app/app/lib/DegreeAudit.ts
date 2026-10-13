import { Requirement } from "./Requirement";
import { DegreeProgress } from "./DegreeProgress";

// DegreeAudit class

export type AuditRequirementStatus =
  | "satisfied"
  | "in_progress"
  | "not_satisfied"
  | "unknown";

export interface ParsedAuditCourse {
  courseCode: string;
  status: "completed" | "in_progress";
}

export interface ParsedAuditRequirement {
  name: string;
  status: AuditRequirementStatus;
}

export class DegreeAudit {
  private studentName: string;
  private fileContent: string;

  private requirementsList: Requirement[];
  private parsedCourses: ParsedAuditCourse[];
  private parsedRequirements: ParsedAuditRequirement[];

  constructor(studentName: string, fileContent: string) {
    this.studentName = studentName;
    this.fileContent = fileContent;

    this.requirementsList = [];
    this.parsedCourses = [];
    this.parsedRequirements = [];
  }


  public getRequirement(): Requirement[] {
    return this.requirementsList;
  }


  public getStudentName(): string {
    return this.studentName;
  }


  public addRequirement(newRequirement: Requirement): void {
    this.requirementsList.push(newRequirement);
  }


  public getParsedCourses(): ParsedAuditCourse[] {
    return this.parsedCourses;
  }


  public getParsedRequirements(): ParsedAuditRequirement[] {
    return this.parsedRequirements;
  }

  // FIND COURSES IN AUDIT
  // SEES IF COMPLETED OR IN PROGRESS
  private extractCourses(): void {
    const lines = this.fileContent.split(/\r?\n/);

    const found = new Map<
      string,
      "completed" | "in_progress"
    >();

    const coursePattern =
      /\b([A-Z]{2,5}(?:\s+[A-Z])?)\s*([0-9]{3}[A-Z]?)\b/g;

    for (const line of lines) {
      const upperLine = line.toUpperCase();

      let status: "completed" | "in_progress" =
        "completed";

      if (
        /\bIP\b/.test(upperLine) ||
        upperLine.includes("IN PROGRESS")
      ) {
        status = "in_progress";
      }

      const matches = line.matchAll(coursePattern);

      for (const match of matches) {
        const subject = match[1]
          .trim()
          .replace(/\s+/g, " ");

        const courseCode =
          `${subject} ${match[2]}`;

        const existing = found.get(courseCode);

        // IF SAME COURSE APPEARS MULTIPLE TIMES, PREFER IN-PROGRESS STATUS
        if (
          existing !== "in_progress" ||
          status === "in_progress"
        ) {
          found.set(courseCode, status);
        }
      }
    }

    this.parsedCourses =
      Array.from(found.entries()).map(
        ([courseCode, status]) => ({
          courseCode,
          status
        })
      );
  }

  // LOOK FOR KNOWN REQUIREMENTS IN AUDIT TEXT
  // DETERMINE STATUS OF EACH REQUIREMENT
  // UNCLEAR = "UNKNOWN" STATUS
  public extractRequirements(
    knownRequirementNames: string[]
  ): void {
    const auditText = this.fileContent.toLowerCase();

    this.parsedRequirements = [];
    this.requirementsList = [];

    for (const requirementName of knownRequirementNames) {
      const searchName =
        requirementName.toLowerCase();

      const index =
        auditText.indexOf(searchName);

      if (index === -1) {
        continue;
      }

      // LOOKS FOR "NEEDS", "NOT SATISFIED", "IN PROGRESS", "IP", "SATISFIED", OR "COMPLETE"
      const start = Math.max(0, index - 100);
      const end = Math.min(
        auditText.length,
        index + requirementName.length + 300
      );

      const nearbyText =
        auditText.slice(start, end);

      let status: AuditRequirementStatus =
        "unknown";

      if (
        nearbyText.includes("needs") ||
        nearbyText.includes("not satisfied")
      ) {
        status = "not_satisfied";
      } else if (
        nearbyText.includes("in progress") ||
        /\bip\b/.test(nearbyText)
      ) {
        status = "in_progress";
      } else if (
        nearbyText.includes("satisfied") ||
        nearbyText.includes("complete")
      ) {
        status = "satisfied";
      }

      this.parsedRequirements.push({
        name: requirementName,
        status
      });

      const requirement =
        new Requirement(requirementName);

      requirement.makeFulfilled(
        status === "satisfied"
      );

      this.requirementsList.push(requirement);
    }
  }


  public extractProgress(): DegreeProgress {
    this.extractCourses();

    const completedCourseCodes =
      this.parsedCourses
        .filter(
          (course) =>
            course.status === "completed"
        )
        .map(
          (course) =>
            course.courseCode
        );

    const remainingRequirements =
      this.parsedRequirements
        .filter(
          (requirement) =>
            requirement.status !== "satisfied"
        )
        .map(
          (requirement) =>
            requirement.name
        );

    return new DegreeProgress(
      completedCourseCodes,
      remainingRequirements
    );
  }


  public toString(): string {
    return `Degree Audit for ${this.studentName}`;
  }
}