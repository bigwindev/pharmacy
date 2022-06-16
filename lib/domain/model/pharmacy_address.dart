import 'location.dart';

class PharmacyAddress {
  final String city;
  final Location location;
  final String postalCode;
  final String streetAddress1;
  final String usTerritory;

  PharmacyAddress({
    required this.city,
    required this.location,
    required this.postalCode,
    required this.streetAddress1,
    required this.usTerritory,
  });

  factory PharmacyAddress.fromJson(Map<String, dynamic> json) {
    return PharmacyAddress(
      city: json['city'],
      location: Location(
        latitude: json['latitude'],
        longitude: json['longitude'],
      ),
      postalCode: json['postalCode'],
      streetAddress1: json['streetAddress1'],
      usTerritory: json['usTerritory'],
    );
  }

  String getFullAddress() {
    return "$streetAddress1, $city, $postalCode, $usTerritory";
  }
}
