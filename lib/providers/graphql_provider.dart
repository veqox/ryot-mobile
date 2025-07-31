import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ryot/providers/settings_provider.dart';

class GraphQLClientManager extends Notifier<GraphQLClient?> {
  String? _token;

  @override
  GraphQLClient? build() {
    final settings = ref.watch(settingsProvider);

    if (settings.value == null) {
      return null;
    }

    final url = settings.value?.serverUrl;

    if (url == null) {
      return null;
    }

    return _createClient(url, _token);
  }

  void setToken(String? token) {
    _token = token;

    final settings = ref.read(settingsProvider).value;
    final url = settings?.serverUrl;

    if (url == null) return;

    state = _createClient(url, _token);
  }

  GraphQLClient? _createClient(String url, String? token) {
    final httpLink = HttpLink(url);
    Link link = httpLink;

    if (token != null) {
      link = AuthLink(getToken: () async => 'Bearer $token').concat(httpLink);
    }

    return GraphQLClient(link: link, cache: GraphQLCache());
  }
}

final graphQLClientProvider =
    NotifierProvider<GraphQLClientManager, GraphQLClient?>(() {
      return GraphQLClientManager();
    });
