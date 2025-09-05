import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart' as models
    show DocumentList, UserList;

Future<dynamic> main(final context) async {
  final payload =
      jsonDecode(context.req.bodyRaw.isEmpty ? '{}' : context.req.bodyRaw)
          as Map<String, dynamic>;
  final action = payload['action'] as String?;

  if (action == null) {
    return context.res.json({'success': false, 'error': 'Action is required.'},
        statusCode: 400);
  }

  try {
    // Inisialisasi Client dengan aman menggunakan Environment Variables
    final client = Client()
        // BENAR: Menggunakan variabel bawaan Appwrite
        .setEndpoint(Platform.environment['APPWRITE_FUNCTION_API_ENDPOINT']!)
        // BENAR: Menggunakan variabel bawaan Appwrite
        .setProject(Platform.environment['APPWRITE_FUNCTION_PROJECT_ID']!)
        // BENAR: Menggunakan variabel yang ANDA tambahkan secara manual
        .setKey(Platform.environment['APPWRITE_API_KEY']!);

    final users = Users(client);
    final databases = Databases(client);

    // Ganti dengan ID Anda sendiri
    final databaseId = '68b2d0250003a89951f0'; // Contoh
    final usersCollectionId = 'users';
    final companiesCollectionId = 'companies';

    switch (action) {
      case 'list':
        context.log('Action: List Employees with Company Data');

        final results = await Future.wait([
          databases.listDocuments(
              databaseId: databaseId, collectionId: usersCollectionId),
          databases.listDocuments(
              databaseId: databaseId, collectionId: companiesCollectionId),
          users.list(),
        ]);

        final userDocuments = results[0] as models.DocumentList;
        final companyDocuments = results[1] as models.DocumentList;
        final authUsers = results[2] as models.UserList;

        // 2. Buat "peta" untuk pencarian cepat
        final authUsersMap = {for (var u in authUsers.users) u.$id: u};
        final companyMap = {
          for (var doc in companyDocuments.documents) doc.$id: doc.data
        };

        // 3. Gabungkan semua data
        final List<Map<String, dynamic>> combinedList = [];
        for (var doc in userDocuments.documents) {
          final docData = doc.data;
          final authUser = authUsersMap[docData['userId']];

          final String? companyId = docData['companyId'];
          final companyData = companyId != null ? companyMap[companyId] : null;

          if (authUser != null) {
            combinedList.add({
              'userId': docData['userId'],
              'documentId': doc.$id,
              'name': authUser.name,
              'email': authUser.email,
              'role': docData['role'],
              'department': docData['department'],
              'phone': docData['phone'],
              'company': companyData,
            });
          }
        }

        context.log('Successfully listed ${combinedList.length} employees.');
        return context.res.json({'success': true, 'data': combinedList});

      case 'getById':
        context.log('Action: Get Employee By ID');
        final String documentId = payload['documentId'];

        final doc = await databases.getDocument(
          databaseId: databaseId,
          collectionId: usersCollectionId,
          documentId: documentId,
        );
        final docData = doc.data;

        final authUser = await users.get(userId: docData['userId']);
        final String? companyId = docData['companyId'];

        Map<String, dynamic>? companyData;
        if (companyId != null) {
          final companyDoc = await databases.getDocument(
              databaseId: databaseId,
              collectionId: companiesCollectionId,
              documentId: companyId);
          companyData = companyDoc.data;
        }

        final Map<String, dynamic> combinedData = {
          'userId': docData['userId'],
          'documentId': doc.$id,
          'name': authUser.name,
          'email': authUser.email,
          'role': docData['role'],
          'department': docData['department'],
          'phone': docData['phone'],
          'company': companyData,
        };

        return context.res.json({'success': true, 'data': combinedData});

      case 'update':
        context.log('Action: Update Employee');
        final Map<String, dynamic> employeeData = payload['employeeData'];
        final String userId = employeeData['userId'];

        final currentUser = await users.get(userId: userId);

        if (currentUser.name != employeeData['name']) {
          context.log(
              'Updating name for user: $userId from "${currentUser.name}" to "${employeeData['name']}"');
          await users.updateName(userId: userId, name: employeeData['name']);
        } else {
          context.log('Name for user $userId is unchanged. Skipping update.');
        }

        if (currentUser.email != employeeData['email']) {
          context.log(
              'Updating email for user: $userId from "${currentUser.email}" to "${employeeData['email']}"');
          await users.updateEmail(userId: userId, email: employeeData['email']);
        } else {
          context.log('Email for user $userId is unchanged. Skipping update.');
        }

        await databases.updateDocument(
            databaseId: databaseId,
            collectionId: usersCollectionId,
            documentId: employeeData['documentId'],
            data: {
              'role': employeeData['role'],
              'department': employeeData['department'],
              'phone': employeeData['phone'],
            });

        return context.res.json(
            {'success': true, 'message': 'Employee updated successfully'});

      case 'create':
        context.log('Action: Create Employee');
        final newUser = await users.create(
          userId: ID.unique(),
          email: payload['email'],
          password: payload['password'],
          name: payload['name'],
        );

        await users.updateEmailVerification(
          userId: newUser.$id,
          emailVerification: true,
        );

        await databases.createDocument(
            databaseId: databaseId,
            collectionId: usersCollectionId,
            documentId: ID.unique(),
            data: {
              'userId': newUser.$id,
              'role': payload['role'],
              'department': payload['department'],
              'phone': payload['phone'],
              'companyId': payload['companyId'],
            });

        context.log('Successfully created user: ${newUser.$id}');

        return context.res.json({
          'success': true,
          'message': 'Employee created successfully.',
          'userId': newUser.$id
        });

      case 'delete':
        context.log('Action: Delete Employee');
        final String userId = payload['userId'];
        final String documentId = payload['documentId'];

        await Future.wait([
          users.delete(userId: userId),
          databases.deleteDocument(
            databaseId: databaseId,
            collectionId: usersCollectionId,
            documentId: documentId,
          ),
        ]);

        context.log('Successfully deleted user: $userId');

        return context.res.json(
            {'success': true, 'message': 'Employee deleted successfully.'});

      default:
        context.error('Invalid action provided: $action');
        return context.res.json({
          'success': false,
          'error': 'Invalid action: $action',
        });
    }
  } catch (e) {
    context.error('An error occurred: ${e.toString()}');

    return context.res.json({'success': false, 'error': e.toString()});
  }
}
