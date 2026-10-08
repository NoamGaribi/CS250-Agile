// Requirement class
export class Requirement {
  private fulfilled: boolean;
  private name: string;

  constructor(name: string) {
    this.name = name;
    this.fulfilled = false;
  }

  public getName(name: string): string {
    throw new Error("Not implemented");
  }

  public isFulfilled(): boolean {
    throw new Error("Not implemented");
  }

  public makeFulfilled(fulfilled: boolean): boolean {
    throw new Error("Not implemented");
  }

  public toString(): string {
    throw new Error("Not implemented");
  }
}