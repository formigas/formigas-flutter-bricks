<p align="center">
<img src="docs/main_logo.png" height="200" alt="Formigas" />
</p>

# formigas Flutter Core
Flutter app template inspired by [Very Good Core][very_good_core_link]

###
If you already have your Flutter project set up, check out 
[formigas Flutter Bricks][formigas_flutter_bricks_link] for templates to speed up your development.

## Contains

### Translations

The core brick contains a translations mechanism that is based on
the [flutter_localizations][flutter_localizations_link] package. The translations are stored in
the `lib/common/l10n` folder. The translations are loaded in
the `main.dart` file and are available in the whole app.

### Theme

The project template contains theme configuration files in `lib/common/` folder. They are separated
into `color_scheme.dart` and `custom_themes.dart`. You can add your colors or the whole widget
theme configuration. The theme is loaded in the `main.dart` file and is available in the whole app.

### Routing

The project template is using [go_router][go_router_link] for the routing. The routes are defined in
the `app/router` file and loaded in the `main.dart` file.

### State management

The project template is using [formigas MVC][formigas_mvc_link] for the state management. This is a
custom state management solution that is using the MVC pattern.

## Pre-requisites

- [Mason CLI][mason_cli_link]

## Usage

### Preparation

1. Initialize Mason in the directory where you want to create the new project by running the following command:

```sh
mason init
```
2. If not done yet, add the formigas_core brick to your local mason replacing `{VERSION}` with the desired version:
  
**using SSH:**
```sh
mason add formigas_core --git-url git@github.com:formigas/formigas-flutter-core.git --git-ref {VERSION}
```

The formigas_core brick should show up in the list of mason bricks:

```
$ mason list
/Users/User/foo/bar
└── formigas_core {VERSION} -> git@github.com:formigas/formigas-flutter-core.git#{commit-hash}
```

**using HTTPS:**
```sh
mason add formigas_core --git-url https://github.com/formigas/formigas-flutter-core.git --git-ref {VERSION}
```
The formigas_core brick should show up in the list of mason bricks:

```
$ mason list
/Users/User/foo/bar
└── formigas_core {VERSION} -> https://github.com/formigas/formigas-flutter-core.git#{commit-hash}
```


### Core

Create a new formigas core application using the following command:

```sh
mason make formigas_core
```

This will start a dialog that will guide you through the process of creating the Flutter project
based on the formigas Flutter Core brick.

### Features

After you have set up the core, you can add features to your app using [formigas Flutter Bricks][formigas_flutter_bricks_link]. 

# Contribution

## Create a Release
To release a new version of the formigas core brick, follow these steps:
1. Go to the repo's [Actions Tab][core_actions_link]
2. Click on the `Release` workflow
3. Click on `Run workflow`
4. Make sure the branch is set to `main`
5. Enter the version number you want to release
6. Click on `Run workflow`

## Helpful links

- [Very Good Core][very_good_core_link]
- [Brick Hub Development][brick_hub_development_link]
- [Mason][mason_link]

[very_good_core_link]: https://github.com/VeryGoodOpenSource/very_good_templates/tree/main/very_good_core

[formigas_link]: https://formigas.io

[formigas_flutter_bricks_link]: https://github.com/formigas/formigas-flutter-bricks

[formigas_mvc_link]: https://github.com/formigas/formigas-mvc

[brick_hub_development_link]: https://docs.brickhub.dev/brick-development

[mason_link]: https://github.com/felangel/mason

[mason_cli_link]: https://github.com/felangel/mason/tree/master/packages/mason_cli

[core_repo_link]: ./core/README.md
[core_actions_link]: https://github.com/formigas/formigas-flutter-core/actions

[go_router_link]: https://pub.dev/packages/go_router

[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
