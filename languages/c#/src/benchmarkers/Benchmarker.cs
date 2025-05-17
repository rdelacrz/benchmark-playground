namespace Benchmarkers
{
    public abstract class Benchmarker(string operationName)
    {
        private static readonly double NANO_PER_MILLI = 1_000_000.0;

        public string OperationName { get => operationName; }

        public abstract void ConsumeInputFile(string inputFilePath);

        public abstract double GetOperationExecutionTime();

        public List<double> GetOperationExecutionResults(int executionCount) {
            List<double> executionResults = [..Enumerable
                .Repeat(0, executionCount)
                .Select(_ => GetOperationExecutionTime())
            ];
            return executionResults;
        }

        public void PrintBenchmarkAnalysis(int executionCount) {
            List<double> executionResults = GetOperationExecutionResults(executionCount);
            string formattedTime = string.Format("{0:F6}", executionResults.Sum() / NANO_PER_MILLI);
            Console.WriteLine($"C#'s {operationName} execution time (over {executionCount} loops): {formattedTime} ms");
        }
    }
}