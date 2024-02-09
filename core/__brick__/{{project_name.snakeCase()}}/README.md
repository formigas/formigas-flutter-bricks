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

## GitHub Actions CI
The GitHub Actions CI pipeline runs validation, build and tests.  
The pipeline is run on every push to `develop`, `staging` and `master`/`main` branches, as well as on every merge request.  
The build stage will create a release build and runs a different flavor depending on the branch:  
- `develop` runs the `development` flavor
- `staging` runs the `staging` flavor
- `master`/`main` runs the `production` flavor

### Setup GitHub Actions for Android builds
For Android builds, an upload key is required. Please refer to [Create an upload keystore](https://docs.flutter.dev/deployment/android#create-an-upload-keystore) to create a keystore. Remember that the keystore's password needs to be at least 8 characters long for GitLab to be able to store it as a masked variable. After having created the keystore, follow these steps to make it available to the pipeline:
1. Encode the keystore file to base64 and add it as a repository secret with the name `ANDROID_KEYSTORE_BASE64`. You can use the following command assuming your keystore file is named `upload-keystore.jks` to encode it and then copy and paste the output to the repository secret:
```sh
cat upload-keystore.jks | base64
```
2. Add the keystore password as a repository secret with the name `ANDROID_KEYSTORE_PASSWORD`
3. Add the key password (usually the same as the keystore password) as a repository secret with the name `ANDROID_KEYSTORE_PRIVATE_KEY_PASSWORD`
4. Add the alias of the keystore as a repository variable (not secret) with the name `ANDROID_KEYSTORE_ALIAS`. The alias can be found in the command you used to create the keystore.

### Configuration
The pipeline is defined in `.github/workflows/continuous-integration.yml`, while the build action is in `.github/actions/build_app/action.yml`.
- Flutter version: Make sure to update the `FLUTTER_VERSION` to the version of Flutter you want to use
  
The pipeline uses following actions:
- [actions/checkout](https://github.com/marketplace/actions/checkout): Checkout the repository
- [subosito/flutter-action](https://github.com/marketplace/actions/flutter-action): Install Flutter
- [dorny/test-reporter](https://github.com/marketplace/actions/test-reporter): Add test coverage to workflow summary
- [zgosalvez/github-actions-report-lcov](https://github.com/marketplace/actions/report-lcov): Upload html coverage report to workflow artifacts and comment coverage on Pull Requests

Please refer to their documentation for configuration details

### Troubleshooting
#### Error when building Android app
```
Execution failed for task ':app:signDevelopmentReleaseBundle'.
> A failure occurred while executing com.android.build.gradle.internal.tasks.FinalizeBundleTask$BundleToolRunnable
   > java.lang.NullPointerException (no error message)
```
This error occurs when signing failed. Make sure you closely followed the steps in the [Setup GitHub Actions for Android builds](#setup-github-actions-for-android-builds) section. If any of the steps are not followed, the pipeline will fail with the above error.


[very_good_ventures_link]: https://github.com/VeryGoodOpenSource/{{project_name.snakeCase()}}
