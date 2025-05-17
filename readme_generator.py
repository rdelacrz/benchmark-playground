"""
This Python script can be run to update the readme with the list of updated languages and most recent
list of benchmarks. This particular script has been tested with Python 3.12, though it should in theory
be runnable by any version of Python that supports the Template class.
"""

import os
import re
from string import Template
from subprocess import Popen, PIPE

DEFAULT_LANGUAGES_DIR = "languages"
OPERATION_CONFIGS = {
    'QuickSort': {
        '-i': '../../inputs/random_string_list.json',   # Should be relative to the run.sh files in the languages folders
        '-c': '1000',
    },
}
CLI_OUTPUT_PATTERN = re.compile(r".+'s \w+ execution time \(over \d+ loops\): (.+)")
README_FILENAME = os.path.abspath("README.md")

def _get_readme_template(template_path="templates/README_TEMPLATE.md"):
    with open(template_path, 'r') as f:
        return f.read()
    
def _format_language_name(language_name: str):
    """
    Formats the language name so that it is displayed in its proper form.

    Args:
        language_name (str): Name of language being re-formatted.

    Returns: 
        str: Formatted language names.
    """

    match language_name.lower():
        case "nodejs":
            return "NodeJs"
        case _:
            return language_name.title()
    
def _get_run_file_per_language(language_dir=DEFAULT_LANGUAGES_DIR, run_file="run.sh"):
    """
    Gets a list of tuples for each available programming language with a run.sh file.

    Args:
        language_dir (str): Directory path where programming language folders are located.
        run_file (str): Name of shell file that runs benchmarker.

    Returns: 
        list[tuple[str, str, str]]: A list of tuples (language name, absolute run file path, run file name).
    """
    available_languages: list[tuple[str, str]] = []

    # Sorts language names first
    language_names = os.listdir(language_dir)
    language_names.sort()

    for language_name in language_names:
        abs_run_path = os.path.abspath(os.path.join(language_dir, language_name))
        if os.path.isfile(os.path.join(abs_run_path, run_file)):
            available_languages.append((language_name, abs_run_path, run_file))
    
    return available_languages
    
def _get_available_languages(language_dir=DEFAULT_LANGUAGES_DIR):
    """
    Iterate through all available programming languages with implemented benchmarkers.

    Args:
        language_dir (str): Directory path where programming language folders are located.

    Return:
        iterable: Iterator over programming language names.
    """
    language_tuples = _get_run_file_per_language(language_dir)
    return map(lambda x: x[0], language_tuples)

def _parse_run_cli_output(language_dir=DEFAULT_LANGUAGES_DIR):
    """
    Runs and parses CLI output for each language in every available operation.

    Args:
        language_dir (str): Directory path where programming language folders are located.

    Returns:
        dict: A multi-level dictionary mapping operation -> language -> benchmark time.
    """
    
    cli_output_map: dict[str, dict[str, str]] = {}
    for operation, args in OPERATION_CONFIGS.items():
        cli_output_map[operation] = {}
        for language_name, run_path, run_file in _get_run_file_per_language(language_dir):
            os.chdir(run_path)  # Changes directory to language directory, so that run file can be executed from there
            process = Popen(["./" + run_file, '-o', operation, '-i', args['-i'], '-c', args['-c']], stdout=PIPE, stderr=PIPE)
            stdout, stderr = process.communicate()

            # Exits application on error
            formatted_language_name = _format_language_name(language_name)
            if stderr:
                error_msg = "An error occurred while attempting to run {} for the language {}:\n\t{}".format(
                    operation, formatted_language_name, stderr
                )
                raise Exception(error_msg)

            cli_output = stdout.decode('utf-8')
            pattern_match = CLI_OUTPUT_PATTERN.match(cli_output)

            if not pattern_match:
                print("WARNING: {} CLI output for the {} operation could not be parsed properly! CLI output: {}".format(
                    formatted_language_name, operation, cli_output
                ))
            else:
                cli_output_map[operation][language_name] = pattern_match.group(1)

    return cli_output_map
    
def write_readme_file():
    template_content = _get_readme_template()

    # Sets up bullet list of implemented programming languages within the project (language folders that contain a run.sh file)
    language_link_list: list[str] = []
    for language in _get_available_languages():
        formatted_language_name = _format_language_name(language)
        language_link_list.append("* [{}](https://github.com/rdelacrz/benchmark-playground/tree/main/languages/{})".format(
            formatted_language_name, language)
        )

    # Generates benchmark tables for each operation
    benchmark_list: list[str] = []
    for operation, language_map in _parse_run_cli_output().items():
        language_time_pairs = list(language_map.items())
        count = OPERATION_CONFIGS[operation]["-c"]
        benchmark_list.append(f"### {operation} ({len(language_time_pairs)} implementions)")
        benchmark_list.append(f"Language | Benchmark Time ({count} executions)")
        benchmark_list.append("-- | -:")
        for language, benchmark_time in language_time_pairs:
            benchmark_list.append(f"{language} | {benchmark_time}")
        benchmark_list.append('\n')

    # Renders template
    t = Template(template_content)
    readme_str = t.substitute(
        language_links="\n".join(language_link_list),
        benchmark_tables="\n".join(benchmark_list)
    )

    print("Generating new README.md file:\n")
    print(readme_str)

    # Saves template into actual readme location
    with open(README_FILENAME, 'w') as f:
        f.write(readme_str)

if __name__ == "__main__":
    write_readme_file()