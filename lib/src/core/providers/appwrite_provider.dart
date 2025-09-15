import 'package:appwrite/appwrite.dart';
import 'package:presensa_app/src/constants/db_keys.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appwrite_provider.g.dart';

@riverpod
Client appwriteClient(Ref ref) {
  final endpoint = DBKeys.appwritePublicEndpoint.initial;
  final projectId = DBKeys.appwriteProjectId.initial;

  if (endpoint == null || projectId == null) {
    throw Exception('Appwrite configuration is missing.');
  }

  return Client().setEndpoint(endpoint).setProject(projectId).setSelfSigned();
}

@riverpod
Account appwriteAccount(Ref ref) {
  final client = ref.watch(appwriteClientProvider);
  return Account(client);
}

@riverpod
TablesDB appwriteTablesDB(Ref ref) {
  final client = ref.watch(appwriteClientProvider);
  return TablesDB(client);
}

@riverpod
Functions appwriteFunctions(Ref ref) {
  final client = ref.watch(appwriteClientProvider);
  return Functions(client);
}
