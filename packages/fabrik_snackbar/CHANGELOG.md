# [0.1.0] - Initial release

- `FabrikSnackbar.success`, `.error`, `.info`, `.warning`
- `FabrikSnackbar.custom` for full flexibility
- Support for position, safe area, background blur, dismiss direction
- `FabrikToast.show` with positioning and style customization
- Overlay-based display system with animations
- Defaults and config objects for advanced use cases

## 0.1.1

- Added icon in toast
- Added border radius in toast
- Updated documentation

## 0.1.2

- Fixed fabrik tool website link in docs

## 0.1.3

- Changed Snackbar's Material color to transparent

## 0.1.4

- updated repository url

## 0.1.5

- Added rich content support with `richTitle` and `richMessage` parameters for styled text
- Built-in accessibility features with semantic labels and live regions
- Updated documentation

## 0.1.6

- Improved documentation

## 0.1.8

- **Fix:** `FabrikSnackbarPosition`, `FabrikSnackbarStyle`, and `FabrikSnackbarDismissDirection` are now exported. They appeared in the public API's parameter lists but were never exported from `fabrik_snackbar.dart`, so `position: FabrikSnackbarPosition.top` — the example published in the README — did not compile for anyone installing the package. `FabrikSnackbarDefaults` is now exported too.
- **Fix:** Swipe-to-dismiss no longer keeps the overlay entry mounted after the snackbar has visually gone. `Dismissible` removes the child as soon as the gesture completes, and the widget then ran its full 400 ms slide-out on something already off screen — delaying `onDismissed` and the entry's removal by roughly 800 ms. Dismissal now completes as soon as the swipe does.
- **Fix:** A swipe that races the auto-dismiss timer no longer triggers two dismissals; `onDismissed` is invoked exactly once.
- **Fix:** Showing a snackbar or toast with a context that has no `Overlay` ancestor now logs the intended diagnostic instead of throwing a framework assertion. The previous `Overlay.of(...)` lookup threw before the guard could run, making the fallback unreachable.
- **New:** `titleStyle` and `messageStyle` on `FabrikSnackbarConfig` and on all four named variants, for styling plain-string content without replacing it with custom widgets. Defaults are unchanged, so existing snackbars render identically.
- **New:** `FabrikSnackbarDefaults.defaultTitleStyle` and `defaultMessageStyle`, composed from the existing font-size, weight, and color constants which the widget previously ignored in favour of inline literals.
- **Tests:** Suite grown from 2 to 73 tests, covering every variant, content-priority rules, dismissal paths, the barrier, accessibility labels, and the public export surface.

---

## 0.1.7

- **Fix:** `title` and `message` are now fully optional — pass any combination of `title`, `richTitle`, `message`, or `richMessage`; at least one must be provided
- **Fix:** `onTap` callback was never invoked due to `GestureDetector` being built but not used as the container's child
- **Fix:** `blockBackgroundInteraction` barrier now covers the full screen instead of being clipped inside the snackbar bounds
- **Fix:** `Dismissible` now uses a `UniqueKey` per instance, preventing key conflicts when multiple snackbars are shown simultaneously
- Added constructor-level assertions to `FabrikSnackbarConfig` for `title`/`richTitle` and `message`/`richMessage` mutual exclusivity
