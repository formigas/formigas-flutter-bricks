# GitHub Actions CI
The GitHub Actions CI pipeline runs validation, build and tests.  
The pipeline is run on every push to `develop`, `staging` and `master`/`main` branches, as well as on every merge request.  
The build stage will create a release build and runs a different flavor depending on the branch:  
- `develop` runs the `development` flavor
- `staging` runs the `staging` flavor
- `master`/`main` runs the `production` flavor

## Setup GitHub Actions for Android builds
For Android builds, an upload key is required. Please refer to [Create an upload keystore](https://docs.flutter.dev/deployment/android#create-an-upload-keystore) to create a keystore. After having created the keystore, follow these steps to make it available to the pipeline:
1. Encode the keystore file to base64. You can use the following command assuming your keystore file is named `upload-keystore.jks` to encode it and then copy and paste the output to the repository secret:
```sh
cat upload-keystore.jks | base64
```
2. Add the keystore password as a repository secret with the name `ANDROID_KEYSTORE_PASSWORD`
3. Add the key password (usually the same as the keystore password) as a repository secret with the name `ANDROID_KEYSTORE_PRIVATE_KEY_PASSWORD`
4. Add the alias of the keystore as a repository variable (not secret) with the name `ANDROID_KEYSTORE_ALIAS`. The alias can be found in the command you used to create the keystore.

## Configuration
The pipeline is defined in `.github/workflows/continuous-integration.yml`, while the build action is in `.github/actions/build_app/action.yml`.
- Flutter version: Make sure to update the `FLUTTER_VERSION` to the version of Flutter you want to use
  
The pipeline uses following actions:
- [actions/checkout](https://github.com/marketplace/actions/checkout): Checkout the repository
- [subosito/flutter-action](https://github.com/marketplace/actions/flutter-action): Install Flutter
- [dorny/test-reporter](https://github.com/marketplace/actions/test-reporter): Add test coverage to workflow summary
- [zgosalvez/github-actions-report-lcov](https://github.com/marketplace/actions/report-lcov): Upload html coverage report to workflow artifacts and comment coverage on Pull Requests

Please refer to their documentation for configuration details

## Troubleshooting
### Error when building Android app
```
Execution failed for task ':app:signDevelopmentReleaseBundle'.
> A failure occurred while executing com.android.build.gradle.internal.tasks.FinalizeBundleTask$BundleToolRunnable
   > java.lang.NullPointerException (no error message)
```
This error occurs when signing failed. Make sure you closely followed the steps in the [Setup GitHub Actions for Android builds](#setup-github-actions-for-android-builds) section. If any of the steps are not followed, the pipeline will fail with the above error.