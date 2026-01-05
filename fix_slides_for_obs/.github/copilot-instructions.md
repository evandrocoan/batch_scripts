# Copilot Instructions for Fix Slides for OBS Project

## Project Overview

This project provides tools to fix PowerPoint slides for use with OBS Studio's chroma key feature. It adds glow effects to text to prevent transparency issues when using chroma key backgrounds.

## Project Structure

```
fix_slides_for_obs/
├── fix_slides_for_obs.py          # CLI interface
├── fix_slides_for_obs_gui.py      # GUI interface (Tkinter)
├── fix_slides_for_obs_processor.py # Shared processing logic
├── debug_slide.py                 # Unified debugging/utility script
├── README.md                      # Project documentation
├── tests/                         # Test directory
│   ├── test_slides_processor.py   # Unit tests (no external files needed)
│   ├── test_individual_slides.py  # Individual slide tests (uses test_slides/)
│   └── test_slides/               # Individual slide files for testing
└── .github/
    └── copilot-instructions.md    # This file
```

## Architecture

- **Processor** (`fix_slides_for_obs_processor.py`): Core logic shared between CLI and GUI
  - `apply_solid_glow_to_run()`: Applies glow effect to a text run
  - `reset_master_slides()`: Resets master slides to default formatting
  - `process_presentation()`: Main processing function for slides
  - `check_text_overflow()`: Checks if a shape overflows slide boundaries
  - `check_and_report_overflow()`: Reports all overflow issues in presentation
  - `calculate_max_font_size()`: Binary search for maximum font size that fits
  - `auto_fit_text_to_shape()`: Applies maximum font size to a shape
  - `auto_fit_all_text()`: Auto-fits all text in presentation
  - `measure_text_size()`: Measures text dimensions using Pillow
  - `get_font_path()`: Resolves font name to font file path

- **CLI** (`fix_slides_for_obs.py`): Command-line interface using argparse
- **GUI** (`fix_slides_for_obs_gui.py`): Graphical interface using Tkinter

## Key Technical Details

### PowerPoint XML Manipulation
- Uses `python-pptx` library for PowerPoint manipulation
- Directly manipulates DrawingML XML via `pptx.oxml.parse_xml()`
- Uses namespace `http://schemas.openxmlformats.org/drawingml/2006/main` for effects

### Effect Removal (Robust)
When removing existing effects, the code checks for multiple effect types in a namespace-agnostic way:
- `effectLst`, `glow`, `outerShdw`, `innerShdw`, `reflection`, `softEdge`, `effectDag`

This handles different DrawingML versions and prevents effect stacking.

### Text Measurement (Pillow)
- Uses `PIL.ImageFont.truetype()` to load fonts
- Uses `PIL.ImageDraw.textbbox()` to measure text dimensions
- Font paths resolved from `%WINDIR%\Fonts` directory
- Common font name mappings (Arial, Calibri, Times New Roman, etc.)

### Auto-fit Algorithm
- Binary search between min (8pt) and max (200pt) font sizes
- Accounts for margins around text
- Handles multi-line text with word wrapping
- Returns maximum font size that fits within shape bounds

### EMU Conversions
- 1 point = 12,700 EMUs (English Metric Units)
- Alpha values: 100000 = 100% opacity (0% transparency)

### Default Values
- Glow color: `#FFFFF0` (light ivory/yellow)
- Glow size: 20 points
- Text color: `#010101` (near-black, not pure black for chroma key compatibility)
- Auto-fit margin: 10 points

## Coding Guidelines

### When Adding New Features
1. Add core logic to `fix_slides_for_obs_processor.py`
2. Expose in CLI via argparse argument in `fix_slides_for_obs.py`
3. Add UI control (checkbox, entry, etc.) in `fix_slides_for_obs_gui.py`
4. Keep CLI and GUI in sync feature-wise

### When Modifying XML Effects
1. Always remove existing effects before adding new ones
2. Use namespace-agnostic tag checking (check if effect name is `in tag`)
3. Handle both `effectLst` containers and standalone effect elements
4. Insert effects after `solidFill` if present, otherwise at position 0

### Error Handling
- Use try/except with `pass` for non-critical failures (e.g., background modifications)
- Show user-friendly error messages in GUI via `messagebox.showerror()`
- Print errors to console in CLI
- Check `PILLOW_AVAILABLE` before using text measurement features

### Color Handling
- Accept colors with or without `#` prefix
- Strip `#` using `.lstrip('#')` before processing
- Validate hex colors are exactly 6 characters

## Dependencies

- `python-pptx`: PowerPoint file manipulation
- `tkinter`: GUI (standard library)
- `argparse`: CLI (standard library)
- `Pillow` (optional): Text measurement for auto-fit feature

## Debugging Tools

Use `debug_slide.py` for all slide debugging and utility operations:

```bash
# Basic slide inspection
python debug_slide.py 17                    # Basic info for slide 17
python debug_slide.py 17 --compare          # Compare original vs processed
python debug_slide.py 17 --fonts            # Show font details
python debug_slide.py 17 --layout           # Show layout calculation
python debug_slide.py 17 --measurement      # Show text measurement
python debug_slide.py 17 --shapes           # Show all shapes (including non-text)
python debug_slide.py 17 --binary-search    # Show binary search scaling process
python debug_slide.py 17 --lines            # Show line-by-line text analysis
python debug_slide.py 17 --scale-tests      # Show scale factor tests
python debug_slide.py 17 --all              # Show all debug info

# Batch operations
python debug_slide.py --all-slides          # Show fonts for all slides
python debug_slide.py 17 --process          # Process single slide and show results

# Utility operations
python debug_slide.py --generate-output     # Process full presentation, save to test_output.pptx
python debug_slide.py --split-slides        # Split presentation into individual slide files

# Custom files
python debug_slide.py 17 --original my_presentation.pptx --processed my_output.pptx
```

**Important**: Do NOT create individual debug scripts like `check_slide17.py` or `debug_slide55.py`. All debugging functionality is consolidated in `debug_slide.py`.

## Testing Recommendations

1. Test with presentations containing:
   - Multiple master slides
   - Various slide layouts
   - Text with existing effects (glow, shadow, etc.)
   - Empty slides (should get black background)
   - Slides with text (should get white background)
   - Different fonts (Arial, Calibri, Times New Roman)
   - Multi-line text boxes
   - Text boxes near slide edges

2. Verify effects are properly replaced, not stacked

3. Check output opens correctly in PowerPoint and LibreOffice Impress

4. Test auto-fit with various text lengths and shape sizes

## Running Tests

```bash
# Run all tests from project root
python -m pytest tests/test_slides_processor.py -v
python -m pytest tests/test_individual_slides.py -v

# Run specific test
python -m pytest tests/test_individual_slides.py::test_slide_17 -v

# Run from tests directory
cd tests
python -m pytest test_slides_processor.py -v
```
