class Company {
  final String id;
  final String name;
  final String? address;
  final String? location;

  Company({required this.id, required this.name, this.address, this.location});

  double? get latitude {
    if (location == null || location!.isEmpty) {
      return null;
    }

    try {
      final parts = location!.split(',');
      if (parts.length == 2) {
        return double.tryParse(parts[0].trim());
      }
    } catch (e) {
      return null;
    }

    return null;
  }

  double? get longitude {
    if (location == null || location!.isEmpty) {
      return null;
    }

    try {
      final parts = location!.split(',');
      if (parts.length == 2) {
        return double.tryParse(parts[1].trim());
      }
    } catch (e) {
      return null;
    }

    return null;
  }

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['\$id'] ?? '',
      name: json['name'] ?? 'Nama Perusahaan Tidak Ada',
      address: json['address'],
      location: json['location'],
    );
  }

  // --- TAMBAHKAN METODE INI ---
  Map<String, dynamic> toJson() {
    return {'name': name, 'address': address, 'location': location};
  }

  // Opsional, tapi sangat berguna
  Company copyWith({
    String? id,
    String? name,
    String? address,
    String? location,
  }) {
    return Company(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      location: location ?? this.location,
    );
  }
}
