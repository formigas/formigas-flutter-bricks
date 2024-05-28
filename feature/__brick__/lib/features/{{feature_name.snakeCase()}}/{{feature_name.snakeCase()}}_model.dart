{{#use_freezed}}import 'package:freezed_annotation/freezed_annotation.dart';

part '{{feature_name.snakeCase()}}_model.freezed.dart';

@freezed
class {{feature_name.pascalCase()}}Model with _${{feature_name.pascalCase()}}Model {
  const factory {{feature_name.pascalCase()}}Model({
    required int count,
  }) = _{{feature_name.pascalCase()}}Model;
}{{/use_freezed}}{{^use_freezed}}
class {{feature_name.pascalCase()}}Model {
  int count;
  {{feature_name.pascalCase()}}Model({required this.count});

  {{feature_name.pascalCase()}}Model copyWith({required int count}) => {{feature_name.pascalCase()}}Model(count: count);
}{{/use_freezed}}
