# CI/CD
## GitLab CI
The GitLab CI pipeline runs validation, build and tests.  
The pipeline is run on every push to `develop`, `staging` and `master`/`main` branches, as well as on every merge request.  
The build stage runs a different flavor depending on the branch:  
- `develop` runs the `development` flavor
- `staging` runs the `staging` flavor
- `master`/`main` runs the `production` flavor

If the pipeline is run on a merge request, the test stage will add the test coverage to it. Additionally, the pipeline will output code coverage reports.

### Setup for iOS builds
For iOS builds, having a GitLab Runner running macOS is required. Please refer to the [GitLab documentation](https://docs.gitlab.com/runner/install/osx.html) for setup instructions if you don't have one yet. Then follow [Manage Runners](https://docs.gitlab.com/ee/ci/runners/runners_scope.html) to set up the runner for your project. During the `mason make` dialog you will be prompted to enter the tag configured for the runner after you chose `GitLab CI` as your automation service provider.  

### Configuration
The pipeline is defined in `.gitlab-ci.yml`, while the build stage is defined in `templates/build.yml`.  
- Flutter version: Make sure to update the `FLUTTER_VERSION` variable to the version of Flutter you want to use. 
- Image: By default, [cirruslabs Flutter Docker images](https://github.com/cirruslabs/docker-images-flutter/pkgs/container/flutter) are used. If you want to use a different image, update the `FLUTTER_DOCKER_IMAGE` variable.



# Very Good Core

[![Very Good Ventures][logo_white]][very_good_ventures_link_dark]

Developed with 💙 by [Very Good Ventures][very_good_ventures_link] 🦄

[![License: MIT][license_badge]][license_link]
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A Very Good Flutter app created by Very Good Ventures 🦄.

## What's Included ✨

Out of the box, Very Good Core includes:

- ✅ [Cross Platform Support][flutter_cross_platform_link] - Built-in support for iOS, Android, Web, and Windows (MacOS/Linux coming soon!)
- ✅ [Build Flavors][flutter_flavors_link] - Multiple flavor support for development, staging, and production
- ✅ [Internationalization Support][internationalization_link] - Internationalization support using synthetic code generation to streamline the development process
- ✅ [Sound Null-Safety][null_safety_link] - No more null-dereference exceptions at runtime. Develop with a sound, static type system.
- ✅ [Bloc][bloc_link] - Integrated bloc architecture for scalable, testable code which offers a clear separation between business logic and presentation
- ✅ [Testing][testing_link] - Unit and Widget Tests with 100% line coverage (Integration Tests coming soon!)
- ✅ [Logging][logging_link] - Built-in, extensible logging to capture uncaught Flutter and Dart Exceptions
- ✅ [Very Good Analysis][very_good_analysis_link] - Strict Lint Rules which are used at [Very Good Ventures][very_good_ventures_link]
- ✅ [Continuous Integration][github_actions_link] - Lint, format, test, and enforce code coverage using [GitHub Actions][github_actions_link]
- ✅ Dependabot Integration

_\* Learn more at [Flutter Starter App: Very Good Core & CLI][very_good_cli_blog_link]_

## Output 📦

```sh
├── .github
│   ├── PULL_REQUEST_TEMPLATE.md
│   ├── dependabot.yaml
│   └── workflows
│       └── main.yaml
├── .gitignore
├── .idea
│   └── runConfigurations
│       ├── development.xml
│       ├── production.xml
│       └── staging.xml
├── .vscode
│   ├── extensions.json
│   └── launch.json
├── LICENSE
├── README.md
├── analysis_options.yaml
├── android
├── coverage_badge.svg
├── ios
├── l10n.yaml
├── lib
│   ├── app
│   │   ├── app.dart
│   │   └── view
│   ├── bootstrap.dart
│   ├── counter
│   │   ├── counter.dart
│   │   ├── cubit
│   │   └── view
│   ├── l10n
│   │   ├── arb
│   │   └── l10n.dart
│   ├── main_development.dart
│   ├── main_production.dart
│   └── main_staging.dart
├── pubspec.lock
├── pubspec.yaml
├── test
│   ├── app
│   │   └── view
│   ├── counter
│   │   ├── cubit
│   │   └── view
│   └── helpers
│       ├── helpers.dart
│       └── pump_app.dart
├── web
└── windows   
```

[bloc_link]: https://bloclibrary.dev
[flutter_cross_platform_link]: https://flutter.dev/docs/development/tools/sdk/release-notes/supported-platforms
[flutter_flavors_link]: https://flutter.dev/docs/deployment/flavors
[github_actions_link]: https://github.com/features/actions
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_white]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_white.png#gh-dark-mode-only
[logging_link]: https://api.flutter.dev/flutter/dart-developer/log.html
[null_safety_link]: https://flutter.dev/docs/null-safety
[testing_link]: https://flutter.dev/docs/testing
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_blog_link]: https://verygood.ventures/blog/flutter-starter-app-very-good-core-cli
[very_good_ventures_link_dark]: https://verygood.ventures#gh-dark-mode-only
[very_good_ventures_link]: https://verygood.ventures
[very_good_workflows_link]: https://github.com/VeryGoodOpenSource/very_good_workflows
