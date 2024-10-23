import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'models/peca.dart';
import 'screens/lista_peca_page.dart';
import 'screens/formulario_peca_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();

  @override
  Widget biuld(BuildContext context) {
    return MaterialApp(
      title: 'App Peças'
      theme: ThemeData(
        Colors.blue,
      ),
      home: const HomePage(),
        routes: {
          '/lista': (context) => const PecaListScreen(),
        '/formulario': (context) => const FormularioPecaPage(adicionarPeca: null), 
        },
    );
  }
}