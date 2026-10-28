
import 'package:equatable/equatable.dart';

import '../../domain/entities/car.dart';

abstract class CarState extends Equatable {
  const CarState();

  @override
  List<Object?> get props => [];
}

class CarInitial extends CarState {
  const CarInitial();
}

class CarLoading extends CarState {
  const CarLoading();
}

class CarLoaded extends CarState {
  final List<Car> cars;

  const CarLoaded(this.cars);

  @override
  List<Object?> get props => [cars];
}

class CarFailure extends CarState {
  final String message;

  const CarFailure(this.message);

  @override
  List<Object?> get props => [message];
}
