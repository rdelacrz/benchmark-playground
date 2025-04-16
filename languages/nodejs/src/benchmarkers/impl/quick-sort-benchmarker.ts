import fs from 'fs';
import { Benchmarker } from '@benchmarkers/benchmarker';
import { quickSort } from '@operations/quick-sort';
import { ComparableString } from '@utils/comparable';

export class QuickSortBenchmarker extends Benchmarker {
    jsonArr: string[] = [];

    constructor() {
        super("QuickSort");
    }

    consumeInputFile(inputFilePath: string): void {
        try {
            const data = fs.readFileSync(inputFilePath);
            this.jsonArr = JSON.parse(data.toString());
        } catch (e: any) {
            throw new Error(`Something wrong occurred while attempting to read input file: ${e}`);
        }
    }

    protected getOperationExecutionTime(): bigint {
        let copyArr = this.jsonArr.map(str => new ComparableString(str));

        const start = process.hrtime.bigint();
        quickSort(copyArr);
        const end = process.hrtime.bigint();

        return (end - start);
    }
}
