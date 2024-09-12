# formigas GoRouter Brick

A brick that provides the structure how we implement [`go_router`][go_router_link] at [formigas][formigas_link] in our [Flutter][flutter_link] projects.

[![License: MIT][license_badge]][license_link]
[![Powered by Mason][mason_badge]][mason_link]

## Usage 🛠️

See [BrickHub][brick_hub_usage_link] for usage instructions.

## Requirements

For the brick to work, the Widget used as home route needs to be in a file named the same as the Widget but in snake_case.

The `app.dart` file must use the `MaterialApp` widget and the homeRoute must either be initialized directly in the constructor or as a variable inside this file.

If there is another widget than the `MaterialApp` the goRouter file is still created, but the `app.dart` file is not modified accordingly.

A valid `app.dart` file can look like this:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:counter_app/common/theme/custom_themes.dart';
import 'package:counter_app/features/counter/counter_controller_implementation.dart';
import 'package:counter_app/features/counter/counter_view.dart';

class App extends StatelessWidget {
    const App({super.key});

    @override
    build(context) => MaterialApp(
        title: 'Counter App',
        home: home,
        theme: CustomTheme().light,
        darkTheme: CustomTheme().dark,
        themeMode: ThemeMode.light,
        supportedLocales: L10n.delegate.supportedLocales,
    );
}

Widget home = const CounterView(
            controller: CounterControllerImplementation(),
        );
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
Following dependencies will be installed for this brick if not already present:

* [go_router][go_router_link]

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[formigas_link]: https://formigas.io
[mason_link]: https://github.com/felangel/mason
[mason_cli_link]: https://github.com/felangel/mason/tree/master/packages/mason_cli
[mason_badge]: https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge
[flutter_link]:https://flutter.dev/
[go_router_link]:https://pub.dev/packages/go_router
[brick_hub_usage_link]:https://brickhub.dev/bricks/formigas_go_router#usage
