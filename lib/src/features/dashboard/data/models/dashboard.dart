class DashboardModel {
  final int presentCount;
  final int lateCount;
  final int absentCount;
  final int leaveCount; // Izin
  final List<Activity> recentActivities;

  DashboardModel({
    required this.presentCount,
    required this.lateCount,
    required this.absentCount,
    required this.leaveCount,
    required this.recentActivities,
  });
}

class Activity {
  final String employeeName;
  final String status; // Misal: "Absen Masuk" atau "Absen Pulang"
  final DateTime timestamp;

  Activity({required this.employeeName, required this.status, required this.timestamp});
}