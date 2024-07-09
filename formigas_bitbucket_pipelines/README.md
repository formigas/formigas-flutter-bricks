TODO: complete Markdown

# Bitbucket Pipeline CI
The Bitbucket Pipeline CI runs validation, build, and tests.  
The pipeline is run on every push to `develop`, `staging`, and `master`/`main` branches, as well as on every pull request.  
The build stage will create a release build and runs a different flavor depending on the branch:  
- `develop` runs the `development` flavor
- `staging` runs the `staging` flavor
- `master`/`main` runs the `production` flavor

## Setup Bitbucket Pipelines for Android builds
For Android builds, an upload key is required. Please refer to [Create an upload keystore](https://docs.flutter.dev/deployment/android#create-an-upload-keystore) to create a keystore. After having created the keystore, follow these steps to make it available to the pipeline:
1. Encode the keystore file to base64. You can use the following command assuming your keystore file is named `upload-keystore.jks` to encode it:
    ```sh
    cat upload-keystore.jks | base64
    ```
2. Add the keystore password as a repository variable named `ANDROID_KEYSTORE_PASSWORD`
3. Add the key password (usually the same as the keystore password) as a repository variable named `ANDROID_KEYSTORE_PRIVATE_KEY_PASSWORD`
4. Add the alias of the keystore as a repository variable with the name `ANDROID_KEYSTORE_ALIAS`. The alias can be found in the command you used to create the keystore.

## Setup for iOS builds
For iOS builds, currently a macOS self-hosted runner is required. Please refer to [Adding a new runner in Bitbucket](https://support.atlassian.com/bitbucket-cloud/docs/adding-a-new-runner-in-bitbucket/) for setup instructions if you don't have one yet. The pipeline assumes the default runner tags `self.hosted` and `macos`.

## Configuration
The pipeline is defined in `bitbucket-pipelines.yml`, with separate steps for validation, build (iOS and Android), and tests.
- Flutter version: Ensure the Flutter Docker image version matches the version you want to use. By default, [cirruslabs Flutter Docker images](https://github.com/cirruslabs/docker-images-flutter/pkgs/container/flutter) are used. If you want to use a different Flutter version or image, adjust the value of the `image` key at the top of the `bitbucket-pipelines.yml` file. 
- Runners: For iOS builds, make sure you have a self-hosted macOS runner available and correctly tagged to handle the iOS build steps. If you use different tags than the default ones, you can adjust them in the `&build-ios` step.

## Troubleshooting
### Error when building Android app
```
Execution failed for task ':app:signDevelopmentReleaseBundle'.
> A failure occurred while executing com.android.build.gradle.internal.tasks.FinalizeBundleTask$BundleToolRunnable
   > java.lang.NullPointerException (no error message)
```
This error occurs when signing failed. Make sure you closely followed the steps in the [Setup Bitbucket Pipelines for Android builds](#setup-bitbucket-pipelines-for-android-builds) section. If any of the steps are not followed, the pipeline will fail with the above error.