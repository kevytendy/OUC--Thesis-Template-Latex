# OUC Thesis — LaTeX template
A clear, bilingual (Chinese/English-friendly) `oucthesis` LaTeX template tailored for Ocean University of China theses (bachelor / master / doctor) and adapted for international students.  
This README explains how to use, customize and compile the template, plus troubleshooting tips and recommended workflows.

> Short note: this README was written using your `oucthesis.cls` design and inspired by a well-known OUC LaTeX project (used here as an example of how others present the template).

---
## Contact

If you have questions, suggestions, or improvements for this OUC Thesis LaTeX template, feel free to reach out!

- **Author:** Tyrone Zeka(太龙)  
- **Email:** [zekah54 AT email.com](mailto:zekah54@gmail.com)  
- **GitHub:** [@TyroneZeka](https://github.com/TyroneZeka)  
- **LinkedIn:** [Tyrone Zeka](https://www.linkedin.com/in/tyrone-zeka/)  
- **Issues & feedback:** Please open a [GitHub Issue](../../issues) in this repository.

> 💡 Tip: If you’re using this template for your own thesis, a quick acknowledgment or star ⭐ on GitHub is always appreciated!

---

## Highlights / What this repo gives you
- Class file `oucthesis.cls` which implements OUC layout and options (degree level, language, citation style, etc.).
- A sample `main.tex` that demonstrates how to populate metadata and structure a thesis with frontmatter / mainmatter / backmatter.
- Example chapters, `figures/`, `fonts/` and a `bib/` folder with an example `.bib`.
- Ready-to-use bilingual cover pages (Chinese + English fields).
- Designed to compile with **XeLaTeX** (Unicode + `fontspec` friendly).

This project structure and usage approach follows public OUC templates and Overleaf-ready workflow.

---

## Quick start (3 minutes)

1. **Clone / download** this repository to your local machine or create a new Overleaf project from the zip.
2. **Edit metadata** in `main.tex` (title, author, major, supervisor, English equivalents). See the *Metadata* section below for exact commands.
3. **Choose documentclass options** (degree, language, citation style). See *Class options*.
4. **Compile with XeLaTeX** (online: Overleaf → set *XeLaTeX*; local: run `xelatex` / `latexmk` — instructions below).

If you use Overleaf: upload the whole zip and in *Menu → Compiler* choose **XeLaTeX**; set TeX Live to 2019 or newer for best compatibility.

---

## Requirements
- TeX distribution with XeLaTeX (TeX Live 2019+ recommended).
- `ctex` / `ctexbook` (modern version; the class checks for a reasonably recent `ctexbook`).
- Packages used (most present in common TeX Live): `fontspec`, `ctexbook`, `hyperref`, `tikz`, `natbib`, `caption`, `titletoc`, `fancyhdr`, etc.
- If you keep the shipped `fonts/` folder: no extra steps needed. If you remove it, set system fonts or install desired TrueType fonts.

Domestic users often prefer Tianjin/Chinese services like **Texpage** — the upstream examples suggest it as an alternative to Overleaf.

---

## Class options (how to change document type / language / citation style)
When you load the class in `main.tex`, specify options in `\documentclass[<options>]{oucthesis}`.

Supported options (from the class):
- Degree level: `doctor` | `master` | `bachelor`  
- Professional degree marker: `professional` (adds specialized wording)  
- Language: `english` | `chinese` (controls English/Chinese strings and cover)  
- Output target: `pdf` (oneside, colored links) | `print` (default)  
- Citation styles: `super` (superscript numeric), `numbers` (bracketed numeric), `authoryear` (author-year style)

Example:
```tex
\documentclass[master,english,pdf,numbers]{oucthesis}
```

(Defaults in the class file may be different; check `oucthesis.cls` in this repo.)

---

## Metadata — what to edit in `main.tex`
The class exposes a number of commands to set thesis metadata. Example (taken from the sample `main.tex`):

```tex
\title{MAE-MFF: Masked Autoencoders with Multi-Frequency Fusion.}
\author{太龙}
\major{计算机技术}
\supervisor{师傅}
% \date{二〇一七年五月一日} % optional Chinese date
\entitle{An Example of OUC Thesis Template for Bachelor, Master and Doctor}
\enauthor{Tyrone Zeka}
\enmajor{Computer Science and Technology}
\ensupervisor{Prof. Yang}
\encosupervisor{Prof. Li}
\endate{May 1, 2026}
```

---

## Typical compile sequences

### Overleaf
- Set Compiler → **XeLaTeX**
- TeX Live → **2019** or newer.
- Click **Recompile**. (If bibliography doesn't update, recompile multiple times.)

### Local (manual)
Basic sequence (when using `natbib` + BibTeX):
```bash
xelatex main.tex
bibtex main
xelatex main.tex
xelatex main.tex
```

Or use `latexmk` for convenience:
```bash
latexmk -xelatex -pdf main.tex
```

---

## Directory structure (typical)
```
.
├── main.tex
├── oucthesis.cls
├── oucextra.sty
├── chapters/
├── figures/
├── fonts/
├── bib/
└── README.md
```

---

## Customization notes

### Fonts
- The class uses `fontspec` and points to `fonts/` in the repository. If you want to use system fonts instead, replace the `\setmainfont`, `\setsansfont`, and `\setmonofont` calls in the class or put your desired `.ttf` files under `fonts/`.

### Cover/logo
- Replace `figures/ouc_logo` with your own logo file.

### Bibliography
- Use `\oucbibstyle{numbers}` or `authoryear`; keep your `.bib` in `bib/` and use `\bibliography{bib/ouc}`.

### Language / strings
- Use the `english` option to switch to English layout and labels.

---

## Common problems & fixes

- **Font not found** → ensure `.ttf` files exist in `fonts/`.
- **Old ctex version** → update your TeX Live / MiKTeX.
- **Bibliography missing** → re-run BibTeX + XeLaTeX twice.
- **Chinese bookmarks garbled** → `hyperref` with `unicode=true` and `CJKbookmarks=true` is required.

---

## Example: minimal `main.tex`
```tex
%!TEX program = xelatex
\documentclass[master,english,pdf,numbers]{oucthesis}
\title{MAE-MFF: Masked Autoencoders with Multi-Frequency Fusion}
\author{太龙}
\major{计算机技术}
\supervisor{师傅}
\entitle{MAE-MFF: Masked Autoencoders with Multi-Frequency Fusion}
\enauthor{Tailong}
\enmajor{Computer Science}
\ensupervisor{Prof. Yang}
\endate{May 1, 2017}

\begin{document}
\maketitle
\frontmatter
\input{chapters/abstract}
\tableofcontents
\mainmatter
\input{chapters/intro}
\bibliography{bib/ouc}
\appendix
\end{document}
```

---

## Build Script (`build.sh`)

This repository includes a convenient **build script** for local compilation.

### Features
- Uses **XeLaTeX** and **BibTeX** by default  
- Automatically runs all required compilation passes  
- Collects all temporary files in a `build/` folder  
- Copies the final PDF to the project root as `main_final.pdf`  
- Works on Linux, macOS, and Windows (Git Bash or WSL)

### Usage

#### 1️⃣ Make it executable
```bash
chmod +x build.sh
```

#### 2️⃣ Run the build
```bash
./build.sh
```

The script will:
1. Run `xelatex`  
2. Run `bibtex`  
3. Re-run `xelatex` twice more  
4. Output `main.pdf` in the project root  

#### 3️⃣ Optional clean mode
If you want to delete auxiliary files:
```bash
./build.sh clean
```
*(Enable this by uncommenting the cleanup section at the end of the script.)*

### Script excerpt
```bash
#!/usr/bin/env bash
MAIN="main"
ENGINE="xelatex"
BIB_TOOL="bibtex"
OUTDIR="build"

mkdir -p "$OUTDIR"
$ENGINE -output-directory="$OUTDIR" "$MAIN.tex"
(cd "$OUTDIR" && bibtex "$MAIN")
$ENGINE -output-directory="$OUTDIR" "$MAIN.tex"
$ENGINE -output-directory="$OUTDIR" "$MAIN.tex"
cp "$OUTDIR/$MAIN.pdf" "./${MAIN}.pdf"
echo "✅ Build complete: ${MAIN}.pdf"
```


## License & logo copyright
The class header notes LPPL for code. The **OUC logo** belongs to Ocean University of China; do not redistribute official emblems without permission.

---

