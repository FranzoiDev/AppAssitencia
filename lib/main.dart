import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/lista_peca_page.dart';
import 'screens/formulario_peca_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Peças',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        '/lista': (context) => const PecaListScreen(), 
        '/formulario': (context) => const FormularioPecaPage(),
      },
    );
  }
}
