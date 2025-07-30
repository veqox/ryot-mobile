import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ryot/providers/settings_provider.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 40.0),
        child: Center(
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter Server Url',
            ),
            autofocus: true,
            initialValue: settings.value?.serverUrl,
            onFieldSubmitted: ((text) {
              // TODO: check if the url provided is a valid url
              // TODO: check if the url provided is a ryot server instance

              ref.read(settingsProvider.notifier).setServerUrl(text);
              ref.read(settingsProvider.notifier).setOnboardingComplete(true);

              context.go('/');
            }),
          ),
        ),
      ),
    );
  }
}
