import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ryot/providers/graphql_provider.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref);
});

class AuthService {
  final Ref ref;
  final _secureStorage = const FlutterSecureStorage();
  bool loggedIn = false;

  AuthService(this.ref);

  Future<bool> login({
    required String username,
    required String password,
  }) async {
    final client = ref.read(graphQLClientProvider);
    if (client == null) return false;

    const mutation = r'''
    mutation Login($username: String!, $password: String!)   {
      loginUser(
        input: {
          password: { username: $username, password: $password }
        }
      ) {
        ... on ApiKeyResponse {
          apiKey
        }
        ... on StringIdObject {
          id
        }
        ... on LoginError {
          error
        }
      }
    }
    ''';

    final result = await client.mutate(
      MutationOptions(
        document: gql(mutation),
        variables: {'username': username, 'password': password},
      ),
    );

    if (result.hasException) {
      return false;
    }

    final token = result.data?['loginUser']?['apiKey'];
    if (token == null) {
      return false;
    }

    await _saveToken(token);
    ref.read(graphQLClientProvider.notifier).setToken(token);
    loggedIn = true;

    return true;
  }

  Future<void> logout() async {
    await _removeToken();
    ref.read(graphQLClientProvider.notifier).setToken(null);
    loggedIn = false;
  }

  Future<void> tryAutoLogin() async {
    final token = await _readToken();

    if (token != null && token.isNotEmpty) {
      ref.read(graphQLClientProvider.notifier).setToken(token);
      loggedIn = true;
    }
  }

  static const String _tokenKey = 'auth_token';

  Future<String?> _readToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  Future<void> _saveToken(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
  }

  Future<void> _removeToken() async {
    await _secureStorage.delete(key: _tokenKey);
  }
}
