# formigas GitLab CI
A brick that provides a GitLab CI Continuous Integration pipeline for [Flutter][flutter_link] projects as we use it at [formigas][formigas_link].  

See [Details](#setup-and-configuration) for more info about the pipeline and Troubleshooting.

[![License: MIT][license_badge]][license_link]
[![Powered by Mason][mason_badge]][mason_link]

## Usage 🛠️

See [BrickHub][brick_hub_usage_link] for usage instructions.

## Output 📦
The pipeline configuration files
```
gitlab-ci.yml 
templates
└── build.yml
```

## Setup and Configuration
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

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[formigas_link]: https://formigas.io
[mason_link]: https://github.com/felangel/mason
[mason_cli_link]: https://github.com/felangel/mason/tree/master/packages/mason_cli
[mason_badge]: https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge
[flutter_link]:https://flutter.dev/
[brick_hub_usage_link]:https://brickhub.dev/bricks/formigas_gitlab_ci#usage
