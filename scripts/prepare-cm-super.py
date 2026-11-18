"""Convert the original CM-Super Type 1 fonts from TeX Live for Typst.

Run with: fontforge -lang=py -script scripts/prepare-cm-super.py
"""

import subprocess
from pathlib import Path

import fontforge


target = Path(__file__).resolve().parents[1] / "fonts" / "cm-super"
target.mkdir(parents=True, exist_ok=True)

fonts = (
    ("sfrm1440", "CM Super 1440", "Regular"),
    ("sfbx1440", "CM Super 1440", "Bold"),
    ("sfti1440", "CM Super 1440", "Italic"),
    ("sfbi1440", "CM Super 1440", "Bold Italic"),
    ("sfrm1728", "CM Super 1728", "Regular"),
    ("sfbx1728", "CM Super 1728", "Bold"),
    ("sftt1200", "CM Super Typewriter 1200", "Regular"),
)

for filename, family, weight in fonts:
    source = subprocess.check_output(
        ["kpsewhich", filename + ".pfb"], text=True
    ).strip()
    if not source:
        raise FileNotFoundError(filename + ".pfb (install TeX Live CM-Super)")
    font = fontforge.open(source)
    font.familyname = family
    font.fullname = family + " " + weight
    font.fontname = family.replace(" ", "") + "-" + weight.replace(" ", "")
    font.weight = weight
    font.generate(str(target / (filename + ".otf")))
    font.close()

print("Converted CM-Super fonts to", target)
