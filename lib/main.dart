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
      home: const HomePage(), 
      routes: {
        '/lista': (context) => ListaPecaPage(pecas: pecas), 
        '/formulario': (context) => FormularioPecaPage(adicionarPeca: adicionarPeca), 
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
