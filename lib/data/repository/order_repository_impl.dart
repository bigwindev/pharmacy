import '../../domain/model/pharmacy.dart';
import '../../domain/repository/order_repository.dart';
import '../local/preferences_helper.dart';
import '../local/preferences_helper_impl.dart';

class OrderRepositoryImpl extends OrderRepository {

  final PreferencesHelper _preferencesHelper = PreferencesHelperImpl();

  @override
  Future<bool> complete(String pharmacyId, List<String> medications) async {
    var pharmacies = await _preferencesHelper.getPharmacies();
    int index = pharmacies.indexWhere((pharmacy) => pharmacy.id == pharmacyId);

    if (index == -1) {
      return false;
    }

    Pharmacy oldPharmacy = pharmacies.removeAt(index);
    Pharmacy newPharmacy = Pharmacy(
      name: oldPharmacy.name,
      id: pharmacyId,
      medications: medications,
    );
    pharmacies.insert(index, newPharmacy);

    return _preferencesHelper.setPharmacies(pharmacies);
  }
}
