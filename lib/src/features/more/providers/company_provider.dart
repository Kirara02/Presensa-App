import 'package:presensa_app/src/core/providers/user_data_provider.dart';
import 'package:presensa_app/src/features/more/data/models/company.dart';
import 'package:presensa_app/src/features/more/data/services/company_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'company_provider.g.dart';

@riverpod
class CompanyData extends _$CompanyData {
  @override
  Future<Company?> build() async {
    final companyRepository = ref.watch(companyRepositoryProvider);
    // Data perusahaan bergantung pada user yang login
    final user = ref.watch(userDataProvider).value;

    // Jika tidak ada user atau companyId, tidak ada data perusahaan untuk diambil
    if (user?.company?.id == null) {
      return null;
    }

    return companyRepository.getCompany(user!.company!.id);
  }

  /// Memperbarui data perusahaan
  Future<void> updateCompany(Company updatedCompany) async {
    final companyRepository = ref.read(companyRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return companyRepository.updateCompany(updatedCompany);
    });
  }
}
