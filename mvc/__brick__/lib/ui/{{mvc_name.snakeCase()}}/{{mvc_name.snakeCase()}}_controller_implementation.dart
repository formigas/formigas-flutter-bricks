import 'package:{{project_name.snakeCase()}}/ui/{{mvc_name.snakeCase()}}/{{mvc_name.snakeCase()}}_controller.dart';
import 'package:{{project_name.snakeCase()}}/ui/{{mvc_name.snakeCase()}}/{{mvc_name.snakeCase()}}_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '{{mvc_name.snakeCase()}}_controller_implementation.g.dart';

@riverpod
class {{mvc_name.pascalCase()}}ControllerImplementation extends _${{mvc_name.pascalCase()}}ControllerImplementation
    implements {{mvc_name.pascalCase()}}Controller {
  @override
  {{mvc_name.pascalCase()}}Model build() => const {{mvc_name.pascalCase()}}Model(count: 0);

  @override
  void increment() => state = state.copyWith(count: state.count + 1);

  @override
  void decrement() => state = state.copyWith(count: state.count - 1);
}
