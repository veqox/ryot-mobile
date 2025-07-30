import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ryot/models/settings.dart';

class SettingsKeys {
  static const String serverUrl = 'serverUrl';
  static const String onboardingComplete = 'onboardingComplete';
}

class SettingsRepository {
  final SharedPreferencesAsync prefs;

  SettingsRepository(this.prefs);

  Future<Settings> load() async {
    return Settings(
      serverUrl: await prefs.getString(SettingsKeys.serverUrl),
      onboardingComplete:
          await prefs.getBool(SettingsKeys.onboardingComplete) ?? false,
    );
  }

  Future<void> save(Settings settings) async {
    if (settings.serverUrl != null) {
      await prefs.setString(SettingsKeys.serverUrl, settings.serverUrl!);
    } else {
      await prefs.remove(SettingsKeys.serverUrl);
    }

    await prefs.setBool(
      SettingsKeys.onboardingComplete,
      settings.onboardingComplete,
    );
  }
}

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepository(SharedPreferencesAsync());
});
