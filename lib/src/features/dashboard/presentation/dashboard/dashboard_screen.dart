import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:presensa_app/src/core/providers/user_data_provider.dart';
import 'package:presensa_app/src/features/dashboard/data/models/dashboard.dart';
import 'package:presensa_app/src/features/dashboard/providers/dashboard_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(dashboardDataProvider);
    final user = ref.watch(userDataProvider).value;

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: dashboardAsync.when(
        data: (dashboardData) => RefreshIndicator(
          onRefresh: () => ref.refresh(dashboardDataProvider.future),
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              // 1. Salam & Ringkasan
              _buildGreeting(context, user?.name ?? 'Admin'),
              const SizedBox(height: 24),

              // 2. Kartu Statistik Utama
              _buildStatsGrid(context, dashboardData),
              const SizedBox(height: 24),

              // 3. Aktivitas Terkini
              Text(
                'Aktivitas Terkini',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              _buildRecentActivity(dashboardData.recentActivities),

              // 4. Pintasan Cepat (jika ada)
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Gagal memuat data: $err')),
      ),
    );
  }

  // Helper Widgets
  Widget _buildGreeting(BuildContext context, String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selamat Pagi, $name',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.now()),
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildStatsGrid(BuildContext context, DashboardModel data) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 2.0, // Membuat kartu lebih lebar
      children: [
        _buildStatCard(
          context,
          'Hadir',
          data.presentCount.toString(),
          Icons.check_circle_outline,
          Colors.green,
        ),
        _buildStatCard(
          context,
          'Terlambat',
          data.lateCount.toString(),
          Icons.warning_amber_rounded,
          Colors.orange,
        ),
        _buildStatCard(
          context,
          'Absen',
          data.absentCount.toString(),
          Icons.cancel_outlined,
          Colors.red,
        ),
        _buildStatCard(
          context,
          'Izin',
          data.leaveCount.toString(),
          Icons.event_note_outlined,
          Colors.blue,
        ),
      ],
    );
  }

  // Di dalam DashboardScreen

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String count,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 2,
      // Gunakan Clip.antiAlias agar efek splash/inkwell tetap di dalam rounded corners
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // TODO: Aksi saat kartu diketuk, misal navigasi ke daftar karyawan
          // yang hadir, terlambat, dll.
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // --- BARIS ATAS ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // Gunakan Expanded pada judul agar ikon tidak terdorong
                children: [
                  Expanded(
                    // Gunakan FittedBox untuk mengecilkan judul jika terlalu panjang
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8), // Beri sedikit jarak
                  Icon(icon, color: color, size: 24),
                ],
              ),

              // --- BARIS BAWAH ---
              // Gunakan Expanded dan Align untuk memastikan posisi yang benar
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  // Gunakan FittedBox untuk angka juga
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      count,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentActivity(List<Activity> activities) {
    if (activities.isEmpty) {
      return const Text('Belum ada aktivitas hari ini.');
    }
    return Column(
      children: activities
          .map(
            (activity) => ListTile(
              leading: const Icon(Icons.person_outline),
              title: Text(activity.employeeName),
              subtitle: Text(activity.status),
              trailing: Text(DateFormat('HH:mm').format(activity.timestamp)),
            ),
          )
          .toList(),
    );
  }
}
