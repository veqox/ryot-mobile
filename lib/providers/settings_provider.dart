import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ryot/models/settings.dart';
import 'package:ryot/repositories/settings_repository.dart';

class SettingsNotifier extends AsyncNotifier<Settings> {
  late final SettingsRepository _repository;

  @override
  Future<Settings> build() async {
    _repository = ref.read(settingsRepositoryProvider);
    return await _repository.load();
  }

  void setServerUrl(String? serverUrl) async {
    if (state.value == null) return;

    if (serverUrl?.isEmpty ?? true) {
      serverUrl = null;
    }

    final updated = state.value!.copyWith(serverUrl: serverUrl);
    state = AsyncValue.data(updated);
    await _repository.save(updated);
  }

  void setOnboardingComplete(bool onboardingComplete) async {
    if (state.value == null) return;

    final updated = state.value!.copyWith(
      onboardingComplete: onboardingComplete,
    );
    state = AsyncValue.data(updated);
    await _repository.save(updated);
  }
}

final settingsProvider = AsyncNotifierProvider<SettingsNotifier, Settings>(() {
  return SettingsNotifier();
});
