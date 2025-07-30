import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ryot/router.dart';

void main() {
  runApp(const ProviderScope(child: RyotApp()));
}

class RyotApp extends ConsumerWidget {
  const RyotApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Ryot',
      theme: ThemeData.dark(),
      routerConfig: ref.watch(routerProvider),
    );
  }
}
