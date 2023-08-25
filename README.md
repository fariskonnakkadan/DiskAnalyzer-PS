# Directory and Extension Size Analyzer
This script calculates and displays the space consumed by different file extensions and directories within a specified folder. It provides information about file counts, total sizes, and sorts based on your preference.

### Usage
- Download or copy the script file analyzeFiles.ps1 to a location on your computer.

- Open a PowerShell terminal.
- Navigate to the location where you saved the script using the cd command.
#### Run the script with the following optional parameters:
-FolderPath: Specify the path to the folder you want to analyze. Replace "C:\Path\To\Your\Folder" with the actual folder path.
-Depth: Specify the depth up to which directory sizes should be calculated. Use an integer. Default is 0 (all directories).
-SortBy: Specify whether to sort extension count based on "size" or "count". Default is "size".

Example command:
`.\analyzeFiles.ps1 -FolderPath "C:\Path\To\Your\Folder" -Depth 2 -SortBy count`

The script will display ASCII tables showing file extension sizes and directory sizes based on the provided parameters.

#### Parameters
-FolderPath: Path to the folder to be analyzed.
-Depth: Depth up to which directory sizes will be calculated (0 for all directories, an integer for a specific depth).
-SortBy: Sorting preference for extension count: "size" (default) or "count".

#### Example
To analyze the folder "C:\MyFiles" up to a depth of 2 directories and sort extension count by count, run:

`.\analyzeFiles.ps1 -FolderPath "C:\MyFiles" -Depth 2 -SortBy count`

### Notes
The script provides useful insights into the distribution of file extensions and directory sizes within a given folder.
It handles errors gracefully and displays informative messages.
