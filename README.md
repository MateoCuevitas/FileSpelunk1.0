
# FileSpelunk1.0

**FileSpelunk1.0** is a Linux-native forensic string-search tool designed to recursively scan directories for files that contain **multiple specific text strings** — even if they are scattered throughout the file. It mimics a complex Windows `.bat` file using Bash + `strings` + `grep`. The windows version is included in the repo. Check the "windows" directory for usage. Thanks!

## 🔍 Features

- Recursive scan through selected file types
- Matches files only if **all search terms are present**
- Extracts lines containing matches
- Outputs to structured CSV with:
  - File path
  - Last modified timestamp
  - File extension
  - Matched lines
- Progress reporting in terminal
- Easy customization

## 🧰 Requirements

- `strings` (usually preinstalled)
- `grep`, `stat`, `find`, `bash`

## 📦 Install

```bash
git clone https://github.com/MateoCuevitas/MateoCuevitas.git --branch FileSpelunk
cd MateoCuevitas/FileSpelunk1.0
chmod +x FileSpelunk1.0.sh
```

## 🚀 Usage

```bash
./FileSpelunk1.0.sh
```

To modify behavior:
- Edit the file and change:
  - `SEARCH_PATH="/path/to/your/files"`
  - `STRINGS=( "STRING 1", "STRING 2", "STRING 3", "STRING 4" )`
  - `OUTPUT_FILE="results.csv"`

## 📁 File Types Searched

- `.txt`, `.log`, `.csv`, `.rtf`, `.xml`, `.json`, `.html`, `.htm`, `.eml`

## 📄 Output

A `.csv` file will be created in the current directory containing matched file info.

## 📝 License

This project is licensed under the [MIT License](LICENSE).

## ✅ Support

If you liked FileSpelunk and it helped you find that missing something, then please consider supporting the repo <3
