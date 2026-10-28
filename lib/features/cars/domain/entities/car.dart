
import 'package:equatable/equatable.dart';

class Car extends Equatable {
  final String id;
  final String name;
  final String brand;
  final int year;
  final double pricePerDay;
  final String imageUrl;
  final String transmission;
  final int seats;
  final bool isAvailable;

  const Car({
    required this.id,
    required this.name,
    required this.brand,
    required this.year,
    required this.pricePerDay,
    required this.imageUrl,
    required this.transmission,
    required this.seats,
    required this.isAvailable,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        brand,
        year,
        pricePerDay,
        imageUrl,
        transmission,
        seats,
        isAvailable,
      ];
}
