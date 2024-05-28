# formigas Feature Brick

A brick that provides the files and structure for a feature how we implement it at [formigas][formigas_link] in our flutter projects.
It follows the principles of the MVC-pattern.

The brick formigas_feature is also part of the [formigas_core][core_repo_link], but can also used on its own.

[![License: MIT][license_badge]][license_link]
[![Powered by Mason][mason_badge]][mason_link]

## Usage 🏗️

The formigas_feature brick is automatically added to your mason, if you already generated a project with the formigas_core brick.
To only add the formigas_feature brick to your local mason run:

```sh
$ mason init
$ mason add formigas_feature --git-url git@git.dev.formigas.de:framework/bricks.git --git-path core --git-ref develop
```

The formigas_feature brick should show up in the list of mason bricks:

```
$ mason list
/Users/User/foo/bar
└── formigas_feature 0.0.1 -> git@git.dev.formigas.de:framework/bricks.git#{commit-hash}
```

To add a new feature to your app run the following command in the root of your project:

```sh
mason make formigas_feature
```
## Output 📦

```sh
├── features
│   ├── counter
│   │   ├── counter_controller.dart
│   │   ├── counter_model.dart
│   │   ├── counter_model.freezed.dart
│   │   └── counter_view.dart
```
## Dependencies
Following dependencies will be installed for this brick:

* [formigas_mvc][formigas_mvc_link]
* [freezed_annotation][freezed_annotation_link]
* [freezed][freezed_link]
* [build_runner][build_runner_link]


[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[formigas_link]: https://formigas.io
[mason_link]: https://github.com/felangel/mason
[mason_badge]: https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge
[core_repo_link]: ./core/README.md
[freezed_annotation_link]:https://pub.dev/packages/freezed_annotation
[freezed_link]: https://pub.dev/packages/freezed
[build_runner_link]: https://pub.dev/packages/build_runner
[flutter_link]:https://flutter.dev/
[formigas_mvc_link]:https://git.dev.formigas.de/framework/lib-formigas-mvc
