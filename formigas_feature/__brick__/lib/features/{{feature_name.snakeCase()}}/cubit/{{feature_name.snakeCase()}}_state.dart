{{#use_freezed}}import 'package:freezed_annotation/freezed_annotation.dart';

part '{{feature_name.snakeCase()}}_state.freezed.dart';

@freezed
class {{feature_name.pascalCase()}}State with _${{feature_name.pascalCase()}}State {
  const factory {{feature_name.pascalCase()}}State({required int count}) = _{{feature_name.pascalCase()}}State;

  factory {{feature_name.pascalCase()}}State.initial() => const {{feature_name.pascalCase()}}State(count: 0);
}{{/use_freezed}}{{^use_freezed}} import 'package:equatable/equatable.dart';
class {{feature_name.pascalCase()}}State extends Equatable {
  const {{feature_name.pascalCase()}}State({required this.count});

  factory {{feature_name.pascalCase()}}State.initial() => const {{feature_name.pascalCase()}}State(count: 0);
  final int count;


  {{feature_name.pascalCase()}}State copyWith({int? count}) => {{feature_name.pascalCase()}}State(count: count ?? this.count);

  @override
  List<Object?> get props => [count];
}{{/use_freezed}}
