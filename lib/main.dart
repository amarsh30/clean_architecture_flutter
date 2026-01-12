import 'package:bloc/bloc.dart';
import 'package:clean_architecture/core/routes/my_router.dart';
import 'package:clean_architecture/features/profile/data/models/profile_model.dart';
import 'package:clean_architecture/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // initialize
  await Hive.initFlutter();

  Hive.registerAdapter(ProfileModelAdapter());
  Bloc.observer = MyObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: MyRouter().router);
  }
}
