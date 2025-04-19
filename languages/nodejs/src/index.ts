import { InvalidArgumentError, program } from 'commander';
import fs from 'fs';
import process from 'node:process';
import { BENCHMARKER_MANAGER } from '@benchmarkers/benchmarker-manager';

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
    if (isNaN(parsedCount) || parsedCount <= 0) {
        throw new InvalidArgumentError(`Given count '${value}' is not a valid integer greater than 0!`);
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

const benchmarker = BENCHMARKER_MANAGER.getOperationBenchmarker(operation);
benchmarker.consumeInputFile(inputFilePath);
benchmarker.printBenchmarkAnalysis(count);