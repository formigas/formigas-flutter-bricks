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
The build stage will create a release build and runs a different flavor depending on the branch:  
- `develop` runs the `development` flavor
- `staging` runs the `staging` flavor
- `master`/`main` runs the `production` flavor

If the pipeline is run on a merge request, the test stage will add the test coverage to it. Additionally, the pipeline will output code coverage reports.

### Setup GitLab CI for Android builds
For Android builds, an upload key is required. Please refer to [Create an upload keystore](https://docs.flutter.dev/deployment/android#create-an-upload-keystore) to create a keystore. Remember that the keystore's password needs to be at least 8 characters long for GitLab to be able to store it as a masked variable. After having created the keystore, follow these steps to make it available to the pipeline:
1. Upload the keystore file to GitLab Secure Files in your project settings
2. Add the keystore password to the GitLab CI/CD settings as a masked variable with the key `ANDROID_KEYSTORE_PASSWORD`
3. Add the key password (usually the same as the keystore password) to the GitLab CI/CD settings as a masked variable with the key `ANDROID_KEYSTORE_PRIVATE_KEY_PASSWORD`
4. The pipeline assumes a keystore name of `upload-keystore.jks`. If you changed the name of the keystore file, update the `ANDROID_KEYSTORE_PATH` in `templates/build.yml` in the `build_android_$[[ inputs.flavor ]]` section to use the name of your keystore file.
5. Add the alias of the keystore to the GitLab CI/CD settings as a variable with the key `ANDROID_KEYSTORE_ALIAS`. The alias can be found in the command you used to create the keystore.

### Setup for iOS builds
For iOS builds, having a GitLab Runner running macOS is required. Please refer to the [GitLab documentation](https://docs.gitlab.com/runner/install/osx.html) for setup instructions if you don't have one yet. Then follow [Manage Runners](https://docs.gitlab.com/ee/ci/runners/runners_scope.html) to set up the runner for your project. During the `mason make` dialog you will be prompted to enter the tag configured for the runner after you chose `GitLab CI` as your automation service provider.  

### Configuration
The pipeline is defined in `.gitlab-ci.yml`, while the build stage is defined in `templates/build.yml`.  
- Flutter version: Make sure to update the `FLUTTER_VERSION` variable to the version of Flutter you want to use. 
- Image: By default, [cirruslabs Flutter Docker images](https://github.com/cirruslabs/docker-images-flutter/pkgs/container/flutter) are used. If you want to use a different image, update the `FLUTTER_DOCKER_IMAGE` variable.


### Troubleshooting
#### Error when building Android app
```
Execution failed for task ':app:signDevelopmentReleaseBundle'.
> A failure occurred while executing com.android.build.gradle.internal.tasks.FinalizeBundleTask$BundleToolRunnable
   > java.lang.NullPointerException (no error message)
```
This error occurs when signing failed. Make sure you closely followed the steps in the [Setup GitLab CI for Android builds](#setup-gitlab-ci-for-android-builds) section. If any of the steps are not followed, the pipeline will fail with the above error.

## GitHub Actions CI
The GitHub Actions CI pipeline runs validation, build and tests.  
The pipeline is run on every push to `develop`, `staging` and `master`/`main` branches, as well as on every merge request.  
The build stage will create a release build and runs a different flavor depending on the branch:  
- `develop` runs the `development` flavor
- `staging` runs the `staging` flavor
- `master`/`main` runs the `production` flavor

### Setup GitHub Actions for Android builds
For Android builds, an upload key is required. Please refer to [Create an upload keystore](https://docs.flutter.dev/deployment/android#create-an-upload-keystore) to create a keystore. Remember that the keystore's password needs to be at least 8 characters long for GitLab to be able to store it as a masked variable. After having created the keystore, follow these steps to make it available to the pipeline:
1. Encode the keystore file to base64. You can use the following command assuming your keystore file is named `upload-keystore.jks` to encode it and then copy and paste the output to the repository secret:
```sh
cat upload-keystore.jks | base64
```
1. Add the keystore password as a repository secret with the name `ANDROID_KEYSTORE_PASSWORD`
2. Add the key password (usually the same as the keystore password) as a repository secret with the name `ANDROID_KEYSTORE_PRIVATE_KEY_PASSWORD`
3. Add the alias of the keystore as a repository variable (not secret) with the name `ANDROID_KEYSTORE_ALIAS`. The alias can be found in the command you used to create the keystore.

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

## Bitbucket Pipeline CI
The Bitbucket Pipeline CI runs validation, build, and tests.  
The pipeline is run on every push to `develop`, `staging`, and `master`/`main` branches, as well as on every pull request.  
The build stage will create a release build and runs a different flavor depending on the branch:  
- `develop` runs the `development` flavor
- `staging` runs the `staging` flavor
- `master`/`main` runs the `production` flavor

### Setup Bitbucket Pipelines for Android builds
For Android builds, an upload key is required. Please refer to [Create an upload keystore](https://docs.flutter.dev/deployment/android#create-an-upload-keystore) to create a keystore. After having created the keystore, follow these steps to make it available to the pipeline:
1. Encode the keystore file to base64. You can use the following command assuming your keystore file is named `upload-keystore.jks` to encode it:
    ```sh
    cat upload-keystore.jks | base64
    ```
2. Add the keystore password as a repository variable named `ANDROID_KEYSTORE_PASSWORD`
3. Add the key password (usually the same as the keystore password) as a repository variable named `ANDROID_KEYSTORE_PRIVATE_KEY_PASSWORD`
4. Add the alias of the keystore as a repository variable with the name `ANDROID_KEYSTORE_ALIAS`. The alias can be found in the command you used to create the keystore.

### Setup for iOS builds
For iOS builds, currently a macOS self-hosted runner is required. Please refer to [Adding a new runner in Bitbucket](https://support.atlassian.com/bitbucket-cloud/docs/adding-a-new-runner-in-bitbucket/) for setup instructions if you don't have one yet. The pipeline assumes the default runner tags `self.hosted` and `macos`.

### Configuration
The pipeline is defined in `bitbucket-pipelines.yml`, with separate steps for validation, build (iOS and Android), and tests.
- Flutter version: Ensure the Flutter Docker image version matches the version you want to use. This is set in the `image` at the top of the `bitbucket-pipelines.yml` file.
- Runners: For iOS builds, make sure you have a self-hosted macOS runner available and correctly tagged to handle the iOS build steps. If you use different tags than the default ones, you can adjust them in the `&build-ios` step.

### Troubleshooting
#### Error when building Android app
```
Execution failed for task ':app:signDevelopmentReleaseBundle'.
> A failure occurred while executing com.android.build.gradle.internal.tasks.FinalizeBundleTask$BundleToolRunnable
   > java.lang.NullPointerException (no error message)
```
This error occurs when signing failed. Make sure you closely followed the steps in the [Setup Bitbucket Pipelines for Android builds](#setup-bitbucket-pipelines-for-android-builds) section. If any of the steps are not followed, the pipeline will fail with the above error.


[very_good_ventures_link]: https://github.com/VeryGoodOpenSource/{{project_name.snakeCase()}}
