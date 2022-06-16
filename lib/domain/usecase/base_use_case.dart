abstract class BaseUseCase<T> {
  Future<T> execute();
}