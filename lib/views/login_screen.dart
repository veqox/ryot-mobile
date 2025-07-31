import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ryot/providers/auth_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 40.0),
        child: Center(child: LoginForm()),
      ),
    );
  }
}

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20.0,
        children: [
          TextFormField(
            controller: usernameController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Username',
            ),
            autofocus: true,
            validator: (value) {
              if (value?.trim().isEmpty ?? true) {
                // TODO: proper error messages
                return "Invalid username";
              }
              return null;
            },
          ),
          TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Password',
            ),
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            autofocus: true,
            validator: (value) {
              if (value?.trim().isEmpty ?? true) {
                // TODO: proper error messages
                return "Invalid password";
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () async {
              final form = _formKey.currentState;
              if (form!.validate()) {
                // TODO: login
                if (await ref
                    .read(authServiceProvider)
                    .login(
                      username: usernameController.text,
                      password: passwordController.text,
                    )) {
                  if (context.mounted) {
                    context.go('/');
                  }
                }
              }
            },
            child: const Text("Login"),
          ),
        ],
      ),
    );
  }
}
