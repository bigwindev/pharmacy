import '../../data/repository/order_repository_impl.dart';
import '../repository/order_repository.dart';
import 'base_use_case.dart';

class CompleteOrderUseCase extends BaseUseCase<bool> {

  final OrderRepository _orderRepository = OrderRepositoryImpl();
  late String _pharmacyId;
  late List<String> _medications;

  void setId(String pharmacyId) {
    _pharmacyId = pharmacyId;
  }

  void setMedications(List<String> medications) {
    _medications = medications;
  }

  @override
  Future<bool> execute() {
    return _orderRepository.complete(_pharmacyId, _medications);
  }
}
