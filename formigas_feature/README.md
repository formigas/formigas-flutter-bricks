# formigas Feature Brick

A brick to create a feature how we implement it at [formigas][formigas_link]. It follows the principles of the MVC-pattern.

[![License: MIT][license_badge]][license_link]
[![Powered by Mason][mason_badge]][mason_link]

## Usage 🛠️

See [BrickHub][brick_hub_usage_link] for usage instructions.

## Output 📦

```sh
├── features
│   ├── counter
│   │   ├── cubit
│   │   │   ├── counter_cubit.dart
│   │   │   ├── counter_state.dart
│   │   │   ├── counter_state.freezed.dart
│   │   └── counter_view.dart
```

## Dependencies
Following dependencies will be installed for this brick if they are not yet present:

* [flutter_bloc][flutter_bloc_link]
* [bloc_test][bloc_test_link]
* [freezed_annotation][freezed_annotation_link]
* [freezed][freezed_link]
* [build_runner][build_runner_link]

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[formigas_link]: https://formigas.io
[mason_link]: https://github.com/felangel/mason
[mason_cli_link]: https://github.com/felangel/mason/tree/master/packages/mason_cli
[mason_badge]: https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge
[freezed_annotation_link]:https://pub.dev/packages/freezed_annotation
[freezed_link]: https://pub.dev/packages/freezed
[build_runner_link]: https://pub.dev/packages/build_runner
[flutter_bloc_link]:https://pub.dev/packages/flutter_bloc
[bloc_test_link]:https://pub.dev/packages/bloc_test
[brick_hub_usage_link]:https://brickhub.dev/bricks/formigas_feature#usage
