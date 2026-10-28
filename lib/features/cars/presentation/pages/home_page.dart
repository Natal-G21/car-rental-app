import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../bloc/car_bloc.dart';
import '../bloc/car_event.dart';
import '../bloc/car_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()),
        BlocProvider<CarBloc>(
          create: (_) => sl<CarBloc>()..add(const CarsRequested()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Available Cars'),

          actions: [
            Builder(
              builder: (pageContext) {
                return IconButton(
                  onPressed: () {
                    pageContext.read<AuthBloc>().add(const LogoutRequested());
                  },
                  icon: const Icon(Icons.logout),
                  tooltip: 'Logout',
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<CarBloc, CarState>(
          builder: (context, state) {
            if (state is CarLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is CarFailure) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.message),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CarBloc>().add(const CarsRequested());
                      },
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              );
            }

            if (state is CarLoaded) {
              if (state.cars.isEmpty) {
                return const Center(child: Text('No cars available yet.'));
              }

              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.cars.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final car = state.cars[index];

                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: car.imageUrl.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      car.imageUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return const Icon(
                                              Icons.directions_car,
                                              size: 42,
                                            );
                                          },
                                    ),
                                  )
                                : const Icon(Icons.directions_car, size: 42),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${car.brand} ${car.name}',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 4),
                                Text('${car.year} • ${car.transmission}'),
                                Text('${car.seats} seats'),
                                const SizedBox(height: 8),
                                Text(
                                  '${car.pricePerDay.toStringAsFixed(0)} birr / day',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  car.isAvailable
                                      ? 'Available'
                                      : 'Currently unavailable',
                                  style: TextStyle(
                                    color: car.isAvailable
                                        ? Colors.green
                                        : Colors.red,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            return const Center(child: Text('Preparing your car list...'));
          },
        ),
      ),
    );
  }
}
