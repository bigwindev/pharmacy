import '../../data/repository/medication_repository_impl.dart';
import '../repository/medication_repository.dart';
import 'base_use_case.dart';

class GetMedicationsUseCase extends BaseUseCase<List<String>> {

  final MedicationRepository _medicationRepository = MedicationRepositoryImpl();

  @override
  Future<List<String>> execute() {
    return _medicationRepository.getMedications();
  }
}
