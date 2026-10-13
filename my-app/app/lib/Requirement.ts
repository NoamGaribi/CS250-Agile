// Requirement class
export class Requirement {
  private fulfilled: boolean;
  private name: string;
  private fulfillingCourses: string[];

  constructor(
    name: string,
    fulfilled: boolean = false,
    fulfillingCourses: string[] = []
  ) {
    this.name = name;
    this.fulfilled = fulfilled;
    this.fulfillingCourses = fulfillingCourses;
  }

  public getName(): string {
    return this.name;
  }

  public isFulfilled(): boolean {
    return this.fulfilled;
  }

  public makeFulfilled(fulfilled: boolean): void {
    this.fulfilled = fulfilled;
  }

  public getFulfillingCourses(): string[] {
    return this.fulfillingCourses;
  }

  public addFulfillingCourse(courseCode: string): void {
    if (!this.fulfillingCourses.includes(courseCode)) {
      this.fulfillingCourses.push(courseCode);
    }
  }

  public toString(): string {
    return this.name;
  }
}
