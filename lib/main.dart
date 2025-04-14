import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infomovis/screens/detail_screen.dart';
import 'package:infomovis/screens/favori_screen.dart';
import 'package:infomovis/screens/home.dart';
import 'package:infomovis/screens/home_screen.dart';
import 'package:infomovis/screens/search_screen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        final argument = settings.arguments;
        final widget = switch (settings.name ?? "") {
          '/' => Home(),
          '/home' => HomeScreen(),
          '/favori' => FavoriScreen(),
          '/detail' => DetailScreen(movieId: argument as int),
          '/search' => SearchScreen(),
          _ => Home(),
        };
        return MaterialPageRoute(builder: (context) => widget);
      },
    );
  }
}
