# Verified dependency inventory

Checked on 2026-11-17 using an isolated Flutter 3.50.0 (stable tag ab2912035e) / Dart 3.14.0 SDK. The shared Flutter installation was not modified.

All direct and transitive packages were re-resolved with `flutter pub upgrade --major-versions`; material_ui was added for the official Material migration. The committed lockfile is authoritative. Do not add transitive packages to pubspec merely to reproduce this list.

- `async`: 2.13.1
- `boolean_selector`: 2.1.2
- `characters`: 1.4.1
- `clock`: 1.1.3
- `collection`: 1.19.1
- `cupertino_ui`: 1.1.7
- `fake_async`: 1.3.3
- `flutter`: provided by Flutter 3.50.0
- `flutter_lints`: 6.0.0
- `flutter_localizations`: provided by Flutter 3.50.0
- `flutter_test`: provided by Flutter 3.50.0
- `intl`: 0.20.3
- `leak_tracker`: 11.0.2
- `leak_tracker_flutter_testing`: 3.0.10
- `leak_tracker_testing`: 3.0.2
- `lints`: 6.1.0
- `listen`: 1.0.1
- `matcher`: 0.12.20
- `material_color_utilities`: 0.13.0
- `material_ui`: 1.11.1
- `meta`: 1.19.0
- `path`: 1.9.1
- `sky_engine`: provided by Flutter 3.50.0
- `source_span`: 1.10.2
- `stack_trace`: 1.12.2
- `stream_channel`: 2.1.4
- `string_scanner`: 1.4.1
- `term_glyph`: 1.2.2
- `test_api`: 0.7.14
- `vector_math`: 2.4.4
- `vm_service`: 15.4.0

## SDK constraints

`material_color_utilities` 0.13.0 and `test_api` 0.7.14 are fixed by the Flutter SDK. Their latest catalog versions (0.13.1 and 0.7.15) cannot be selected by the compatible resolver. No dependency overrides were introduced. `flutter_lints` 6.0.0 is already the latest stable release checked. The final pub outdated report distinguishes Current, Upgradable, Resolvable and Latest; “updated” here means newest compatible versions, not a forced incompatible graph.

## Native build configuration

The Android files now follow Flutter 3.50.0 templates: Gradle 9.5.0, Android Gradle Plugin 9.3.1 and Kotlin 2.4.20 (built-in Kotlin, JVM 17), minimum API 24. Native builds remain outside the verified result because Android SDK licenses are pending and no current iOS build has passed. Web and widget validation are recorded separately.
