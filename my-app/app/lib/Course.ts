import type{ Requirement } from './Requirement';

export class Course{
    private courseCode: string;
    private courseName: string;
    private credits: number;
    private meetsRequirement: Requirement[];

    constructor(courseCode: string, courseName: string, 
        credits: number, meetsRequirement: Requirement[]) {
        this.courseCode = courseCode;
        this.courseName = courseName;
        this.credits = credits;
        this.meetsRequirement = meetsRequirement;
    }
    public getCourseCode(): string {
        return this.courseCode;
    }

    public getCourseName(): string {
        return this.courseName;
    }

    public getCredits(): number {
        return this.credits;
    }

    public getMeetsRequirement(): Requirement[] {
        return this.meetsRequirement;
    }

    // CHECK IF COURSE SATISFIES DEGREE REQUIREMENT
    // COMPARES THE REQUIREMENT NAME TO THE COURSE'S MEETS REQUIREMENT ARRAY
    public satisfiesRequirement(requirementName: string): boolean {
        return this.meetsRequirement.some(
        (requirement) => requirement.getName() === requirementName
  );
}
}