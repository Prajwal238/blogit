import 'package:blogit/bloc/search/search_bloc.dart';
import 'package:blogit/repositories/auth_repository.dart';
import 'package:blogit/repositories/database_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'bloc/authentication/auth_bloc.dart';
import 'bloc/database/database_bloc.dart';
import 'bloc/form-validation/form_bloc.dart';
import 'utility/app_blocobserver.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = AppBlocObserver();
 runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthBloc(AuthRepository())
                ..add(AuthStarted()),
        ),
        BlocProvider(
          create: (context) => FormBloc(
              AuthRepository(), DatabaseRepositoryImpl()),
        ),
        BlocProvider(
          create: (context) => DatabaseBloc(DatabaseRepositoryImpl()),
        ),
        BlocProvider(
          create: (context) => SearchBloc(DatabaseRepositoryImpl()),
        )
      ],
      child: const App(),
    ));
}