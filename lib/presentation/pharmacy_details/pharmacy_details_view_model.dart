import 'package:flutter/material.dart';

import '../../domain/model/pharmacy_details.dart';
import '../../domain/usecase/get_pharmacy_details_use_case.dart';

class PharmacyDetailsViewModel extends ChangeNotifier {
  final GetPharmacyDetailsUseCase _getPharmacyDetailsUseCase = GetPharmacyDetailsUseCase();

  bool isLoading = false;
  PharmacyDetails? pharmacyDetails;
  String? error;

  Future<void> getPharmacyDetails(String id) async {
    isLoading = true;
    error = null;

    _getPharmacyDetailsUseCase.setId(id);
    _getPharmacyDetailsUseCase.execute()
        .then((value) => _setPharmacyDetails(value))
        .onError((error, stackTrace) => _setError(error.toString()));
  }

  void _setPharmacyDetails(PharmacyDetails pharmacyDetails) {
    isLoading = false;
    this.pharmacyDetails = pharmacyDetails;
    notifyListeners();
  }

  void _setError(String error) {
    isLoading = false;
    this.error = error;
    notifyListeners();
  }
}
