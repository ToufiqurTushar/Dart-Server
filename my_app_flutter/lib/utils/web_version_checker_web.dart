// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;
import 'dart:convert';

Future<void> checkAppVersionAndReloadIfNeeded() async {
  try {
    final responseText = await html.HttpRequest.getString(
      '/version.json?t=${DateTime.now().millisecondsSinceEpoch}',
    );
    final data = jsonDecode(responseText);
    final serverVersion = data['version']?.toString();
    if (serverVersion != null && serverVersion.isNotEmpty) {
      final storedVersion = html.window.localStorage['app_deploy_version'];
      if (storedVersion != null && storedVersion != serverVersion) {
        html.window.localStorage['app_deploy_version'] = serverVersion;
        html.window.location.reload();
      } else if (storedVersion == null) {
        html.window.localStorage['app_deploy_version'] = serverVersion;
      }
    }
  } catch (_) {}
}
