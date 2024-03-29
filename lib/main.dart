import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/calculator_screen.dart';
import 'provider/calculator_provider.dart';
import 'provider/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CalculatorViewModel()),
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    var viewmodel = context.watch<ThemeViewModel>();

    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Pretendard",
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: viewmodel.seedColor,
          brightness: viewmodel.brightness,
        ),
      ),
      home: const CalculatorScreen(),
    );
  }
}
