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
      home: const HomePage(), // Página inicial (use const)
      routes: {
        '/lista': (context) => ListaPecaPage(pecas: pecas), // Passe a lista de peças
        '/formulario': (context) => FormularioPecaPage(adicionarPeca: adicionarPeca), // Função para adicionar peças
      },
    );
  }
}


class ListaPecaPage extends StatelessWidget {
  final List<Peca> pecas;

  const ListaPecaPage({Key? key, required this.pecas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Peças')),
      body: ListView.builder(
        itemCount: pecas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(pecas[index].nome),
            subtitle: Text('Preço: ${pecas[index].preco}'),
          );
        },
      ),
    );
  }
}
