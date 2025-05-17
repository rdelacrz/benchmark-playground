namespace Benchmarkers
{
    using System.Diagnostics;
    using System.IO;
    using System.Text.Json;

    using static Operations.QuickSortOperation;

    public class QuickSortBenchmarker : Benchmarker
    {
        private string[] unsortedList;

        public QuickSortBenchmarker() : base("QuickSort")
        {
            unsortedList = [];
        }

        public override void ConsumeInputFile(string inputFilePath)
        {
            string jsonData = File.ReadAllText(inputFilePath);
            unsortedList = JsonSerializer.Deserialize<string[]>(jsonData)!;
        }

        public override double GetOperationExecutionTime()
        {
            string[] arrCopy = (string[]) unsortedList.Clone();

            Stopwatch stopWatch = new();
            stopWatch.Start();
            QuickSort(arrCopy);
            stopWatch.Stop();

            return stopWatch.Elapsed.TotalNanoseconds;
        }
    }
}