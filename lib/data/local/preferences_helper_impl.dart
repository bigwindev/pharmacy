import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../utils//constants.dart' as constants;
import '../../domain/model/pharmacy.dart';
import 'preferences_helper.dart';

class PreferencesHelperImpl extends PreferencesHelper {

  @override
  Future<List<Pharmacy>> getPharmacies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final pharmacyStringList = prefs.getStringList(constants.prefKeyPharmacies);

    if (pharmacyStringList == null) {
      final pharmacyJsonList = constants.pharmacies["pharmacies"] as List<
          Map<String, dynamic>>;
      return pharmacyJsonList.map((json) => Pharmacy.fromJson(json)).toList();
    } else {
      return pharmacyStringList.map((pharmacyString) =>
          Pharmacy.fromJson(jsonDecode(pharmacyString))
      ).toList();
    }
  }

  @override
  Future<bool> setPharmacies(List<Pharmacy> pharmacies) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> pharmacyStringList = pharmacies.map((pharmacy) =>
        jsonEncode(pharmacy)).toList();
    return prefs.setStringList(constants.prefKeyPharmacies, pharmacyStringList);
  }
}
