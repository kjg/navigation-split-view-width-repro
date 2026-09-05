# NavigationSplitView width restoration reproduction

This minimal macOS app demonstrates a `NavigationSplitView` restoration issue on
macOS 27. When the sidebar is visible, the middle column becomes narrower and
the detail column becomes wider after quitting and relaunching the app.

The app uses only SwiftUI and plain `Text` views. There are no custom AppKit
views, representables, focus handlers, or application-level persistence.

## Environment

Reproduced with:

- macOS 27.0 (26A5425a)
- Xcode 27.0 (27A5252f)

## Run

```sh
./run.sh
```

The script builds an ad-hoc signed app in `.build/` and launches it.

## Reproduction steps

1. Run `./run.sh`.
2. Leave the sidebar visible.
3. Drag the divider between **Content** and **Detail** so the Content column is
   noticeably wide.
4. Quit the app with Command-Q.
5. Run `./run.sh` again.
6. Repeat steps 4 and 5.

The Content column becomes narrower and the Detail column becomes wider. The
amount lost by Content corresponds to the visible Sidebar width.

The issue does not occur when the sidebar is hidden before quitting.

## Saved state

SwiftUI stores the column geometry in:

```sh
defaults read com.kjg.SplitViewWidthRepro \
  "NSSplitView Subview Frames main, SidebarNavigationSplitView"
```

For example, this valid three-column state:

```text
300 / 600 / 499
```

is restored on macOS 27 as:

```text
300 / 300 / 799
```

The restored middle column loses exactly the sidebar's 300-point width.

Reset the app's saved state with:

```sh
./reset-state.sh
```
