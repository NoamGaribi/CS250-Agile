export class DegreeProgress{
    private completedCourseCodes: Array<string>; 
    private remainingCourseRequirements: Array<string>;

    constructor(completedCourseCodes: Array<string> , remainingCourseRequirements: Array<string>) {
        this.completedCourseCodes = completedCourseCodes;
        this.remainingCourseRequirements = remainingCourseRequirements;
    }

   
    public getCompletedCourseCodes(): Array<string> {
        throw new Error("Not implemented yet");
    }

    public getRemainingRequirements(): Array<string> {
        throw new Error ("Not implemented yet");
    }

}