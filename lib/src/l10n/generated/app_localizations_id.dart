// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get app_name => 'Presensa';

  @override
  String get app_language => 'Bahasa Aplikasi';

  @override
  String get app_theme => 'Mode Tema Aplikasi';

  @override
  String get theme_mode_dark => 'Gelap';

  @override
  String get theme_mode_light => 'Terang';

  @override
  String get theme_mode_system => 'Sistem';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get attendance => 'Absensi';

  @override
  String get employees => 'Karyawan';

  @override
  String get reports => 'Laporan';

  @override
  String get more => 'Lainnya';

  @override
  String get settings => 'Settings';

  @override
  String get profile => 'Profil';

  @override
  String get company => 'Perusahaan';

  @override
  String get change_password => 'Ubah Password';

  @override
  String get about => 'Tentang';

  @override
  String get logout => 'Keluar';

  @override
  String get is_true_black => 'Hitam Pekat';

  @override
  String get client => 'Client';

  @override
  String get client_version => 'Versi Client';

  @override
  String copy_msg(Object msg) {
    return '\'$msg\' Tersalin!';
  }

  @override
  String get check_for_updates => 'Periksa pembaruan';

  @override
  String get check_app_store => 'Silakan cek di App Store secara manual';

  @override
  String get no_updates_available => 'Anda menggunakan versi terbaru';

  @override
  String get update_failed => 'Gagal memperbarui';

  @override
  String get role => 'Peran';

  @override
  String get role_employee => 'Karyawan';

  @override
  String get role_admin => 'Admin';
}
