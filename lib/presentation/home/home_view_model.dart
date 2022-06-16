import 'package:flutter/material.dart';

import '../../domain/model/pharmacy.dart';
import '../../domain/usecase/get_pharmacies_use_case.dart';

class HomeViewModel extends ChangeNotifier {
  final GetPharmaciesUseCase _getPharmaciesUseCase = GetPharmaciesUseCase();

  bool isLoading = false;
  List<Pharmacy> pharmacies = [];
  String? error;

  Future<void> getPharmacies() async {
    isLoading = true;
    error = null;

    _getPharmaciesUseCase.execute()
        .then((value) => _setPharmacies(value))
        .onError((error, stackTrace) => _setError(error.toString()));
  }

  void _setPharmacies(List<Pharmacy> pharmacies) {
    isLoading = false;
    this.pharmacies = pharmacies;
    notifyListeners();
  }

  void _setError(String error) {
    isLoading = false;
    this.error = error;
    notifyListeners();
  }
}
