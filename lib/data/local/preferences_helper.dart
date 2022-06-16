import '../../domain/model/pharmacy.dart';

abstract class PreferencesHelper {
  Future<List<Pharmacy>> getPharmacies();
  Future<bool> setPharmacies(List<Pharmacy> pharmacies);
}