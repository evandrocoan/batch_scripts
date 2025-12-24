from pptx import Presentation
from slide_processor import process_presentation

# ================= CONFIGURATION =================
INPUT_FILE = "Apresentação1.pptx"  # Put your file name here
OUTPUT_FILE = "Apresentação1_fixed.pptx"
GLOW_COLOR = "#FFFFF0"  # Lighter, more discrete yellow
GLOW_SIZE_PT = 20      # Size of the glow in points (reduce to avoid overlap between letters)
TEXT_COLOR = "#010101"  # Hex code for near-black text (R=1, G=1, B=1)
# =================================================

def main():
    print(f"Opening {INPUT_FILE}...")
    prs = Presentation(INPUT_FILE)
    
    count = process_presentation(prs, GLOW_COLOR, GLOW_SIZE_PT, TEXT_COLOR)
    
    print(f"Processed {count} text shapes.")
    print(f"Saving to {OUTPUT_FILE}...")
    prs.save(OUTPUT_FILE)
    print("Done!")

if __name__ == "__main__":
    try:
        main()
    except FileNotFoundError:
        print(f"Error: Could not find file '{INPUT_FILE}'. Please check the name.")
