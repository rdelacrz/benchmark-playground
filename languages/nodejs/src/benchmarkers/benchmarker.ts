import Decimal from 'decimal.js';

const MILLI_TO_NANO_FACTOR = 6;
const NANO_PER_MILLI = Math.pow(10, MILLI_TO_NANO_FACTOR);

export abstract class Benchmarker {
    operationName: string;
    
    constructor(operationName: string) {
        this.operationName = operationName;
    }

    abstract consumeInputFile(inputFilePath: string): void;

    protected abstract getOperationExecutionTime(): bigint;

    getOperationExecutionResults(executionCount: number): bigint[] {
        return Array(executionCount)
            .fill(0)
            .map(_ => this.getOperationExecutionTime());
    }

    printBenchmarkAnalysis(executionCount: number): void {
        const executionResults = this.getOperationExecutionResults(executionCount);
        const totalTime = executionResults.reduce((acc, curr) => acc + curr, BigInt(0));
        const formattedTime = new Decimal(totalTime.toString())
            .dividedBy(NANO_PER_MILLI)
            .toDecimalPlaces(MILLI_TO_NANO_FACTOR)
            .toString();
        console.log(`NodeJs's ${this.operationName} execution time (over ${executionCount} loops): ${formattedTime} ms`);
    }
}
