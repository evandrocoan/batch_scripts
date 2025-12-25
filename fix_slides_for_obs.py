import argparse
from pptx import Presentation
from fix_slides_for_obs_processor import process_presentation

# ================= DEFAULT CONFIGURATION =================
DEFAULT_GLOW_COLOR = "#FFFFF0"  # Lighter, more discrete yellow
DEFAULT_GLOW_SIZE_PT = 20       # Size of the glow in points (reduce to avoid overlap between letters)
DEFAULT_TEXT_COLOR = "#010101"  # Hex code for near-black text (R=1, G=1, B=1)
# =========================================================

def main():
    parser = argparse.ArgumentParser(
        description="Fix PowerPoint slides for OBS by adding glow effects to text."
    )
    parser.add_argument(
        "input_file",
        help="Input PowerPoint file (.pptx)"
    )
    parser.add_argument(
        "-o", "--output",
        dest="output_file",
        help="Output PowerPoint file (default: <input>_obs_fixed.pptx)"
    )
    parser.add_argument(
        "-g", "--glow-color",
        dest="glow_color",
        default=DEFAULT_GLOW_COLOR,
        help=f"Glow color in hex format (default: {DEFAULT_GLOW_COLOR})"
    )
    parser.add_argument(
        "-s", "--glow-size",
        dest="glow_size",
        type=int,
        default=DEFAULT_GLOW_SIZE_PT,
        help=f"Glow size in points (default: {DEFAULT_GLOW_SIZE_PT})"
    )
    parser.add_argument(
        "-c", "--text-color",
        dest="text_color",
        default=DEFAULT_TEXT_COLOR,
        help=f"Text color in hex format (default: {DEFAULT_TEXT_COLOR})"
    )
    
    args = parser.parse_args()
    
    # Set output file name if not provided
    if args.output_file is None:
        base_name = args.input_file.rsplit('.', 1)[0]
        args.output_file = f"{base_name}_obs_fixed.pptx"
    
    print(f"Opening {args.input_file}...")
    prs = Presentation(args.input_file)
    
    count = process_presentation(prs, args.glow_color, args.glow_size, args.text_color)
    
    print(f"Processed {count} text shapes.")
    print(f"Saving to {args.output_file}...")
    prs.save(args.output_file)
    print("Done!")

if __name__ == "__main__":
    try:
        main()
    except FileNotFoundError as e:
        print(f"Error: Could not find file. {e}")
    except Exception as e:
        print(f"Error: {e}")
