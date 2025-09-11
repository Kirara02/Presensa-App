import 'package:presensa_app/src/features/more/data/models/company.dart';

abstract class CompanyRepository {
  /// Mengambil detail satu perusahaan berdasarkan ID-nya.
  Future<Company> getCompany(String companyId);

  /// Memperbarui data perusahaan.
  Future<Company> updateCompany(Company company);
}
