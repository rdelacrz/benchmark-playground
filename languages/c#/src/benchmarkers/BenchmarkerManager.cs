namespace Benchmarkers
{
    public sealed class BenchmarkerManager
    {
        private static readonly Lazy<BenchmarkerManager> lazy = new(() => new BenchmarkerManager());

        public static BenchmarkerManager Instance { get { return lazy.Value; } }

        private readonly Dictionary<string, Benchmarker> benchmarkers;

        private BenchmarkerManager()
        {
            List<Benchmarker> benchmarkerList = [
                new QuickSortBenchmarker()
            ];
            benchmarkers = benchmarkerList.ToDictionary(b => b.OperationName, b => b);
        }

        public Benchmarker GetOperationBenchmarker(string operationName) {
            if (benchmarkers.TryGetValue(operationName, out Benchmarker? value)) {
                return value;
            } else {
                string validNames = string.Join(", ", GetValidOperations());
                throw new InvalidOperationException(
                    $"Operation name '{operationName}' not found. Operation must be one of the following: {validNames}"
                );
            }
        }

        private List<string> GetValidOperations()
        {
            List<string> validOperations = [.. benchmarkers.Keys];
            validOperations.Sort();
            return validOperations;
        }
    }
}