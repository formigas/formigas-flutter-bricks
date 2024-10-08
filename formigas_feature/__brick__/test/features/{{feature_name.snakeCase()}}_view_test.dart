import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/cubit/{{feature_name.snakeCase()}}_cubit.dart';
import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/{{feature_name.snakeCase()}}_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders {{feature_name.pascalCase()}}', (tester) async {
      await tester.pumpWidget(
        BlocProvider(
          create: (_) => {{feature_name.pascalCase()}}Cubit(),
          child: const MaterialApp(
            home: {{feature_name.pascalCase()}}View(),
          ),
        ),
      );
      expect(
        find.byType({{feature_name.pascalCase()}}View),
        findsOneWidget,
      );
    });
  });
}
