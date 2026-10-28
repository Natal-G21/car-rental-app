
import '../../domain/entities/car.dart';
import '../../domain/repositories/car_repository.dart';
import '../datasources/car_remote_data_source.dart';

class CarRepositoryImpl implements CarRepository {
  final CarRemoteDataSource remoteDataSource;

  const CarRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<List<Car>> getCars() {
    return remoteDataSource.getCars();
  }
}
