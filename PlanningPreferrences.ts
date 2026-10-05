export class PlanningPreferences {
  private creditsPerSemester: number;
  private electiveInterests: string;
  private preferredClassDays: string;

  constructor(
    creditsPerSemester: number,
    electiveInterests: string,
    preferredClassDays: string
  ) {
    this.creditsPerSemester = creditsPerSemester;
    this.electiveInterests = electiveInterests;
    this.preferredClassDays = preferredClassDays;
  }

  public updatePreferences(
    credits: number,
    interests: string,
    days: string
  ): void {
    // Method stub
  }

  public savePreferences(): void {
    // Method stub
  }

  public getPreferences(): PlanningPreferences {
    return this;
  }
}

