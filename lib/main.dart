import 'package:flutter/material.dart';
import 'package:uts_mobile/models/matakuliah.dart';
import 'package:uts_mobile/screens/matakuliah_form_screen.dart';
import 'package:uts_mobile/screens/matakuliah_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const red = Color(0xFFC62828);
    const yellow = Color(0xFFFFD54F);
    const blue = Color(0xFF1565C0);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Data Matakuliah',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: blue,
          primary: blue,
          secondary: yellow,
          tertiary: red,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F9FC),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: blue, width: 2),
          ),
        ),
      ),
      initialRoute: '/home',
      routes: {'/home': (_) => const MatakuliahListScreen()},
      onGenerateRoute: (settings) {
        if (settings.name == '/form') {
          final matakuliah = settings.arguments as Matakuliah?;
          return MaterialPageRoute(
            builder: (_) => MatakuliahFormScreen(matakuliah: matakuliah),
          );
        }
        return null;
      },
    );
  }
}
