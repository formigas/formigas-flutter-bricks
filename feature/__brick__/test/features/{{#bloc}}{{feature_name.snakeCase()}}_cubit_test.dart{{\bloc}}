import 'package:bloc_test/bloc_test.dart';
import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/cubit/{{feature_name.snakeCase()}}_cubit.dart';
import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/cubit/{{feature_name.snakeCase()}}_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('The {{feature_name.pascalCase()}} cubit', () {
    blocTest<{{feature_name.pascalCase()}}Cubit, {{feature_name.pascalCase()}}State>(
      'emits [MyState] when increment is called',
      build: {{feature_name.pascalCase()}}Cubit.new,
      act: (cubit) => cubit.increment(),
      expect: () => const <{{feature_name.pascalCase()}}State>[{{feature_name.pascalCase()}}State(count: 1)],
    );

    blocTest<{{feature_name.pascalCase()}}Cubit, {{feature_name.pascalCase()}}State>(
      'emits [MyState] when decrement is called',
      build: {{feature_name.pascalCase()}}Cubit.new,
      act: (cubit) => cubit.decrement(),
      expect: () => const <{{feature_name.pascalCase()}}State>[{{feature_name.pascalCase()}}State(count: -1)],
    );
  });
}
