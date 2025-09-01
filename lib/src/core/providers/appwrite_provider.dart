import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presensa_app/src/constants/db_keys.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:appwrite/appwrite.dart';

part 'appwrite_provider.g.dart';

@riverpod
Client appwriteClient(Ref ref) {
  final endpoint = DBKeys.appwritePublicEndpoint.initial;
  final projectId = DBKeys.appwriteProjectId.initial;

  if (endpoint == null || projectId == null) {
    throw Exception('Appwrite configuration is missing.');
  }

  return Client()
      .setEndpoint(endpoint) // Your Appwrite Endpoint
      .setProject(projectId) // Your project ID
      .setSelfSigned(); // Use only on dev mode with a self-signed certificate
}

@riverpod
Account appwriteAccount(Ref ref) {
  final client = ref.watch(appwriteClientProvider);
  return Account(client);
}

/// ✅ Provider untuk TablesDB
@riverpod
TablesDB appwriteTablesDB(Ref ref) {
  final client = ref.watch(appwriteClientProvider);
  return TablesDB(client);
}
