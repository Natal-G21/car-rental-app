
import '../models/car_model.dart';

abstract class CarRemoteDataSource {
  Future<List<CarModel>> getCars();
}

class CarRemoteDataSourceImpl implements CarRemoteDataSource {
  @override
  Future<List<CarModel>> getCars() async {
    return const [
      CarModel(
        id: 'car-001',
        name: 'Corolla',
        brand: 'Toyota',
        year: 2023,
        pricePerDay: 2500,
        imageUrl: '',
        transmission: 'Automatic',
        seats: 5,
        isAvailable: true,
      ),
      CarModel(
        id: 'car-002',
        name: 'Civic',
        brand: 'Honda',
        year: 2022,
        pricePerDay: 2200,
        imageUrl: '',
        transmission: 'Manual',
        seats: 5,
        isAvailable: true,
      ),
      CarModel(
        id: 'car-003',
        name: 'Sportage',
        brand: 'Kia',
        year: 2024,
        pricePerDay: 3500,
        imageUrl: '',
        transmission: 'Automatic',
        seats: 5,
        isAvailable: false,
      ),
    ];
  }
}
