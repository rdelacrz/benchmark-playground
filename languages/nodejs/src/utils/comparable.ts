/**
 * Contains comparable related logic.
 */

export interface Comparable<T> {
    value: T,
    compareTo: (other: Comparable<T>) => number;
}

export class ComparableString implements Comparable<string> {
    value: string;
    
    constructor(value: string) {
        this.value = value;
    }

    compareTo(other: ComparableString): number {
        return this.value.localeCompare(other.value);
    }
}

export class ComparableNumber implements Comparable<number> {
    value: number;
    
    constructor(value: number) {
        this.value = value;
    }

    compareTo(other: ComparableNumber): number {
        return this.value - other.value;
    }
}