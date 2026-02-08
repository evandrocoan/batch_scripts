"""
Unit tests for GUI configuration persistence.

These tests verify that the GUI correctly saves and loads user preferences.

Run with: python -m pytest tests/test_gui_config.py -v
Or from tests/: python -m pytest test_gui_config.py -v
"""
import unittest
import os
import sys
import json
import tempfile
import shutil

# Add parent directory to path for imports
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))


class TestConfigPath(unittest.TestCase):
    """Test config path generation for different platforms."""
    
    def test_config_path_function_exists(self):
        """Test that get_config_path function exists."""
        import fix_slides_for_obs_gui as gui_module
        self.assertTrue(hasattr(gui_module, 'get_config_path'))
        self.assertTrue(callable(gui_module.get_config_path))
    
    def test_config_path_returns_string(self):
        """Test that config path is a string."""
        import fix_slides_for_obs_gui as gui_module
        path = gui_module.get_config_path()
        self.assertIsInstance(path, str)
        self.assertGreater(len(path), 0)
    
    def test_config_path_ends_with_json(self):
        """Test that config path ends with .json."""
        import fix_slides_for_obs_gui as gui_module
        path = gui_module.get_config_path()
        self.assertTrue(path.endswith('.json'))
    
    def test_config_path_contains_app_name(self):
        """Test that config path contains app name."""
        import fix_slides_for_obs_gui as gui_module
        path = gui_module.get_config_path()
        self.assertIn('fix_slides_for_obs', path)
    
    def test_config_directory_created(self):
        """Test that config directory is created if it doesn't exist."""
        import fix_slides_for_obs_gui as gui_module
        path = gui_module.get_config_path()
        config_dir = os.path.dirname(path)
        # The function should have created the directory
        self.assertTrue(os.path.exists(config_dir))
        self.assertTrue(os.path.isdir(config_dir))


class TestConfigSaveLoad(unittest.TestCase):
    """Test configuration save and load functionality."""
    
    def setUp(self):
        """Create a temporary config directory for testing."""
        self.test_dir = tempfile.mkdtemp()
        self.test_config_file = os.path.join(self.test_dir, 'test_config.json')
        
        # Monkey patch the CONFIG_FILE for testing
        import fix_slides_for_obs_gui as gui_module
        self.original_config_file = gui_module.CONFIG_FILE
        gui_module.CONFIG_FILE = self.test_config_file
    
    def tearDown(self):
        """Clean up temporary directory."""
        import fix_slides_for_obs_gui as gui_module
        gui_module.CONFIG_FILE = self.original_config_file
        
        if os.path.exists(self.test_dir):
            shutil.rmtree(self.test_dir)
    
    def test_save_config_creates_file(self):
        """Test that save_config creates a JSON file."""
        import tkinter as tk
        import fix_slides_for_obs_gui as gui_module
        
        root = tk.Tk()
        try:
            app = gui_module.SlideFixerGUI(root)
            app.save_config()
            
            self.assertTrue(os.path.exists(self.test_config_file))
        finally:
            root.destroy()
    
    def test_save_config_creates_valid_json(self):
        """Test that saved config is valid JSON."""
        import tkinter as tk
        import fix_slides_for_obs_gui as gui_module
        
        root = tk.Tk()
        try:
            app = gui_module.SlideFixerGUI(root)
            app.save_config()
            
            with open(self.test_config_file, 'r') as f:
                config = json.load(f)
            
            self.assertIsInstance(config, dict)
        finally:
            root.destroy()
    
    def test_save_config_includes_all_settings(self):
        """Test that all settings are saved."""
        import tkinter as tk
        import fix_slides_for_obs_gui as gui_module
        
        root = tk.Tk()
        try:
            app = gui_module.SlideFixerGUI(root)
            app.save_config()
            
            with open(self.test_config_file, 'r') as f:
                config = json.load(f)
            
            # Check all expected keys are present
            expected_keys = [
                'glow_color', 'glow_size', 'text_color',
                'reset_masters', 'check_overflow', 'reposition', 'invert_colors'
            ]
            for key in expected_keys:
                self.assertIn(key, config)
        finally:
            root.destroy()
    
    def test_load_config_restores_glow_color(self):
        """Test that glow color is restored from config."""
        import tkinter as tk
        import fix_slides_for_obs_gui as gui_module
        
        # Create a config file with custom color
        config = {
            'glow_color': '#FF00FF',
            'glow_size': '25',
            'text_color': '#000000',
            'reset_masters': False,
            'check_overflow': False,
            'reposition': False,
            'invert_colors': False
        }
        with open(self.test_config_file, 'w') as f:
            json.dump(config, f)
        
        root = tk.Tk()
        try:
            app = gui_module.SlideFixerGUI(root)
            # load_config is called in __init__
            
            self.assertEqual(app.color_entry.get(), '#FF00FF')
        finally:
            root.destroy()
    
    def test_load_config_restores_glow_size(self):
        """Test that glow size is restored from config."""
        import tkinter as tk
        import fix_slides_for_obs_gui as gui_module
        
        config = {
            'glow_color': '#FFFFF0',
            'glow_size': '30',
            'text_color': '#010101',
            'reset_masters': False,
            'check_overflow': False,
            'reposition': False,
            'invert_colors': False
        }
        with open(self.test_config_file, 'w') as f:
            json.dump(config, f)
        
        root = tk.Tk()
        try:
            app = gui_module.SlideFixerGUI(root)
            self.assertEqual(app.size_spinbox.get(), '30')
        finally:
            root.destroy()
    
    def test_load_config_restores_text_color(self):
        """Test that text color is restored from config."""
        import tkinter as tk
        import fix_slides_for_obs_gui as gui_module
        
        config = {
            'glow_color': '#FFFFF0',
            'glow_size': '20',
            'text_color': '#FF0000',
            'reset_masters': False,
            'check_overflow': False,
            'reposition': False,
            'invert_colors': False
        }
        with open(self.test_config_file, 'w') as f:
            json.dump(config, f)
        
        root = tk.Tk()
        try:
            app = gui_module.SlideFixerGUI(root)
            self.assertEqual(app.text_color_entry.get(), '#FF0000')
        finally:
            root.destroy()
    
    def test_load_config_restores_checkboxes(self):
        """Test that checkbox states are restored from config."""
        import tkinter as tk
        import fix_slides_for_obs_gui as gui_module
        
        config = {
            'glow_color': '#FFFFF0',
            'glow_size': '20',
            'text_color': '#010101',
            'reset_masters': True,
            'check_overflow': True,
            'reposition': True,
            'invert_colors': True
        }
        with open(self.test_config_file, 'w') as f:
            json.dump(config, f)
        
        root = tk.Tk()
        try:
            app = gui_module.SlideFixerGUI(root)
            
            self.assertTrue(app.reset_masters_var.get())
            self.assertTrue(app.check_overflow_var.get())
            self.assertTrue(app.reposition_var.get())
            self.assertTrue(app.invert_colors_var.get())
        finally:
            root.destroy()
    
    def test_load_config_handles_missing_file(self):
        """Test that missing config file doesn't cause errors."""
        import tkinter as tk
        import fix_slides_for_obs_gui as gui_module
        
        # Ensure no config file exists
        if os.path.exists(self.test_config_file):
            os.remove(self.test_config_file)
        
        root = tk.Tk()
        try:
            # Should not raise an exception
            app = gui_module.SlideFixerGUI(root)
            
            # Should use defaults
            self.assertEqual(app.color_entry.get(), gui_module.DEFAULT_GLOW_COLOR)
            self.assertEqual(app.size_spinbox.get(), str(gui_module.DEFAULT_GLOW_SIZE))
        finally:
            root.destroy()
    
    def test_load_config_handles_corrupted_json(self):
        """Test that corrupted JSON doesn't crash the app."""
        import tkinter as tk
        import fix_slides_for_obs_gui as gui_module
        
        # Write invalid JSON
        with open(self.test_config_file, 'w') as f:
            f.write("{ invalid json }")
        
        root = tk.Tk()
        try:
            # Should not raise an exception
            app = gui_module.SlideFixerGUI(root)
            
            # Should fall back to defaults
            self.assertEqual(app.color_entry.get(), gui_module.DEFAULT_GLOW_COLOR)
        finally:
            root.destroy()
    
    def test_save_and_load_roundtrip(self):
        """Test that saved config can be loaded back correctly."""
        import tkinter as tk
        import fix_slides_for_obs_gui as gui_module
        
        root = tk.Tk()
        try:
            # Create app and modify settings
            app1 = gui_module.SlideFixerGUI(root)
            app1.color_entry.delete(0, tk.END)
            app1.color_entry.insert(0, '#AABBCC')
            app1.size_spinbox.delete(0, tk.END)
            app1.size_spinbox.insert(0, '35')
            app1.text_color_entry.delete(0, tk.END)
            app1.text_color_entry.insert(0, '#112233')
            app1.reset_masters_var.set(True)
            app1.check_overflow_var.set(True)
            app1.invert_colors_var.set(True)
            
            # Save config
            app1.save_config()
            
            # Create new app instance (should load saved config)
            app2 = gui_module.SlideFixerGUI(root)
            
            # Verify settings were restored
            self.assertEqual(app2.color_entry.get(), '#AABBCC')
            self.assertEqual(app2.size_spinbox.get(), '35')
            self.assertEqual(app2.text_color_entry.get(), '#112233')
            self.assertTrue(app2.reset_masters_var.get())
            self.assertTrue(app2.check_overflow_var.get())
            self.assertTrue(app2.invert_colors_var.get())
        finally:
            root.destroy()
    
    def test_config_persistence_across_sessions(self):
        """Test that config persists across multiple app instances."""
        import tkinter as tk
        import fix_slides_for_obs_gui as gui_module
        
        # Session 1: Set and save
        root1 = tk.Tk()
        try:
            app1 = gui_module.SlideFixerGUI(root1)
            app1.invert_colors_var.set(True)
            app1.save_config()
        finally:
            root1.destroy()
        
        # Session 2: Load and verify
        root2 = tk.Tk()
        try:
            app2 = gui_module.SlideFixerGUI(root2)
            self.assertTrue(app2.invert_colors_var.get())
        finally:
            root2.destroy()
    
    def test_load_config_handles_partial_config(self):
        """Test that config with missing keys uses defaults for those keys."""
        import tkinter as tk
        import fix_slides_for_obs_gui as gui_module
        
        # Create a config file with only some keys
        config = {
            'glow_color': '#FF00FF',
            # Missing: glow_size, text_color, reset_masters, etc.
        }
        with open(self.test_config_file, 'w') as f:
            json.dump(config, f)
        
        root = tk.Tk()
        try:
            app = gui_module.SlideFixerGUI(root)
            
            # Provided key should be loaded
            self.assertEqual(app.color_entry.get(), '#FF00FF')
            # Missing keys should use defaults
            self.assertEqual(app.size_spinbox.get(), str(gui_module.DEFAULT_GLOW_SIZE))
            self.assertEqual(app.text_color_entry.get(), gui_module.DEFAULT_TEXT_COLOR)
        finally:
            root.destroy()
    
    def test_load_config_handles_empty_file(self):
        """Test that empty config file doesn't crash the app."""
        import tkinter as tk
        import fix_slides_for_obs_gui as gui_module
        
        # Create empty file
        with open(self.test_config_file, 'w') as f:
            f.write("")
        
        root = tk.Tk()
        try:
            # Should not raise an exception
            app = gui_module.SlideFixerGUI(root)
            # Should use defaults
            self.assertEqual(app.color_entry.get(), gui_module.DEFAULT_GLOW_COLOR)
        finally:
            root.destroy()
    
    def test_load_config_handles_wrong_type_values(self):
        """Test that config with wrong type values doesn't crash."""
        import tkinter as tk
        import fix_slides_for_obs_gui as gui_module
        
        # Create config with wrong types
        config = {
            'glow_color': 12345,  # Should be string
            'glow_size': 'not a number',
            'text_color': None,
            'reset_masters': 'yes',  # Should be bool
            'invert_colors': 1  # Should be bool but int works
        }
        with open(self.test_config_file, 'w') as f:
            json.dump(config, f)
        
        root = tk.Tk()
        try:
            # Should not crash (tkinter will convert values as needed)
            app = gui_module.SlideFixerGUI(root)
            # Just verify app was created
            self.assertIsNotNone(app)
        finally:
            root.destroy()
    
    def test_save_config_overwrites_existing(self):
        """Test that save_config overwrites existing config file."""
        import tkinter as tk
        import fix_slides_for_obs_gui as gui_module
        
        # Create initial config
        initial_config = {'glow_color': '#111111'}
        with open(self.test_config_file, 'w') as f:
            json.dump(initial_config, f)
        
        root = tk.Tk()
        try:
            app = gui_module.SlideFixerGUI(root)
            app.color_entry.delete(0, tk.END)
            app.color_entry.insert(0, '#222222')
            app.save_config()
            
            # Verify file was overwritten
            with open(self.test_config_file, 'r') as f:
                config = json.load(f)
            self.assertEqual(config['glow_color'], '#222222')
        finally:
            root.destroy()
    
    def test_checkbox_false_values_saved_correctly(self):
        """Test that False checkbox values are saved and loaded correctly."""
        import tkinter as tk
        import fix_slides_for_obs_gui as gui_module
        
        root = tk.Tk()
        try:
            app1 = gui_module.SlideFixerGUI(root)
            # Set all checkboxes to False explicitly
            app1.reset_masters_var.set(False)
            app1.check_overflow_var.set(False)
            app1.reposition_var.set(False)
            app1.invert_colors_var.set(False)
            app1.save_config()
            
            # Load and verify all are False
            app2 = gui_module.SlideFixerGUI(root)
            self.assertFalse(app2.reset_masters_var.get())
            self.assertFalse(app2.check_overflow_var.get())
            self.assertFalse(app2.reposition_var.get())
            self.assertFalse(app2.invert_colors_var.get())
        finally:
            root.destroy()
    
    def test_special_characters_in_color_values(self):
        """Test that color values with special characters are handled."""
        import tkinter as tk
        import fix_slides_for_obs_gui as gui_module
        
        root = tk.Tk()
        try:
            app1 = gui_module.SlideFixerGUI(root)
            # Set color with hash symbol
            app1.color_entry.delete(0, tk.END)
            app1.color_entry.insert(0, '#ABCDEF')
            app1.save_config()
            
            app2 = gui_module.SlideFixerGUI(root)
            self.assertEqual(app2.color_entry.get(), '#ABCDEF')
        finally:
            root.destroy()
    
    def test_config_file_is_human_readable(self):
        """Test that config file is formatted and human-readable."""
        import tkinter as tk
        import fix_slides_for_obs_gui as gui_module
        
        root = tk.Tk()
        try:
            app = gui_module.SlideFixerGUI(root)
            app.save_config()
            
            with open(self.test_config_file, 'r') as f:
                content = f.read()
            
            # Should contain newlines (formatted JSON)
            self.assertIn('\n', content)
            # Should be readable as JSON
            config = json.loads(content)
            self.assertIsInstance(config, dict)
        finally:
            root.destroy()


class TestConfigPathPlatform(unittest.TestCase):
    """Test platform-specific config path behavior."""
    
    def test_windows_uses_appdata(self):
        """Test that Windows uses APPDATA directory."""
        import fix_slides_for_obs_gui as gui_module
        
        if sys.platform == 'win32':
            path = gui_module.get_config_path()
            appdata = os.environ.get('APPDATA', '')
            if appdata:
                self.assertTrue(path.startswith(appdata))
    
    def test_path_is_absolute(self):
        """Test that config path is absolute."""
        import fix_slides_for_obs_gui as gui_module
        path = gui_module.get_config_path()
        self.assertTrue(os.path.isabs(path))


if __name__ == '__main__':
    unittest.main(verbosity=2)
