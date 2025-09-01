import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presensa_app/src/constants/db_keys.dart';
import 'package:presensa_app/src/core/logger/logger.dart';
import 'package:presensa_app/src/core/providers/appwrite_provider.dart';
import 'package:presensa_app/src/features/auth/data/models/user.dart';
import 'package:presensa_app/src/features/auth/data/repository/auth_repository.dart';
import 'package:presensa_app/src/utils/extensions/custom_extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

class AuthService implements AuthRepository {
  final Account _account;
  final TablesDB _tablesDB;
  final Client _client;

  final String databaseId = DBKeys.appwriteDatabaseId.initial;
  final String usersTableId = DBKeys.appwriteTableUsersId.initial;

  AuthService({
    required Account account,
    required TablesDB tablesDB,
    required Client client,
  }) : _account = account,
       _tablesDB = tablesDB,
       _client = client;

  @override
  Future<User> login(String email, String password) async {
    try {
      await _account.createEmailPasswordSession(
        email: email,
        password: password,
      );

      final user = await _account.get();

      final rows = await _tablesDB.listRows(
        databaseId: databaseId,
        tableId: usersTableId,
        queries: [Query.equal("userId", user.$id)],
      );

      String? role;
      String? department;
      String? phone;

      if (rows.rows.isNotEmpty) {
        final data = rows.rows.first.data;
        role = data['role'] as String?;
        department = data['department'] as String?;
        phone = data['phone'] as String?;
      }

      final result = User(
        id: user.$id,
        email: user.email,
        name: user.name,
        role: role ?? "employee",
        department: department,
        phone: phone,
      );
      logger.i(result.toString());
      return result;
    } on AppwriteException catch (e) {
      throw e.message ?? 'Appwrite error';
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<User> register(String email, String password, String name) async {
    try {
      final newUser = await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );

      _tablesDB.createRow(
        databaseId: databaseId,
        tableId: usersTableId,
        rowId: ID.unique(),
        data: {
          "userId": newUser.$id,
          "role": "employee",
          "department": null,
          "phone": null,
        },
      );

      return User(
        id: newUser.$id,
        email: newUser.email,
        name: newUser.name,
        role: "employee",
      );
    } on AppwriteException catch (e) {
      throw e.message ?? 'Appwrite error';
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _account.deleteSession(sessionId: 'current');
    } on AppwriteException catch (e) {
      throw e.message ?? 'Appwrite error';
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      final user = await _account.get();

      final rows = await _tablesDB.listRows(
        databaseId: databaseId,
        tableId: usersTableId,
        queries: [Query.equal("userId", user.$id)],
      );

      String? role;
      String? department;
      String? phone;

      if (rows.rows.isNotEmpty) {
        final data = rows.rows.first.data;
        role = data['role'] as String?;
        department = data['department'] as String?;
        phone = data['phone'] as String?;
      }

      return User(
        id: user.$id,
        email: user.email,
        name: user.name,
        role: role ?? "employee",
        department: department,
        phone: phone,
      );
    } on AppwriteException catch (e) {
      // Jika error karena missing scopes, anggap user belum login
      if ((e.message ?? '').contains('missing scopes')) {
        return null;
      }
      throw e.message ?? 'Appwrite error';
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<bool> ping() async {
    try {
      final res = await _client.ping();
      return res.isNotBlank;
    } on AppwriteException catch (e) {
      throw e.message ?? 'Appwrite error';
    } catch (e) {
      throw e.toString();
    }
  }
}

@riverpod
AuthRepository authRepository(Ref ref) => AuthService(
  account: ref.watch(appwriteAccountProvider),
  tablesDB: ref.watch(appwriteTablesDBProvider),
  client: ref.watch(appwriteClientProvider),
);
