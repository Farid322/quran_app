import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/features/quran/cubit/cubit/quran_cubit.dart';
import 'package:quran_app/features/quran/views/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
          create: (context) => QuranCubit()..loadSour(),
          child: QuranHomeScreen(),
        ));
  }
}
