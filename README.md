# NavigationSplitView width restoration reproduction

This minimal macOS app demonstrates a `NavigationSplitView` restoration issue on
macOS 27. When the sidebar is visible, the middle column becomes narrower and
the detail column becomes wider after quitting and relaunching the app.

The app uses only SwiftUI and plain `Text` views. There are no custom AppKit
views, representables, focus handlers, or application-level persistence.

## Video

https://github.com/user-attachments/assets/de3d48bc-6c54-47a7-a97b-2384ac2bcb57

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

1. Run `./reset-state.sh`.
2. Run `./seed-state.sh`.
3. Run `./run.sh`.
4. Leave the sidebar visible and quit the app with Command-Q.
5. Run `./run.sh` again.

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

Running `./seed-state.sh` again restores the original values for another test.

Reset the app's saved state with:

```sh
./reset-state.sh
```
