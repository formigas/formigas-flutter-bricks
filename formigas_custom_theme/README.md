# formigas Custom Theme Brick

A brick that provides the files and structure for a custom theme how we implement it at [formigas][formigas_link] in our [Flutter][flutter_link] projects.

[![License: MIT][license_badge]][license_link]
[![Powered by Mason][mason_badge]][mason_link]

## Pre-requisites 🛠️

- [Mason CLI][mason_cli_link]

## Usage 🏗️

1. Navigate to the project you want to add the custom theme to. Then run:
```sh
mason init
```
2. Add the `formigas_custom_theme` brick to mason by running:
```sh
mason add formigas_custom_theme
```
The formigas_custom_theme brick should show up in the list of mason bricks:
```
$ mason list
/Users/User/foo/bar
└── formigas_custom_theme {VERSION} -> registry.brickhub.dev
```
3. To add the custom Theme to your app run the following command:
```sh
mason make formigas_custom_theme
```
## Output 📦
The Brick adds the common folder with the theme files
```sh
├── common
│   ├── color_scheme.dart
│   ├── custom_themes.dart
│   └── text_style.dart
```
And modifies the `app.dart` file by replacing the current Theme with the generated CustomTheme.

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[formigas_link]: https://formigas.io
[mason_link]: https://github.com/felangel/mason
[mason_cli_link]: https://github.com/felangel/mason/tree/master/packages/mason_cli
[mason_badge]: https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge
[flutter_link]:https://flutter.dev/
