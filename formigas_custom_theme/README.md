# formigas Custom Theme Brick

A brick that provides the files and structure for a custom theme how we implement it at [formigas][formigas_link] in our Flutter projects.

[![License: MIT][license_badge]][license_link]
[![Powered by Mason][mason_badge]][mason_link]

## Pre-requisites 🛠️

- [Mason CLI][mason_cli_link]

## Usage 🏗️

To add the formigas_custom_theme brick to your local mason run:
```sh
$ mason init
```

### using ssh
```sh
$ mason add formigas_custom_theme --git-url git@github.com:formigas/formigas-flutter-bricks.git --git-path formigas_custom_theme --git-ref {VERSION}
```
The formigas_custom_theme brick should show up in the list of mason bricks:

```
$ mason list
/Users/User/foo/bar
└── formigas_custom_theme {VERSION} -> git@github.com:formigas/formigas-flutter-bricks.git#{commit-hash}
```

### using https
```sh
mason add formigas_custom_theme --git-url https://github.com/formigas/formigas-flutter-bricks.git --git-path formigas_custom_theme --git-ref {VERSION}
```
The formigas_custom_theme brick should show up in the list of mason bricks:

```
$ mason list
/Users/User/foo/bar
└── formigas_custom_theme {VERSION} -> https://github.com/formigas/formigas-flutter-bricks.git#{commit-hash}
```
<br />
<br />

To add the custom Theme to your app run the following command in the root of your project:

```sh
mason make formigas_custom_theme
```
## Output 📦
The Brick adds the common folder

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