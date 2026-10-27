import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../../core/di/injection_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (_) => sl<AuthBloc>(),
      child: Builder(builder: (context){
        return ElevatedButton(
        onPressed: () {
          context.read<AuthBloc>().add(
            const LogoutRequested(),
          );
        },
        child: const Text('Logout'),
      );
      })
    );
  }
}
