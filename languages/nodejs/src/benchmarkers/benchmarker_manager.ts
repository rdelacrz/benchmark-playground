import { Benchmarker } from '@benchmarkers/benchmarker';
import { QuickSortBenchmarker } from '@benchmarkers/impl/quick-sort-benchmarker';

type BenchmarkerMap = {[id: string]: Benchmarker};

class BenchmarkerManager {
    benchmarkers: BenchmarkerMap;

    constructor() {
        const benchmarkerList = [
            new QuickSortBenchmarker(),
        ];

        this.benchmarkers = benchmarkerList
            .reduce((map, benchmarker) => {
                map[benchmarker.operationName] = benchmarker;
                return map;
            }, {} as BenchmarkerMap);
    }

    getOperationBenchmarker(operationName: string) {
        if (this.benchmarkers[operationName]) {
            return this.benchmarkers[operationName];
        } else {
            const validNames = this.getValidOperations().join(', ');
            throw new Error(`Operation name '${operationName}' not found. Operation must be one of the following: ${validNames}`);
        }
    }

    private getValidOperations() {
        return Object.keys(this.benchmarkers).sort();
    }
}

export const BENCHMARKER_MANAGER = new BenchmarkerManager();