import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../car_provider.dart';
import '../screens/car_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CarProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CarScreen(),
    );
  }
}