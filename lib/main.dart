import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stryn_esport/pages/app/app.dart';
import 'package:stryn_esport/repositories/auth_repository.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final authRepository = AuthenticationRepository();
  await authRepository.user.first;

  BlocOverrides.runZoned(
    () => runApp(App(authenticationRepository: authRepository)),
    // blocObserver: AppBlocObserver(),
  );
}
