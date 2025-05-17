using Benchmarkers;
using CommandLine;
using System.Diagnostics;
using System.Text.Json;
using static Benchmarkers.BenchmarkerManager;

public class Options
{
    [Option('o', "operation", Required = true, HelpText = "The operation to be benchmarked.")]
    public required string Operation { get; set; }

    [Option('i', "inputfile", Required = true, HelpText = "The path to a file containing the input data for the benchmarked operation.")]
    public required string InputFile { get; set; }

    [Option('c', "count", Default = 1000, Required = false, HelpText = "The number of times an operation will be executed over the course of being benchmarked.")]
    public int? Count { get; set; }
}

public class App
{
    public static void Main(string[] args)
    {
        Parser.Default.ParseArguments<Options>(args)
            .WithParsed(RunOptionsAndReturnExitCode)
            .WithNotParsed(HandleParseError);
    }

    private static void RunOptionsAndReturnExitCode(Options opts)
    {
        Benchmarker? benchmarker = null;
        try
        {
            benchmarker = Instance.GetOperationBenchmarker(opts.Operation);
        }
        catch (Exception e)
        {
            Console.WriteLine($"An error occurred while attempting to get the benchmarker for operation '{opts.Operation}'.");
            Console.WriteLine($"Error: {e.Message}");
            Environment.Exit(1);
        }

        try
        {
            benchmarker.ConsumeInputFile(opts.InputFile);
            benchmarker.PrintBenchmarkAnalysis(opts.Count ?? 1000);
        }
        catch (Exception e)
        {
            Console.WriteLine("An error occurred while attempting to run benchmarker.");
            Console.WriteLine($"Error: {e.Message}");
            Environment.Exit(1);
        }
    }
    
    private static void HandleParseError(IEnumerable<Error> errors)
    {
        // Handle errors here
        Console.WriteLine("Error parsing command line options:");
        foreach (var error in errors)
        {
            Console.WriteLine(error.ToString());
        }
    }
}