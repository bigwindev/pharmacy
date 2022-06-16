import '../../../domain/model/pharmacy_details.dart';

abstract class ApiService {
  Future<PharmacyDetails> getPharmacyDetails(String id);
  Future<List<String>> getMedications();
}