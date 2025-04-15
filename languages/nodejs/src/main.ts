import { InvalidArgumentError, program } from 'commander';
import fs from 'fs';
import process from 'node:process';
import { quickSort } from '@operations/quick-sort';
import { ComparableString } from '@utils/comparable';
import { roundToDecimals } from '@utils/utilities';

const DEFAULT_COUNT = 1000;

function validateOperation(value: string, dummyPrevious: any): string {
    // TODO: make more dynamic
    const validOperations = ["QuickSort"];
    if (!value) {
        throw new InvalidArgumentError(`No operation was passed! Operation must be one of the following: ${validOperations.join(', ')}`);
    } else if (value !== 'QuickSort') {
        throw new InvalidArgumentError(`Operation name '${value}' is invalid. Operation must be one of the following: ${validOperations.join(', ')}`)
    }
    return value;
}

function validateFilePath(value: string, dummyPrevious: any): string {
    if (!value) {
        throw new InvalidArgumentError(`No inputfile was passed!`);
    } else if (!fs.existsSync(value)) {
        throw new InvalidArgumentError(`Given input file '${value}' does not exist!`);
    }
    return value;
}

function validateCount(value: string, dummyPrevious: any): number {
    const parsedCount = parseInt(value ?? DEFAULT_COUNT, 10);
    if (isNaN(parsedCount)) {
        throw new InvalidArgumentError(`Given count '${value}' is not a valid integer!`);
    } else if (parsedCount <= 0) {
        throw new InvalidArgumentError(`Given count '${value}' must be larger than 0!`);
    }
    return parsedCount;
}

program
    .description('Benchmarks operations by executing them a set number of times.')
    .option('-o, --operation <string>', 'The operation to be benchmarked.', validateOperation)
    .option('-i, --inputfile <string>', 'The path to a file containing the input data.', validateFilePath)
    .option('-c, --count <number>', 'The number of times an operation will be executed.', validateCount);

program.parse(process.argv);


//////////////////////
// Runs benchmarking
/////////////////////

// yarn start -i ../../inputs/random.json -o QuickSort -c 1000

const options = program.opts();


const operation = options.operation as string;
const inputFilePath = options.inputfile as string;
const count = options.count as number;

let jsonArr: string[] = [];
try {
    const data = fs.readFileSync(inputFilePath);
    jsonArr = JSON.parse(data.toString());
} catch (e: any) {
    throw new Error(`Something wrong occurred while attempting to read input file: ${e}`);
}

let totalTime = BigInt(0);
for (let i = 0; i < count; i++) {
    let copyArr = jsonArr.map(str => new ComparableString(str));
    const start = process.hrtime.bigint();
    quickSort(copyArr);

    if (i < 2) {
        copyArr.forEach(s => console.log(s));
    }

    const end = process.hrtime.bigint();
    totalTime += (end - start);
}

const milliseconds = roundToDecimals(Number(totalTime / BigInt(1000000)), 6);
console.log(`NodeJs's ${operation} execution time (over ${count} loops): ${milliseconds} ms`);