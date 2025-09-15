import 'package:appwrite/appwrite.dart';
import 'package:presensa_app/src/constants/db_keys.dart';
import 'package:presensa_app/src/core/providers/appwrite_provider.dart';
import 'package:presensa_app/src/features/employees/data/models/shift.dart';
import 'package:presensa_app/src/features/employees/data/repository/shift_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shift_service.g.dart';

class ShiftService implements ShiftRepository {
  final TablesDB _tablesDB;

  ShiftService({required TablesDB tablesDB}) : _tablesDB = tablesDB;

  final String databaseId = DBKeys.appwriteDatabaseId.initial;
  final String shiftsTableId = DBKeys.appwriteTableShiftsId.initial;

  @override
  Future<List<Shift>> getShiftsByCompany(String companyId) async {
    try {
      final result = await _tablesDB.listRows(
        databaseId: databaseId,
        tableId: shiftsTableId,
        queries: [Query.equal('companyId', companyId)],
      );
      return result.rows.map((row) => Shift.fromJson(row.data)).toList();
    } on AppwriteException catch (e) {
      throw e.message ?? 'Gagal mengambil data shift';
    }
  }

  @override
  Future<void> addShift(Shift shift, String companyId) async {
    try {
      final data = shift.toJson()..addAll({'companyId': companyId});

      await _tablesDB.createRow(
        databaseId: databaseId,
        tableId: shiftsTableId,
        rowId: ID.unique(),
        data: data,
      );
    } on AppwriteException catch (e) {
      throw e.message ?? 'Gagal menambah shift';
    }
  }

  @override
  Future<void> updateShift(Shift shift) async {
    try {
      await _tablesDB.updateRow(
        databaseId: databaseId,
        tableId: shiftsTableId,
        rowId: shift.id,
        data: shift.toJson(),
      );
    } on AppwriteException catch (e) {
      throw e.message ?? 'Gagal memperbarui shift';
    } catch (e) {
      throw e.toString();
    }
  }
}

@riverpod
ShiftRepository shiftRepository(Ref ref) =>
    ShiftService(tablesDB: ref.watch(appwriteTablesDBProvider));
