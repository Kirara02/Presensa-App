class Company {
  final String id;
  final String name;
  final String? address;
  final String? location;

  Company({required this.id, required this.name, this.address, this.location});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['\$id'] ?? '',
      name: json['name'] ?? 'Nama Perusahaan Tidak Ada',
      address: json['address'],
      location: json['location'],
    );
  }
}
