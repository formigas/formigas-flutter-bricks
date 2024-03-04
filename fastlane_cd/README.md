# fastlane_cd

fastlane_cd is a mason template that provides a set of actions to help you with Continuous
Deployment.

## Requirements

### Secrets

To avoid storing sensitive information as `android_keystore` and `ios_certificate` in the separate
repository or locally, you can use encrypt secrets and store them in the repository. To do this, you
need to put your secrets in `build_secrets` directory for each platform and run the following
command:

```bash
  fastlane encrypt
```

then provide you secret key for encryption. This password should be stored securely and not shared.
Working with CI/CD add this password as an environment variable with
name `KEYS_ENCRYPTION_PASSWORD`.
This variable will be used to decrypt secrets during every build process.

### Android

For Android deployment, you need to update files in `android/build_secrets` directory:

* `keys.properties` => properties file for signing the APK file with `keystore.jks`
* `keystore.jks`    => keystore file for signing the APK file
* `play-dev-store-service-account.json` => service account file for uploading APK to Google Play Store

### iOS

For iOS deployment you need to update files in `ios/build_secrets` directory:

* `keys.p12` => contains the private key for the certificate
* `*.mobileprovisioning` => provisioning profile for the app

## Usage

After you have updated the secrets, you can use the actions to deploy your app. You should use them separately for each platform.

### Android build

```bash
  fastlane deploy_internal
```

This action will build and deploy the android appBundle to the internal track on Google Play.

### iOS build

```bash
  fastlane build_testflight
```

This action will build and deploy the ios ipa for TestFlight on AppStore.
