# Copilot Instructions for Fix Slides for OBS Project

## Project Overview

This project provides tools to fix PowerPoint slides for use with OBS Studio's chroma key feature. It adds glow effects to text to prevent transparency issues when using chroma key backgrounds.

## Project Structure

```
fix_slides_for_obs/
├── fix_slides_for_obs.py          # CLI interface
├── fix_slides_for_obs_gui.py      # GUI interface (Tkinter)
├── fix_slides_for_obs_processor.py # Shared processing logic
└── .github/
    └── copilot-instructions.md    # This file
```

## Architecture

- **Processor** (`fix_slides_for_obs_processor.py`): Core logic shared between CLI and GUI
  - `apply_solid_glow_to_run()`: Applies glow effect to a text run
  - `reset_master_slides()`: Resets master slides to default formatting
  - `process_presentation()`: Main processing function for slides

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

### EMU Conversions
- 1 point = 12,700 EMUs (English Metric Units)
- Alpha values: 100000 = 100% opacity (0% transparency)

### Default Values
- Glow color: `#FFFFF0` (light ivory/yellow)
- Glow size: 20 points
- Text color: `#010101` (near-black, not pure black for chroma key compatibility)

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

### Color Handling
- Accept colors with or without `#` prefix
- Strip `#` using `.lstrip('#')` before processing
- Validate hex colors are exactly 6 characters

## Dependencies

- `python-pptx`: PowerPoint file manipulation
- `tkinter`: GUI (standard library)
- `argparse`: CLI (standard library)

## Testing Recommendations

1. Test with presentations containing:
   - Multiple master slides
   - Various slide layouts
   - Text with existing effects (glow, shadow, etc.)
   - Empty slides (should get black background)
   - Slides with text (should get white background)

2. Verify effects are properly replaced, not stacked

3. Check output opens correctly in PowerPoint and LibreOffice Impress
