import 'dart:math';

class Location {
  final double latitude;
  final double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  double distanceTo(Location to) {
    double p = 0.017453292519943295;
    double a = 0.5 - cos((to.latitude - latitude) * p) / 2 +
        cos(latitude * p) * cos(to.latitude * p) *
            (1 - cos((to.longitude - longitude) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
