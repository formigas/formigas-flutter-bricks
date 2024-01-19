# Flutter Core

This is a fork of the [Very Good Flutter Starter Project created by the Very Good Ventures Team][very_good_ventures_link].

---

## Getting Started 🚀

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

_\*{{project_name.titleCase()}} works on iOS, Android, Web, and Windows._

---

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

---

## Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/l10n/arb/app_en.arb`.

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

2. Then add a new key/value and description

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    },
    "helloWorld": "Hello World",
    "@helloWorld": {
        "description": "Hello World Text"
    }
}
```

3. Use the new string

```dart
import 'package:{{project_name.snakeCase()}}/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```

### Adding Translations

1. For each supported locale, add a new ARB file in `lib/l10n/arb`.

```
├── l10n
│   ├── arb
│   │   ├── app_en.arb
│   │   └── app_es.arb
```

2. Add the translated strings to each `.arb` file:

`app_en.arb`

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

`app_es.arb`

```arb
{
    "@@locale": "es",
    "counterAppBarTitle": "Contador",
    "@counterAppBarTitle": {
        "description": "Texto mostrado en la AppBar de la página del contador"
    }
}
```

### Generating Translations

To use the latest translations changes, you will need to generate them:

1. Generate localizations for the current project:

```sh
flutter gen-l10n --arb-dir="lib/l10n/arb"
```

Alternatively, run `flutter run` and code generation will take place automatically.

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


[very_good_ventures_link]: https://github.com/VeryGoodOpenSource/{{project_name.snakeCase()}}
