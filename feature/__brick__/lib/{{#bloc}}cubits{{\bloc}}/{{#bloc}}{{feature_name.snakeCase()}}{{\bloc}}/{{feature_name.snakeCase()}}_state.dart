{{#use_freezed}}import 'package:freezed_annotation/freezed_annotation.dart';

part '{{feature_name.snakeCase()}}_state.freezed.dart';

@freezed
class {{feature_name.pascalCase()}}State with _${{feature_name.pascalCase()}}State {
  factory {{feature_name.pascalCase()}}State.initial() => const {{feature_name.pascalCase()}}State(count: 0);

  const factory {{feature_name.pascalCase()}}State({required final int count}) = _{{feature_name.pascalCase()}}State;
}{{/use_freezed}}{{^use_freezed}}class {{feature_name.pascalCase()}}State {
  final int _count;
  int get count => _count;

  const {{feature_name.pascalCase()}}State({required final int count}): _count = count;

  factory {{feature_name.pascalCase()}}State.initial() => const {{feature_name.pascalCase()}}State(count: 0);

  {{feature_name.pascalCase()}}State copyWith({required final int count}) => {{feature_name.pascalCase()}}State(count: count);
}{{/use_freezed}}