export class DegreeProgress{
    private completedCourseCodes: Array<string>; 
    private remainingRequirements: Array<string>;

    constructor(completedCourseCodes: Array<string> , remainingCourseRequirements: Array<string>) {
        this.completedCourseCodes = completedCourseCodes;
        this.remainingRequirements = remainingCourseRequirements;
    }

   
    public getCompletedCourseCodes(): Array<string> {
        throw new Error("Not implemented yet");
    }

    public getRemainingRequirements(): Array<string> {
        throw new Error ("Not implemented yet");
    }
}