import argparse
import sys

try:
    from pptx import Presentation
except ImportError as e:
    print("Error: The 'python-pptx' package maty be not installed.")
    print("Please install it by running: pip install python-pptx")
    print(f"Error details: {e}")
    sys.exit(1)

try:
    from fix_slides_for_obs_processor import (
        process_presentation, reset_master_slides,
        check_and_report_overflow, auto_fit_all_text, PILLOW_AVAILABLE,
        reposition_and_resize_text_boxes, reposition_and_maximize_font
    )
except ImportError as e:
    print("Error: Could not import 'fix_slides_for_obs_processor'.")
    print("Make sure the file 'fix_slides_for_obs_processor.py' exists in the same directory.")
    print(f"Error details: {e}")
    sys.exit(1)

# ================= DEFAULT CONFIGURATION =================
DEFAULT_GLOW_COLOR = "#FFFFE0"  # Lighter, more discrete yellow
DEFAULT_GLOW_SIZE_PT = 20       # Size of the glow in points (reduce to avoid overlap between letters)
DEFAULT_TEXT_COLOR = "#050505"  # Hex code for near-black text
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
    parser.add_argument(
        "-r", "--reset-masters",
        dest="reset_masters",
        action="store_true",
        help="Reset master slides to default (removes effects and backgrounds)"
    )
    parser.add_argument(
        "--check-overflow",
        dest="check_overflow",
        action="store_true",
        help="Check for text that overflows slide boundaries (report only)"
    )
    parser.add_argument(
        "--auto-fit",
        dest="auto_fit",
        action="store_true",
        help="Automatically maximize font size to fit text within shapes (requires Pillow)"
    )
    parser.add_argument(
        "--margin",
        dest="margin",
        type=int,
        default=10,
        help="Margin in points for auto-fit (default: 10)"
    )
    parser.add_argument(
        "--reposition",
        dest="reposition",
        action="store_true",
        help="Reposition text boxes to fill the slide and maximize font size (requires Pillow)"
    )
    parser.add_argument(
        "--spacing",
        dest="spacing",
        type=int,
        default=10,
        help="Spacing between text boxes in points when repositioning (default: 10)"
    )
    parser.add_argument(
        "--margin-percent",
        dest="margin_percent",
        type=float,
        default=0.05,
        help="Margin as percentage of slide size for repositioning (default: 0.05 = 5%%)"
    )
    parser.add_argument(
        "-i", "--invert-colors",
        dest="invert_colors",
        action="store_true",
        help="Invert colors (black background with white text instead of white background with black text)"
    )
    
    args = parser.parse_args()
    
    # Set output file name if not provided
    if args.output_file is None:
        base_name = args.input_file.rsplit('.', 1)[0]
        args.output_file = f"{base_name}_obs_fixed.pptx"
    
    print(f"Opening {args.input_file}...")
    prs = Presentation(args.input_file)
    
    # Reset master slides if requested
    if args.reset_masters:
        print("Resetting master slides...")
        reset_master_slides(prs)
    
    # Check for overflow if requested
    if args.check_overflow:
        print("Checking for text overflow...")
        overflow_report = check_and_report_overflow(prs)
        if overflow_report:
            print(f"\nFound {len(overflow_report)} shape(s) with overflow:")
            for item in overflow_report:
                print(f"  Slide {item['slide_num']}: {item['shape_name']}")
                info = item['overflow_info']
                if info['overflow_right'] > 0:
                    print(f"    - Overflows right by {info['overflow_right'] / 12700:.1f} pt")
                if info['overflow_bottom'] > 0:
                    print(f"    - Overflows bottom by {info['overflow_bottom'] / 12700:.1f} pt")
                if info['overflow_left'] > 0:
                    print(f"    - Overflows left by {info['overflow_left'] / 12700:.1f} pt")
                if info['overflow_top'] > 0:
                    print(f"    - Overflows top by {info['overflow_top'] / 12700:.1f} pt")
        else:
            print("No overflow detected.")
    
    # Reposition and maximize font if requested
    if args.reposition:
        if not PILLOW_AVAILABLE:
            print("Error: Pillow is required for repositioning with font maximization. Install with: pip install Pillow")
            sys.exit(1)
        print("Repositioning text boxes and maximizing font size...")
        result = reposition_and_maximize_font(prs, args.margin_percent, args.spacing)
        print(f"Repositioned text boxes on {result['slides_processed']} slide(s).")
        if result['font_changes']:
            print(f"Adjusted font size for {len(result['font_changes'])} shape(s):")
            for change in result['font_changes']:
                old = f"{change['old_size']:.1f}pt" if change['old_size'] else "unknown"
                print(f"  Slide {change['slide_num']}: {change['shape_name']} - {old} -> {change['new_size']}pt")
    
    # Auto-fit text if requested
    if args.auto_fit:
        if not PILLOW_AVAILABLE:
            print("Error: Pillow is required for auto-fit. Install with: pip install Pillow")
            sys.exit(1)
        print("Auto-fitting text to maximum size...")
        changes = auto_fit_all_text(prs, args.margin)
        if changes:
            print(f"Adjusted font size for {len(changes)} shape(s):")
            for change in changes:
                old = f"{change['old_size']:.1f}pt" if change['old_size'] else "unknown"
                print(f"  Slide {change['slide_num']}: {change['shape_name']} - {old} -> {change['new_size']}pt")
        else:
            print("No font size changes made.")
    
    count = process_presentation(prs, args.glow_color, args.glow_size, args.text_color, args.invert_colors)

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
