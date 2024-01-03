import 'package:flutter/material.dart';
import 'package:{{project_name.snakeCase()}}/common/color_scheme.dart';
import 'package:{{project_name.snakeCase()}}/common/text_style.dart';

class CustomTheme {
  ThemeData get dark => ThemeData(
        {{#use_material_3}}useMaterial3: true,{{/use_material_3}}
        brightness: Brightness.dark,
        colorScheme: darkColorScheme,
        textTheme: textTheme,
      );

  ThemeData get light => ThemeData(
        {{#use_material_3}}useMaterial3: true,{{/use_material_3}}
        brightness: Brightness.light,
        colorScheme: lightColorScheme,
        textTheme: textTheme,
      );
}
