import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:presensa_app/src/features/dashboard/data/models/dashboard.dart';

part 'dashboard_provider.g.dart';

// Ini adalah repository palsu, ganti dengan panggilan service/fungsi Anda
class MockDashboardRepository {
  Future<DashboardModel> getDashboardData() async {
    await Future.delayed(const Duration(milliseconds: 800)); // Simulasi loading
    return DashboardModel(
      presentCount: 25,
      lateCount: 3,
      absentCount: 2,
      leaveCount: 1,
      recentActivities: [
        Activity(
          employeeName: 'Budi Santoso',
          status: 'Absen Masuk',
          timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        ),
        Activity(
          employeeName: 'Citra Lestari',
          status: 'Absen Masuk',
          timestamp: DateTime.now().subtract(const Duration(minutes: 12)),
        ),
        Activity(
          employeeName: 'Eko Prasetyo',
          status: 'Absen Pulang',
          timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        ),
      ],
    );
  }
}

final dashboardRepositoryProvider = Provider((_) => MockDashboardRepository());

@riverpod
class DashboardData extends _$DashboardData {
  @override
  Future<DashboardModel> build() async {
    final repository = ref.watch(dashboardRepositoryProvider);
    return repository.getDashboardData();
  }
}
