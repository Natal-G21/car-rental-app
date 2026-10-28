
import '../entities/car.dart';
import '../repositories/car_repository.dart';

class GetCars {
  final CarRepository repository;

  const GetCars({
    required this.repository,
  });

  Future<List<Car>> call() {
    return repository.getCars();
  }
}
