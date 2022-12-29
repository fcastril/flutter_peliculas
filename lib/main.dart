import 'package:flutter/material.dart';
import 'package:peliculas/screens/screens.dart';
import 'package:peliculas/themes/apptheme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Peliculas',
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomeScreen(),
          'details': (_) => const DetailsScreen()
        },
        theme: AppTheme.lightTheme);
  }
}
