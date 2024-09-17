import 'package:flutter/material.dart';
import 'home_page.dart';
import 'lista_peca_page.dart';
import 'formulario_peca_page.dart';
import 'models/peca.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Lista de peças
  List<Peca> pecas = [];

  // Função para adicionar uma peça
  void adicionarPeca(Peca peca) {
    setState(() {
      pecas.add(peca);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Peças',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(), // Página inicial
      routes: {
        '/lista': (context) => ListaPecaPage(pecas: pecas),
        '/formulario': (context) => FormularioPecaPage(adicionarPeca: adicionarPeca),
      },
    );
  }
}
