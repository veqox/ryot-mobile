import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ryot/providers/settings_provider.dart';
import 'package:ryot/views/home_screen.dart';
import 'package:ryot/views/onboarding_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final settings = ref.watch(settingsProvider);

  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) {
          return const OnboardingScreen();
        },
      ),
    ],
    redirect: (context, state) {
      if (!(settings.value?.onboardingComplete ?? false)) {
        return '/onboarding';
      }

      return null;
    },
  );
});
