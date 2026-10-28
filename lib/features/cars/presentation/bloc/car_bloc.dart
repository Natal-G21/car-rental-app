
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_cars.dart';
import 'car_event.dart';
import 'car_state.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  final GetCars getCars;

  CarBloc({
    required this.getCars,
  }) : super(const CarInitial()) {
    on<CarsRequested>(_onCarsRequested);
  }

  Future<void> _onCarsRequested(
    CarsRequested event,
    Emitter<CarState> emit,
  ) async {
    emit(const CarLoading());

    try {
      final cars = await getCars();
      emit(CarLoaded(cars));
    } catch (_) {
      emit(
        const CarFailure(
          'Unable to load cars. Please try again.',
        ),
      );
    }
  }
}
