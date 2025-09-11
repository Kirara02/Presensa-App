class Shift {
  final String id;
  final String name;
  final String startTime;
  final String endTime;
  final String timezone;
  final List<String> workDays;
  final int lateToleranceMinutes;

  Shift({
    required this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.timezone,
    required this.workDays,
    required this.lateToleranceMinutes,
  });

  Shift copyWith({
    String? id,
    String? name,
    String? startTime,
    String? endTime,
    String? timezone,
    List<String>? workDays,
    int? lateToleranceMinutes,
  }) {
    return Shift(
      id: id ?? this.id,
      name: name ?? this.name,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      timezone: timezone ?? this.timezone,
      workDays: workDays ?? this.workDays,
      lateToleranceMinutes: lateToleranceMinutes ?? this.lateToleranceMinutes,
    );
  }

  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      id: json['\$id'] ?? '',
      name: json['name'] ?? 'Unnamed Shift',
      startTime: json['startTime'] ?? '00:00',
      endTime: json['endTime'] ?? '00:00',
      timezone: json['timezone'] ?? 'Asia/Jakarta',
      workDays: List<String>.from(json['workDays'] ?? []),
      lateToleranceMinutes: json['lateToleranceMinutes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'startTime': startTime,
      'endTime': endTime,
      'timezone': timezone,
      'workDays': workDays,
      'lateToleranceMinutes': lateToleranceMinutes,
    };
  }
}
