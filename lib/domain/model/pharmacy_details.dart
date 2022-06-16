import 'pharmacy_address.dart';

class PharmacyDetails {
  final String name;
  final String id;
  final PharmacyAddress address;
  final String? primaryPhoneNumber;
  final String? pharmacyHours;

  PharmacyDetails({
    required this.name,
    required this.id,
    required this.address,
    this.primaryPhoneNumber,
    this.pharmacyHours,
  });

  factory PharmacyDetails.fromJson(Map<String, dynamic> json) {
    return PharmacyDetails(
      name: json['value']['name'],
      id: json['value']['id'],
      address: PharmacyAddress.fromJson(json['value']['address']),
      primaryPhoneNumber: json['value']['primaryPhoneNumber'],
      pharmacyHours: json['value']['pharmacyHours'],
    );
  }
}
