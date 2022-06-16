import '../../data/repository/pharmacy_repository_impl.dart';
import '../model/pharmacy.dart';
import '../repository/pharmacy_repository.dart';
import 'base_use_case.dart';

class GetPharmaciesUseCase extends BaseUseCase<List<Pharmacy>> {

  final PharmacyRepository _pharmacyRepository = PharmacyRepositoryImpl();

  @override
  Future<List<Pharmacy>> execute() {
    return _pharmacyRepository.getPharmacies();
  }
}
