# Fix Slides for OBS

A Python tool to prepare PowerPoint presentations for OBS Studio chroma key overlays by adding glow effects to text, preventing transparency issues.

## Features

- Adds solid glow effects to text for better chroma key compatibility
- Sets slide backgrounds (white for slides with text, black for empty slides)
- Optionally resets master slides to remove inherited effects
- Available as both CLI and GUI

## Installation

```bash
pip install python-pptx
```

## Usage

### GUI

```bash
python fix_slides_for_obs_gui.py
```

### CLI

```bash
# Basic usage
python fix_slides_for_obs.py presentation.pptx

# With custom settings
python fix_slides_for_obs.py presentation.pptx -g "#FFFF00" -s 25 -c "#000000"

# Reset master slides
python fix_slides_for_obs.py presentation.pptx -r
```

### CLI Options

| Option | Description | Default |
|--------|-------------|---------|
| `-o, --output` | Output file path | `<input>_obs_fixed.pptx` |
| `-g, --glow-color` | Glow color (hex) | `#FFFFF0` |
| `-s, --glow-size` | Glow size in points | `20` |
| `-c, --text-color` | Text color (hex) | `#010101` |
| `-r, --reset-masters` | Reset master slides | `False` |

## Running Tests

```bash
# Run all tests
python -m pytest tests/ -v

# Run only unit tests
python -m pytest tests/test_slides_processor.py -v

# Run individual slide tests
python -m pytest tests/test_individual_slides.py -v

# Run a specific test
python -m pytest tests/test_individual_slides.py::test_slide_aleluia -v
```

## Debugging

Use `debug_slide.py` for slide inspection and debugging:

```bash
# Basic slide info
python debug_slide.py 17

# Compare original vs processed
python debug_slide.py 17 --compare

# Show all debug info
python debug_slide.py 17 --all

# Process presentation and save output
python debug_slide.py --generate-output
```

## How It Works

1. **Background Setup**: Sets white background for slides with text, black for empty slides
2. **Glow Effect**: Applies a solid (100% opacity) glow behind text to create a "highlighter" effect
3. **Effect Cleanup**: Removes any existing glow/shadow effects before applying new ones
4. **Master Reset** (optional): Clears effects from master slides and layouts

## License

GNU General Public License v3.0
