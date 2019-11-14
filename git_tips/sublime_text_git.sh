#!/bin/bash
"/cygdrive/f/SublimeText/Vanilla/sublime_text.exe" -w -n "`cygpath -w $@`"
echo `cygpath -w $@`
