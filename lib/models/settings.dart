import 'package:meta/meta.dart';

@immutable
class Settings {
  final String? serverUrl;
  final bool onboardingComplete;

  const Settings({this.serverUrl, this.onboardingComplete = false});

  Settings copyWith({String? serverUrl, bool? onboardingComplete}) {
    return Settings(
      serverUrl: serverUrl ?? this.serverUrl,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
    );
  }
}
