# formigas fastlane CD

A brick that provides a set of actions to help you with Continuous Deployment in your [Flutter][flutter_link] project.

[![License: MIT][license_badge]][license_link]
[![Powered by Mason][mason_badge]][mason_link]

## Usage 🛠️

See [BrickHub][brick_hub_usage_link] for usage instructions.

## Requirements 📝

### Secrets 🔑

To avoid storing sensitive information as `android_keystore` and `ios_certificate` in a separate repository or locally, you can encrypt the secrets and store them in the repository. To do this, you need to put your secrets in `build_secrets` directory for each platform and run the following
command:

```bash
  fastlane encrypt
```

Then provide your secret key for encryption. This password should be stored securely and not be shared. When working in a CI/CD environment add the password as an environment variable with name `KEYS_ENCRYPTION_PASSWORD`. This variable will be used to decrypt secrets during the build process.

### Android

For Android deployment, you need to update files in `android/build_secrets` directory:

* `keystore.jks`    => keystore file for signing the APK file
* `keys.properties` => properties file for signing the APK file with `keystore.jks`
* `play-dev-store-service-account.json` => service account file for uploading APK to Google Play Store

### iOS

For iOS deployment you need to update files in `ios/build_secrets` directory:

* `keys.p12` => contains the private key for the certificate
* `*.mobileprovisioning` => provisioning profile for the app

## Using the brick 🚀

After you have updated the secrets, you can use the actions to deploy your app. You should use them separately for each platform.

### Android 📦

```bash
  fastlane deploy_internal
```

This action will build and deploy the android appBundle to the internal track on Google Play.

### iOS 📦

```bash
  fastlane build_testflight
```

This action will build and deploy the ios ipa for TestFlight on AppStore.


[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[mason_cli_link]: https://github.com/felangel/mason/tree/master/packages/mason_cli
[mason_link]: https://github.com/felangel/mason
[mason_badge]: https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge
[flutter_link]:https://flutter.dev/
[brick_hub_usage_link]:https://brickhub.dev/bricks/formigas_fastlane_cd#usage
