# Modernization log

## 2026-11-17 — arithmetic and SDK migration

- Cloned the clean `master` branch at `5c7a69e`; verified the origin and default branch. No project AGENTS.md was present.
- Inspected the actual Dart sources and Android/iOS manifests: Dart 2.1 constraints, pre-null-safety state, removed RaisedButton API, obsolete Gradle and a counter test unrelated to the app.
- Wrote arithmetic behavior tests, observed the original code fail to compile on Dart 3, then made only the null-safety changes needed to run them. Observed two behavioral failures: repeated equals (12 instead of 10), and continuing a result (32 instead of 20).
- Replaced the untyped two-slot buffer with explicit operation and entry-phase enums. Preserved left-to-right evaluation and Euclidean modulo. Fixed equals/pending operator behavior; added bounded input, sign switching, recoverable division/modulo-by-zero and range errors, and a documented display rounding policy.
- Migrated to Flutter 3.41.9 / Dart 3.11.5 and removed auto_size_text. The first four domain tests passed; the expanded suite covers signs, validation, precision, limits and recovery.
- Ran crapper, dryer (threshold 0.8) and mutator --scan on lib: all returned “No source files” because these installed tools do not support Dart. No CRAP, duplication or mutation score is claimed.

## Interface and platforms

- Wrote widget scenarios before replacing the old UI; observed compile failures for removed APIs/dependency. Implemented Material 3 controls, responsive layout, tabular result digits, a live semantic result, descriptive controls, keyboard handling and safe sample calculations.
- Initial touch test correctly revealed off-screen controls. Moved the calculator ahead of teaching notes on narrow screens and made the test scroll to controls, as a user must on short screens. Fourteen domain/widget tests then passed, including 320×568, 740×360 and 1280×800 at 1.8× text scale.
- Regenerated platform scaffolding from the installed SDK in a temporary project, preserving original app icons and application/bundle identifiers. Removed Eclipse metadata and replaced legacy Gradle scripts with the current plugin DSL. Added Web startup/retry feedback and pinned CI.
- Android doctor reports unaccepted licenses. No licenses accepted or global SDK configuration changed. Native device testing is not claimed.
