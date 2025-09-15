import 'package:appwrite/appwrite.dart';
import 'package:presensa_app/src/constants/db_keys.dart';
import 'package:presensa_app/src/core/providers/appwrite_provider.dart';
import 'package:presensa_app/src/features/more/data/models/company.dart';
import 'package:presensa_app/src/features/more/data/repository/company_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'company_service.g.dart';

class CompanyService implements CompanyRepository {
  final TablesDB _tablesDB;

  final String databaseId = DBKeys.appwriteDatabaseId.initial;
  final String companiesTableId = DBKeys.appwriteTableCompaniesId.initial;

  CompanyService({required TablesDB tablesDB}) : _tablesDB = tablesDB;

  @override
  Future<Company> getCompany(String companyId) async {
    try {
      final document = await _tablesDB.getRow(
        databaseId: databaseId,
        tableId: companiesTableId,
        rowId: companyId,
      );
      return Company.fromJson(document.data);
    } on AppwriteException catch (e) {
      throw e.message ?? 'Gagal memuat data perusahaan';
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<Company> updateCompany(Company company) async {
    try {
      final document = await _tablesDB.updateRow(
        databaseId: databaseId,
        tableId: companiesTableId,
        rowId: company.id,
        data: company.toJson(),
      );
      return Company.fromJson(document.data);
    } on AppwriteException catch (e) {
      throw e.message ?? 'Gagal memperbarui data perusahaan';
    } catch (e) {
      throw e.toString();
    }
  }
}

@riverpod
CompanyRepository companyRepository(Ref ref) =>
    CompanyService(tablesDB: ref.watch(appwriteTablesDBProvider));
