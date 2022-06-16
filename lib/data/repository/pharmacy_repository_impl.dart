import '../../domain/model/location.dart';
import '../../domain/repository/pharmacy_repository.dart';
import '../../domain/model/pharmacy.dart';
import '../../domain/model/pharmacy_details.dart';
import '../api/service/api_service.dart';
import '../api/service/api_service_impl.dart';
import '../local/preferences_helper.dart';
import '../local/preferences_helper_impl.dart';

class PharmacyRepositoryImpl extends PharmacyRepository {

  final PreferencesHelper _preferencesHelper = PreferencesHelperImpl();
  final ApiService _apiService = ApiServiceImpl();

  final Location _currentLocation = Location(
    latitude: 37.48771670017411,
    longitude: -122.22652739630438,
  );

  @override
  Future<List<Pharmacy>> getPharmacies() {
    return _preferencesHelper.getPharmacies();
  }

  @override
  Future<PharmacyDetails> getPharmacyDetails(String id) {
    return _apiService.getPharmacyDetails(id);
  }

  @override
  Future<PharmacyDetails?> getAvailablePharmacyToOrder() async {
    final pharmacies = await _preferencesHelper.getPharmacies();
    final availablePharmacies = await Future.wait(
        pharmacies
            .where((pharmacy) => pharmacy.medications == null)
            .map((pharmacy) => _apiService.getPharmacyDetails(pharmacy.id))
    );
    availablePharmacies.sort((a, b) =>
        a.address.location.distanceTo(_currentLocation).compareTo(
            b.address.location.distanceTo(_currentLocation))
    );

    if (availablePharmacies.isEmpty) {
      return null;
    } else {
      return availablePharmacies.first;
    }
  }
}
