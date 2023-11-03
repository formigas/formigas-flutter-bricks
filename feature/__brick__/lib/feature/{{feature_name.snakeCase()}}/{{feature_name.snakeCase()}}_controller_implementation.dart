import 'package:{{project_name.snakeCase()}}/feature/{{feature_name.snakeCase()}}/{{feature_name.snakeCase()}}_controller.dart';
import 'package:{{project_name.snakeCase()}}/feature/{{feature_name.snakeCase()}}/{{feature_name.snakeCase()}}_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '{{feature_name.snakeCase()}}_controller_implementation.g.dart';

@riverpod
class {{feature_name.pascalCase()}}ControllerImplementation extends _${{feature_name.pascalCase()}}ControllerImplementation
    implements {{feature_name.pascalCase()}}Controller {
  @override
  {{feature_name.pascalCase()}}Model build() => const {{feature_name.pascalCase()}}Model(count: 0);

  @override
  void increment() => state = state.copyWith(count: state.count + 1);

  @override
  void decrement() => state = state.copyWith(count: state.count - 1);
}
