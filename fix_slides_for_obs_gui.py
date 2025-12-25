import tkinter as tk
from tkinter import filedialog, messagebox, ttk
from pathlib import Path
from pptx import Presentation
from fix_slides_for_obs_processor import process_presentation

# Default configuration
DEFAULT_GLOW_COLOR = "#FFFFF0"
DEFAULT_GLOW_SIZE = 20
DEFAULT_TEXT_COLOR = "#010101"

class SlideFixerGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("PowerPoint Slide Fixer - OBS Chroma Key")
        self.root.geometry("600x500")
        self.root.resizable(False, False)
        
        self.selected_file = None
        
        # Create UI
        self.create_widgets()
    
    def create_widgets(self):
        # Title
        title_label = tk.Label(
            self.root, 
            text="PowerPoint Slide Fixer for OBS",
            font=("Arial", 16, "bold")
        )
        title_label.pack(pady=20)
        
        # File selection frame
        file_frame = tk.Frame(self.root)
        file_frame.pack(pady=10, padx=20, fill="x")
        
        tk.Label(file_frame, text="Select PowerPoint File:").pack(anchor="w")
        
        self.file_entry = tk.Entry(file_frame, width=60, state="readonly")
        self.file_entry.pack(side="left", padx=(0, 10), fill="x", expand=True)
        
        browse_btn = tk.Button(file_frame, text="Browse...", command=self.browse_file, width=10)
        browse_btn.pack(side="left")
        
        # Configuration frame
        config_frame = tk.LabelFrame(self.root, text="Configuration", padx=20, pady=15)
        config_frame.pack(pady=20, padx=20, fill="both")
        
        # Glow color
        color_frame = tk.Frame(config_frame)
        color_frame.pack(fill="x", pady=5)
        tk.Label(color_frame, text="Glow Color (hex):", width=20, anchor="w").pack(side="left")
        self.color_entry = tk.Entry(color_frame, width=15)
        self.color_entry.insert(0, DEFAULT_GLOW_COLOR)
        self.color_entry.pack(side="left", padx=5)
        
        # Glow size
        size_frame = tk.Frame(config_frame)
        size_frame.pack(fill="x", pady=5)
        tk.Label(size_frame, text="Glow Size (points):", width=20, anchor="w").pack(side="left")
        self.size_spinbox = tk.Spinbox(size_frame, from_=10, to=50, width=13)
        self.size_spinbox.delete(0, "end")
        self.size_spinbox.insert(0, DEFAULT_GLOW_SIZE)
        self.size_spinbox.pack(side="left", padx=5)
        
        # Text color
        text_color_frame = tk.Frame(config_frame)
        text_color_frame.pack(fill="x", pady=5)
        tk.Label(text_color_frame, text="Text Color (hex):", width=20, anchor="w").pack(side="left")
        self.text_color_entry = tk.Entry(text_color_frame, width=15)
        self.text_color_entry.insert(0, DEFAULT_TEXT_COLOR)
        self.text_color_entry.pack(side="left", padx=5)
        
        # Progress bar
        self.progress_frame = tk.Frame(self.root)
        self.progress_frame.pack(pady=10, padx=20, fill="x")
        
        self.progress_label = tk.Label(self.progress_frame, text="")
        self.progress_label.pack()
        
        self.progress_bar = ttk.Progressbar(
            self.progress_frame, 
            mode='indeterminate', 
            length=500
        )
        
        # Process button
        button_frame = tk.Frame(self.root)
        button_frame.pack(pady=20, fill="x")
        
        self.process_btn = tk.Button(
            button_frame,
            text="✓ Process Presentation",
            command=self.process_file,
            width=25,
            height=2,
            bg="#4CAF50",
            fg="white",
            font=("Arial", 14, "bold"),
            state="disabled",
            cursor="hand2"
        )
        self.process_btn.pack()
    
    def browse_file(self):
        filename = filedialog.askopenfilename(
            title="Select PowerPoint Presentation",
            filetypes=[
                ("PowerPoint files", "*.pptx"),
                ("All files", "*.*")
            ]
        )
        
        if filename:
            self.selected_file = filename
            self.file_entry.config(state="normal")
            self.file_entry.delete(0, tk.END)
            self.file_entry.insert(0, filename)
            self.file_entry.config(state="readonly")
            self.process_btn.config(state="normal")
    
    def process_file(self):
        if not self.selected_file:
            messagebox.showerror("Error", "Please select a file first!")
            return
        
        try:
            # Get configuration values
            glow_color = self.color_entry.get()
            glow_size = int(self.size_spinbox.get())
            text_color = self.text_color_entry.get().lstrip('#')
            
            # Validate colors
            if not glow_color or len(glow_color.lstrip('#')) != 6:
                messagebox.showerror("Error", "Invalid glow color! Use format: #RRGGBB")
                return
            
            if not text_color or len(text_color) != 6:
                messagebox.showerror("Error", "Invalid text color! Use format: #RRGGBB")
                return
            
            # Disable button and show progress
            self.process_btn.config(state="disabled")
            self.progress_label.config(text="Processing presentation...")
            self.progress_bar.pack(pady=5)
            self.progress_bar.start(10)
            self.root.update()
            
            # Generate output filename
            input_path = Path(self.selected_file)
            output_path = input_path.parent / f"{input_path.stem}_obs_fixed{input_path.suffix}"
            
            # Open presentation
            prs = Presentation(self.selected_file)
            
            # Process using shared function
            count = process_presentation(prs, glow_color, glow_size, text_color)
            
            # Save the presentation
            prs.save(str(output_path))
            
            # Stop progress bar
            self.progress_bar.stop()
            self.progress_bar.pack_forget()
            self.progress_label.config(text="")
            self.process_btn.config(state="normal")
            
            # Show success message
            messagebox.showinfo(
                "Success",
                f"Processed {count} text shapes!\n\nSaved to:\n{output_path.name}"
            )
            
        except Exception as e:
            self.progress_bar.stop()
            self.progress_bar.pack_forget()
            self.progress_label.config(text="")
            self.process_btn.config(state="normal")
            messagebox.showerror("Error", f"An error occurred:\n{str(e)}")

def main():
    root = tk.Tk()
    app = SlideFixerGUI(root)
    root.mainloop()

if __name__ == "__main__":
    main()
