
README.txt

🔍 Batch File: Recovered file (or any other files) String Search Automation
Author: Matt Cavey
Version: 1.0
Date Created: 5 May 2025
Requirements:
- Windows (64-bit)
- strings64.exe from Sysinternals Suite (path defined in script)
- Administrative privileges recommended for full access
- Microsoft Excel or compatible program to view .csv output

📌 Purpose

This script recursively scans files under a specified target directory for the presence of one or more user-defined string terms. It captures:
- File Path
- Last Modified Timestamp
- File Extension
- All Matching Lines

All results are exported into structured .csv reports for review or evidence retention. 

📁 Directory Structure

- Target Folder:
  C:\Path\To\Search (Adjust this path)

- Output Folder:
  C:\Path\For\Output (Will be auto-created if not present)

🔑 Search Definitions

Each search term group below produces its own CSV file with matched results:

| Search Name         | Search Terms                                  | Output File                         |
|---------------------|-----------------------------------------------|-------------------------------------|
| All_Strings_Matched | String 1, String 2, String 3, String 4        | DA_Form_Unsigned.csv                |
| Only_String1        | String 1                                      | Only_DA_Form.csv                    |
| Only_String2        | String 2                                      | Only_7793.csv                       |
| Only_String3        | String 3                                      | Only_Recoupment.csv                 |
| Only_String4        | String 4                                      | Only_Tuition.csv                    |

🔧 Configuration Details

Modify these lines in the .bat file to change parameters:

set "targetDir=C:\Path\To\Search"
set "outputDir=C:\Path\To\Output"
set "stringsExe=C:\Path\To\SysinternalsSuite\strings64.exe"

🛠 How It Works

1. Dumps strings64.exe output from each matching file into a temp file.
2. Uses findstr /i to check for presence of each required term.
3. If all terms match (in multi-term searches), it writes the matched lines and metadata to the output CSV.
4. Progress counter updates in real time in the command prompt.

🧠 Notes

- The script only processes text-based files: .txt, .log, .csv, .rtf, .xml, .json, .html, .htm, .eml.
- It ignores binary formats like .exe, .dll, .pdf, .docx, etc.
- Files that don’t contain all terms in a group are not included in that group’s results.
- Performance depends heavily on the size of the file set and speed of the external drive. For example, 50MBs of files on a NVME SSD will be done almost instantly, but 20GB of files on USB Drive will take roughly 15-20 hours.

❌ To Cancel a Running Job

1. Open Task Manager → Details tab
2. Look for cmd.exe or conhost.exe owned by [Your_Windows_Username]
3. Right-click → End Task
