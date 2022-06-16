import '../../data/repository/pharmacy_repository_impl.dart';
import '../model/pharmacy_details.dart';
import '../repository/pharmacy_repository.dart';
import 'base_use_case.dart';

class GetPharmacyDetailsUseCase extends BaseUseCase<PharmacyDetails> {

  final PharmacyRepository _pharmacyRepository = PharmacyRepositoryImpl();
  late String _id;

  void setId(String id) {
    _id = id;
  }

  @override
  Future<PharmacyDetails> execute() {
    return _pharmacyRepository.getPharmacyDetails(_id);
  }
}
