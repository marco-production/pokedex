import 'package:flutter/material.dart';
import 'package:pokedex/app/providers/pokemon_provider.dart';
import 'package:pokedex/ui/screens/home_screen.dart';
import 'package:pokedex/ui/screens/pokemon_details_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PokemonProvider())
      ],
      child: MaterialApp(
        title: 'Pokedex',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          '/home' : (context) => const HomeScreen(),
          '/details' : (context) => const PokemonDetailsScreen(),
        },
        initialRoute: '/home',
      ),
    );
  }
}