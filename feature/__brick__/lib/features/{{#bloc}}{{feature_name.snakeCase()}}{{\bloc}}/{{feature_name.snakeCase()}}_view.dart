import 'package:{{project_name.snakeCase()}}/cubits/{{feature_name.snakeCase()}}/{{feature_name.snakeCase()}}_cubit.dart';
import 'package:{{project_name.snakeCase()}}/cubits/{{feature_name.snakeCase()}}/{{feature_name.snakeCase()}}_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class {{feature_name.pascalCase()}}View extends StatelessWidget {
  const {{feature_name.pascalCase()}}View({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Flutter Demo Home Page'),
        ),
        body: BlocBuilder<{{feature_name.pascalCase()}}Cubit, {{feature_name.pascalCase()}}State>(
          builder: (context, state) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '${state.count}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: context.read<{{feature_name.pascalCase()}}Cubit>().increment,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
}
