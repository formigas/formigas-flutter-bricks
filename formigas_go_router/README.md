# formigas GoRouter Brick

A brick that provides the structure how we implement the GoRouter at [formigas][formigas_link] in our Flutter projects.

[![License: MIT][license_badge]][license_link]
[![Powered by Mason][mason_badge]][mason_link]

## Pre-requisites 🛠️

- [Mason CLI][mason_cli_link]

## Usage 🏗️

```sh
$ mason init
```
Add the brick to your mason:
### using ssh
```sh
$ mason add formigas_go_router --git-url git@github.com:formigas/formigas-flutter-bricks.git --git-path formigas_go_router --git-ref {VERSION}
```
The formigas_go_router brick should show up in the list of mason bricks:

```
$ mason list
/Users/User/foo/bar
└── formigas_go_router {VERSION} -> git@github.com:formigas/formigas-flutter-bricks.git#{commit-hash}
```

### using https
```sh
mason add formigas_go_router --git-url https://github.com/formigas/formigas-flutter-bricks.git --git-path formigas_go_router --git-ref {VERSION}
```
The formigas_go_router brick should show up in the list of mason bricks:

```
$ mason list
/Users/User/foo/bar
└── formigas_go_router {VERSION} -> https://github.com/formigas/formigas-flutter-bricks.git#{commit-hash}
```
<br />
<br />

## Requirements

For the brick to work, the Widget used as home route needs lo be in a file named the same as the Widget but in snake_case and the app.dart file has to be located at <b>lib/app/view/app.dart</b>. The app.dart file must use the MaterialApp widget and the homeRoute must either be initialized directly in the constructor or as a variable inside this file.
If there is another widget than the MaterialApp the goRouter file is still created, but the app.dart file is not modified accordingly.
<br />
<br />
To add the GoRouter to your app run the following command in the root of your project:

```sh
mason make formigas_go_router
```
## Output 📦

```sh
├── app 
│   ├── view
│   │   └── app.dart(modified)
├── services
│   ├── navigation_service
│   │   └── go_router.dart
```
## Dependencies
Following dependencies will be installed for this brick:

* [go_router][go_router_link]

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[formigas_link]: https://formigas.io
[mason_link]: https://github.com/felangel/mason
[mason_cli_link]: https://github.com/felangel/mason/tree/master/packages/mason_cli
[mason_badge]: https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge
[flutter_link]:https://flutter.dev/
[go_router_link]:https://pub.dev/packages/go_router