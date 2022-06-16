import '../../domain/repository/medication_repository.dart';
import '../api/service/api_service.dart';
import '../api/service/api_service_impl.dart';

class MedicationRepositoryImpl extends MedicationRepository {

  final ApiService _apiService = ApiServiceImpl();

  @override
  Future<List<String>> getMedications() {
    return _apiService.getMedications();
  }
}
