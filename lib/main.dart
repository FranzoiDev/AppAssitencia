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
}

class _MyAppState extends State<MyApp> {
  List<Peca> pecas = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Peças',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        '/lista': (context) => PecaListScreen(), 
        '/formulario': (context) => FormularioPecaPage(adicionarPeca: (peca) {
              setState(() {
                pecas.add(peca);
              });
            }),
      },
    );
  }
}
