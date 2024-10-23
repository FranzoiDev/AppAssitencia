import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/lista_peca_page.dart';
import 'screens/formulario_peca_page.dart';
import 'models/peca.dart';

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
      onGenerateRoute: (settings) {
        if (settings.name == '/formulario') {
          final peca = settings.arguments as Peca?;
          return MaterialPageRoute(
            builder: (context) => FormularioPecaPage(peca: peca),
          );
        }
        return null;
      },
      routes: {
        '/lista': (context) => const PecaListScreen(),
      },
    );
  }
}
