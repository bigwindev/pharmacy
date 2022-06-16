abstract class OrderRepository {
  Future<bool> complete(String pharmacyId, List<String> medications);
}
