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

## 0.1.7

- **Fix:** `title` and `message` are now fully optional — pass any combination of `title`, `richTitle`, `message`, or `richMessage`; at least one must be provided
- **Fix:** `onTap` callback was never invoked due to `GestureDetector` being built but not used as the container's child
- **Fix:** `blockBackgroundInteraction` barrier now covers the full screen instead of being clipped inside the snackbar bounds
- **Fix:** `Dismissible` now uses a `UniqueKey` per instance, preventing key conflicts when multiple snackbars are shown simultaneously
- Added constructor-level assertions to `FabrikSnackbarConfig` for `title`/`richTitle` and `message`/`richMessage` mutual exclusivity
