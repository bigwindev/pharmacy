class Pharmacy {
  final String name;
  final String id;
  List<String>? medications;

  Pharmacy({
    required this.name,
    required this.id,
    this.medications,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      name: json['name'],
      id: json['pharmacyId'],
      medications: (json['medications'] as List<dynamic>?)?.map((
          e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'pharmacyId': id,
      'medications': medications,
    };
  }
}
