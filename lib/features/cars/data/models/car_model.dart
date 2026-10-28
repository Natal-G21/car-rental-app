
import '../../domain/entities/car.dart';

class CarModel extends Car {
  const CarModel({
    required super.id,
    required super.name,
    required super.brand,
    required super.year,
    required super.pricePerDay,
    required super.imageUrl,
    required super.transmission,
    required super.seats,
    required super.isAvailable,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'] as String,
      name: json['name'] as String,
      brand: json['brand'] as String,
      year: (json['year'] as num).toInt(),
      pricePerDay: (json['pricePerDay'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      transmission: json['transmission'] as String,
      seats: (json['seats'] as num).toInt(),
      isAvailable: json['isAvailable'] as bool,
    );
  }
}
