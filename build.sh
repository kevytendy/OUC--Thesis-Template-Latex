#!/usr/bin/env bash
# ============================================================
#  OUC Thesis build script — fixed version
#  Works even when .bib/.bst files are in project root or subfolders
# ============================================================

set -e  # stop on first error

MAIN="main"           # main .tex file
ENGINE="xelatex"      # compiler
BIB_TOOL="bibtex"     # or "biber"
OUTDIR="build"        # output folder

echo "------------------------------------------------------------"
echo "  OUC Thesis Build Script"
echo "  Engine: $ENGINE | Bibliography: $BIB_TOOL"
echo "------------------------------------------------------------"

mkdir -p "$OUTDIR"

# 1️⃣ First LaTeX pass
echo "[1/4] Running $ENGINE..."
$ENGINE -interaction=nonstopmode -output-directory="$OUTDIR" "$MAIN.tex"

# 2️⃣ Run bibliography (from project root so .bib/.bst are found)
if [ "$BIB_TOOL" = "biber" ]; then
    echo "[2/4] Running biber..."
    biber --input-directory "$OUTDIR" "$MAIN"
else
    echo "[2/4] Running bibtex..."
    bibtex "$OUTDIR/$MAIN"   # bibtex sees correct aux file path but uses root for .bib/.bst
fi

# 3️⃣ Second + third LaTeX passes
echo "[3/4] Running $ENGINE (2nd pass)..."
$ENGINE -interaction=nonstopmode -output-directory="$OUTDIR" "$MAIN.tex"

echo "[4/4] Running $ENGINE (final pass)..."
$ENGINE -interaction=nonstopmode -output-directory="$OUTDIR" "$MAIN.tex"

# Copy final PDF to project root
cp "$OUTDIR/$MAIN.pdf" "./${MAIN}.pdf"

echo "------------------------------------------------------------"
echo "✅ Build completed successfully!"
echo "📘 Output PDF: ${MAIN}.pdf"
echo "------------------------------------------------------------"

# Optional cleanup
# rm -f "$OUTDIR"/*.{aux,log,out,toc,lot,lof,bbl,blg,bcf,run.xml}
