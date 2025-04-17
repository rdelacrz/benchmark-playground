import fs from 'fs';
import { Benchmarker } from '@benchmarkers/benchmarker';
import { quickSort } from '@operations/quick-sort';
import { ComparableString } from '@utils/comparable';

export class QuickSortBenchmarker extends Benchmarker<ComparableString[]> {
    jsonArr: string[] = [];

    constructor() {
        super("QuickSort");
    }

    protected getOperationInput(): ComparableString[] {
        return this.jsonArr.map(str => new ComparableString(str));
    }

    protected performOperation(inputContext: ComparableString[]): void {
        quickSort(inputContext);
    }

    consumeInputFile(inputFilePath: string): void {
        try {
            const data = fs.readFileSync(inputFilePath);
            this.jsonArr = JSON.parse(data.toString());
        } catch (e: any) {
            throw new Error(`Something wrong occurred while attempting to read input file: ${e}`);
        }
    }
}
