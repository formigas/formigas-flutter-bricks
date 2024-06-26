{{#use_freezed}}import 'package:freezed_annotation/freezed_annotation.dart';

part '{{feature_name.snakeCase()}}_model.freezed.dart';

@freezed
class {{feature_name.pascalCase()}}Model with _${{feature_name.pascalCase()}}Model {
  const factory {{feature_name.pascalCase()}}Model({
    required int count,
  }) = _{{feature_name.pascalCase()}}Model;
}{{/use_freezed}}{{^use_freezed}} import 'package:equatable/equatable.dart';
class {{feature_name.pascalCase()}}Model extends Equatable {
  const {{feature_name.pascalCase()}}Model({required this.count});

  factory {{feature_name.pascalCase()}}Model.initial() => const {{feature_name.pascalCase()}}Model(count: 0);
  final int count;


  {{feature_name.pascalCase()}}Model copyWith({int? count}) => {{feature_name.pascalCase()}}Model(count: count ?? this.count);

  @override
  List<Object?> get props => [count];
}{{/use_freezed}}
