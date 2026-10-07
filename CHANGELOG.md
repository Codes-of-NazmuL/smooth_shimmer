## 1.0.0

- Initial release of `smooth_shimmer`.
- High-performance, customizable skeleton loading shimmer.
- Features:
  - `SmoothShimmer` widget and `.shimmer(...)` extension on `Widget`.
  - ShaderMask-based linear gradient sweep with customizable direction (`leftToRight`, `rightToLeft`, `topToBottom`, `bottomToTop`).
  - Automatic theme awareness (dark and light mode default palettes).
  - Configurable `baseColor`, `highlightColor`, and `duration`.
  - `enabled` toggle to effortlessly switch between skeleton placeholder and live content.
  - Accessibility support honoring `MediaQuery.disableAnimationsOf`.
  - Zero external dependencies.
