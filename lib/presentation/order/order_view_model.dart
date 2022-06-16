import 'package:flutter/material.dart';

import '../../domain/model/pharmacy_details.dart';
import '../../domain/usecase/complete_order_use_case.dart';
import '../../domain/usecase/get_available_pharmacy_use_case.dart';
import '../../domain/usecase/get_medications_use_case.dart';

class OrderViewModel extends ChangeNotifier {
  final GetAvailablePharmacyUseCase _getAvailablePharmacyUseCase = GetAvailablePharmacyUseCase();
  final GetMedicationsUseCase _getMedicationsUseCase = GetMedicationsUseCase();
  final CompleteOrderUseCase _completeOrderUseCase = CompleteOrderUseCase();

  bool isLoading = false;
  PharmacyDetails? pharmacyDetails;
  List<String> medications = [];
  String? error;
  final List<String> _selectedMedications = [];

  Future<void> getAvailablePharmacyToOrder() async {
    isLoading = true;
    error = null;

    Future.wait([
      _getAvailablePharmacyUseCase.execute(),
      _getMedicationsUseCase.execute(),
    ])
        .then((value) =>
        _setPharmacyDetails(
            value[0] as PharmacyDetails?, value[1] as List<String>))
        .onError((error, stackTrace) => _setError(error.toString()));
  }

  void setSelected(String medication, bool selected) {
    if (selected) {
      _selectedMedications.add(medication);
    } else {
      _selectedMedications.remove(medication);
    }
  }

  List completeOrder() {
    if (_selectedMedications.isEmpty) {
      return [false, "Please select medications"];
    }

    _completeOrderUseCase.setId(pharmacyDetails!.id);
    _completeOrderUseCase.setMedications(_selectedMedications);
    _completeOrderUseCase.execute();

    return [true];
  }

  void _setPharmacyDetails(PharmacyDetails? pharmacyDetails,
      List<String> medications) {
    isLoading = false;
    this.pharmacyDetails = pharmacyDetails;
    this.medications = medications;
    notifyListeners();
  }

  void _setError(String error) {
    isLoading = false;
    this.error = error;
    notifyListeners();
  }
}
