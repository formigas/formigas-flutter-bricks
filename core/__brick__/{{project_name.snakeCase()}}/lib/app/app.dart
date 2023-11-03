import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{project_name.snakeCase()}}/ui/counter/counter_controller_implementation.dart';
import 'package:{{project_name.snakeCase()}}/ui/counter/counter_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Consumer(
          builder: (_, ref, ___) => CounterView(
            controller:
                ref.read(counterControllerImplementationProvider.notifier),
            model: ref.watch(counterControllerImplementationProvider),
          ),
        ),
      ),
    );
  }
}
