import 'package:clean_architecture/core/routes/my_router.dart';
import 'package:clean_architecture/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:clean_architecture/injection.dart';
import 'package:clean_architecture/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // initialize
  await Hive.initFlutter();

  await init();

  Bloc.observer = MyObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => myinjection<ProfileBloc>()),
      ],
      child: MaterialApp.router(routerConfig: MyRouter().router),
    );
  }
}
