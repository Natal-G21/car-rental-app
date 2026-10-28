import '../../features/cars/data/datasources/car_remote_data_source.dart';
import '../../features/cars/data/repositories/car_repository_impl.dart';
import '../../features/cars/domain/repositories/car_repository.dart';
import '../../features/cars/domain/usecases/get_cars.dart';
import '../../features/cars/presentation/bloc/car_bloc.dart';
import 'package:car_rent_app/features/auth/domain/usecase/logout_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecase/login_user.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Firebase Authentication
  sl.registerLazySingleton<FirebaseAuth>(
    () => FirebaseAuth.instance,
  );

  // Car data source
sl.registerLazySingleton<CarRemoteDataSource>(
  () => CarRemoteDataSourceImpl(),
);

// Car repository
sl.registerLazySingleton<CarRepository>(
  () => CarRepositoryImpl(
    remoteDataSource: sl<CarRemoteDataSource>(),
  ),
);

// Get cars use case
sl.registerLazySingleton<GetCars>(
  () => GetCars(
    repository: sl<CarRepository>(),
  ),
);

// Car BLoC
sl.registerFactory<CarBloc>(
  () => CarBloc(
    getCars: sl<GetCars>(),
  ),
);

  // Remote data source
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(
      firebaseAuth: sl<FirebaseAuth>(),
    ),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
    ),
  );

  // Login use case
  sl.registerLazySingleton<LoginUser>(
    () => LoginUser(
      repository: sl<AuthRepository>(),
    ),
  );

  sl.registerFactory<AuthBloc>(
  () => AuthBloc(
    loginUser: sl<LoginUser>(),
    logoutUser: sl<LogoutUser>(),
  ),
);

sl.registerLazySingleton<LogoutUser>(
  () => LogoutUser(
    repository: sl<AuthRepository>(),
  ),
);
}
