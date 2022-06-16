import '../../data/repository/pharmacy_repository_impl.dart';
import '../model/pharmacy_details.dart';
import '../repository/pharmacy_repository.dart';
import 'base_use_case.dart';

class GetAvailablePharmacyUseCase extends BaseUseCase<PharmacyDetails?> {

  final PharmacyRepository _pharmacyRepository = PharmacyRepositoryImpl();

  @override
  Future<PharmacyDetails?> execute() {
    return _pharmacyRepository.getAvailablePharmacyToOrder();
  }
}
