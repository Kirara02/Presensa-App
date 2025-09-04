import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presensa_app/src/constants/navigation_bar_data.dart';
import 'package:presensa_app/src/core/providers/user_data_provider.dart';
import 'package:presensa_app/src/routes/router_config.dart';
import 'package:presensa_app/src/utils/extensions/custom_extensions.dart';
import 'package:presensa_app/src/widgets/shell/big_screen_navigation_bar.dart';
import 'package:presensa_app/src/widgets/shell/small_screen_navigation_bar.dart';

class ShellScreen extends ConsumerWidget {
  const ShellScreen({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listener Anda untuk handle logout atau error sudah benar
    ref.listen(userDataProvider, (prev, next) {
      if (prev != null && next is AsyncData && next.value == null) {
        LoginRoute().go(context);
      } else if (next is AsyncError) {
        context.showSnackBar(next.error.toString());
      }
    });

    // Tonton state user data
    final userAsyncValue = ref.watch(userDataProvider);
    final location = context.location;

    // Gunakan .when untuk menangani semua state dari provider
    return userAsyncValue.when(
      // Tampilkan loading indicator saat data user sedang diambil
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      // Tampilkan pesan error jika gagal mengambil data user
      error: (err, stack) => Scaffold(
        body: Center(child: Text('Gagal memuat data: $err')),
      ),
      // Jika data berhasil didapat
      data: (user) {
        // Ambil role dari objek user. Akan menjadi null jika user logout.
        final String? userRole = user?.role;
        
        // Dapatkan daftar navigasi yang sesuai dengan role
        final navList = NavigationBarData.getNavListForRole(userRole);

        // Sisanya sama seperti sebelumnya, UI akan beradaptasi secara otomatis
        if (context.isTablet) {
          return Scaffold(
            body: Row(
              children: [
                // Pastikan AdminBigScreenNavigationBar juga sudah dimodifikasi
                // untuk menerima navList
                BigScreenNavigationBar(
                  selectedScreen: location,
                  navList: navList,
                ),
                Expanded(child: child),
              ],
            ),
          );
        } else {
          return Scaffold(
            body: child,
            bottomNavigationBar: SmallScreenNavigationBar(
              selectedScreen: location,
              navList: navList, // Teruskan navList yang sudah dinamis
            ),
          );
        }
      },
    );
  }
}