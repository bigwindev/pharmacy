import '../model/pharmacy.dart';
import '../model/pharmacy_details.dart';

abstract class PharmacyRepository {
  Future<List<Pharmacy>> getPharmacies();
  Future<PharmacyDetails> getPharmacyDetails(String id);
  Future<PharmacyDetails?> getAvailablePharmacyToOrder();
}
