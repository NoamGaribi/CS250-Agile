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
    this.creditsPerSemester = credits;
    this.electiveInterests = interests;
    this.preferredClassDays = days;
  }

  public getCreditsPerSemester(): number {
    return this.creditsPerSemester;
  }

  public getElectiveInterests(): string {
    return this.electiveInterests;
  }

  public getPreferredClassDays(): string {
    return this.preferredClassDays;
  }

  // SAVE PREFERENCES NOT NEEDED HERE
  // IT'S HANDLED IN THE REPOSITORY CLASS
  // ex: PreferencesRepository.savePreferences(...)
}

