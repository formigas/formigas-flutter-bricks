import 'package:mason/mason.dart';

enum Platform {
  android,
  ios,
}

void run(HookContext context) {
  _selectAppId(context);
  _selectCI(context);
}

void _selectAppId(HookContext context) {
  context.vars['application_id_android'] =
      _createAppId(context, platform: Platform.android);
  context.vars['application_id'] = _createAppId(context);
}

void _selectCI(HookContext context) {
  final useCI = context.vars['use_ci'] as String?;
  switch (useCI) {
    case 'Github Actions':
      context.vars = {...context.vars, 'use_github_ci': true};
    case 'Gitlab CI':
      {
        context.vars = {...context.vars, 'use_gitlab_ci': true};
        final runnerTag = context.logger.prompt(
          'Enter the runner tag for the runner to be used for iOS builds:',
        );
        context.vars = {...context.vars, 'gitlab_ios_runner_tag': runnerTag};
      }
    case 'Bitbucket Pipelines':
      context.vars = {...context.vars, 'use_bitbucket_ci': true};
    default:
  }
}

String _createAppId(HookContext context, {Platform? platform}) {
  final orgName = context.vars['org_name'] as String;
  final projectName = context.vars['project_name'] as String;

  var applicationId = context.vars['application_id'] as String?;
  applicationId = (applicationId?.isNotEmpty ?? false)
      ? applicationId
      : '''$orgName.${platform == Platform.android ? projectName.snakeCase : projectName.paramCase}''';

  return applicationId!;
}
