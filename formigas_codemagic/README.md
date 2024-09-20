# formigas Codemagic CI

A brick that provides a [Codemagic][codemagic_link] Continuous Integration workflow for [Flutter][flutter_link] projects as we use it at [formigas][formigas_link].  

See [Details](#details) for more info about the pipeline and Troubleshooting.

[![License: MIT][license_badge]][license_link]
[![Powered by Mason][mason_badge]][mason_link]

## Usage 🛠️

See [BrickHub][brick_hub_usage_link] for usage instructions.

## Output 📦
The workflow file
```
codemagic.yaml
```
## Details
The Codemagic CI pipeline runs validation, build and tests.  
The pipeline is run on every pull request and push to the repository.  
The build stage will create a release build and runs on the `production` flavor.

The test stage will generate a coverage and test results report and upload them to the Codemagic artifacts page.

### Setup and Configuration

#### Setup Codemagic for Android builds
For Android builds, an upload key is required. Please refer to [Android code signing](https://docs.codemagic.io/flutter-code-signing/android-code-signing/) to create a keystore and make it available to the pipeline.

#### Setup Codemagic for iOS builds
No additional setup is required for iOS builds.

#### Configuration
The pipeline is defined in `codemagic.yaml`.

- Flutter version: Defined by the value of `flutter` in the environment section. The default is `stable`.
- Xcode version: Defined by the value of `xcode` in the environment section. The default is `latest`.

### Troubleshooting
##### Error when building Android app
```
Execution failed for task ':app:signDevelopmentReleaseBundle'.
> A failure occurred while executing com.android.build.gradle.internal.tasks.FinalizeBundleTask$BundleToolRunnable
```

This error occurs when the `android_signing` environment variable is not set correctly. Please refer to the [Android code signing](https://docs.codemagic.io/flutter-code-signing/android-code-signing/) documentation to set it up.


[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[formigas_link]: https://formigas.io
[mason_link]: https://github.com/felangel/mason
[mason_cli_link]: https://github.com/felangel/mason/tree/master/packages/mason_cli
[mason_badge]: https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge
[flutter_link]:https://flutter.dev/
[brick_hub_usage_link]:https://brickhub.dev/bricks/formigas_codemagic#usage
[codemagic_link]:https://codemagic.io/
