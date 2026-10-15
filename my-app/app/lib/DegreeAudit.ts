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
  termLabel: string;
  grade: string | null;
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
  // ALSO SAVES TERM AND GRADE
  private extractCourses(): void {
    const lines =
      this.fileContent.split(/\r?\n/);

    const found =
      new Map<string, ParsedAuditCourse>();

    // A REAL coursework line must BEGIN with a semester.
    //
    // Examples:
    // FA21 CS 150 3.0 B
    // FA26 CS 210 3.0 IP
    //
    // Capture groups:
    // 1 = term
    // 2 = subject
    // 3 = course number
    const courseLinePattern =
      /^\s*((?:FA|SP|SU|WI)\d{2})\s+([A-Z]{2,5}(?:\s+[A-Z])?)\s*([0-9]{3}[A-Z]?)\b/i;

    // Grades that indicate an actual attempted/completed course.
    const gradePattern =
      /\b(?:A[+-]?|B[+-]?|C[+-]?|D[+-]?|F|CR|NC|P|NP)\b/i;

    for (const line of lines) {
      const courseMatch =
        line.match(courseLinePattern);

      if (!courseMatch) {
        continue;
      }

      const upperLine =
        line.toUpperCase();

      const isInProgress =
        /\bIP\b/.test(upperLine);

      const gradeMatch =
        line.match(gradePattern);

      // A line must have either:
      // - IP
      // - or an actual grade
      //
      // This prevents "Select from" course options
      // from being imported as completed courses.
      if (
        !isInProgress &&
        !gradeMatch
      ) {
        continue;
      }

      const termLabel =
        courseMatch[1].toUpperCase();

      const subject =
        courseMatch[2]
          .trim()
          .replace(/\s+/g, " ")
          .toUpperCase();

      const courseCode =
        `${subject} ${courseMatch[3].toUpperCase()}`;

      const status:
        "completed" | "in_progress" =
          isInProgress
            ? "in_progress"
            : "completed";

      const grade =
        isInProgress
          ? null
          : gradeMatch?.[0].toUpperCase() ?? null;

      const existing =
        found.get(courseCode);

      // If the same course appears more than once,
      // do not let an in-progress entry replace
      // a completed entry.
      if (
        existing?.status === "completed" &&
        status === "in_progress"
      ) {
        continue;
      }

      found.set(courseCode, {
        courseCode,
        status,
        termLabel,
        grade
      });
    }

    this.parsedCourses =
      Array.from(found.values());
  }

  // LOOK FOR KNOWN REQUIREMENTS IN AUDIT TEXT
  // DETERMINE STATUS OF EACH REQUIREMENT
  // UNCLEAR = "UNKNOWN" STATUS
  public extractRequirements(
    knownRequirementNames: string[]
  ): void {
    const auditText =
      this.fileContent.toLowerCase();

    this.parsedRequirements = [];
    this.requirementsList = [];

    for (
      const requirementName
      of knownRequirementNames
    ) {
      const searchName =
        requirementName.toLowerCase();

      const index =
        auditText.indexOf(searchName);

      if (index === -1) {
        continue;
      }

      // LOOKS FOR:
      // "NEEDS"
      // "NOT SATISFIED"
      // "IN PROGRESS"
      // "IP"
      // "SATISFIED"
      // "COMPLETE"
      const start =
        Math.max(0, index - 100);

      const end =
        Math.min(
          auditText.length,
          index +
            requirementName.length +
            300
        );

      const nearbyText =
        auditText.slice(start, end);

      let status:
        AuditRequirementStatus =
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

      this.requirementsList.push(
        requirement
      );
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