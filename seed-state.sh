#!/bin/bash

set -euo pipefail

defaults write com.kjg.SplitViewWidthRepro \
    "NSSplitView Subview Frames main, SidebarNavigationSplitView" \
    -array \
    "0.000000, 0.000000, 300.000000, 700.000000, NO, NO" \
    "300.000000, 0.000000, 600.000000, 700.000000, NO, NO" \
    "901.000000, 0.000000, 499.000000, 700.000000, NO, NO"
