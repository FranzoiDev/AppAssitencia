import 'package:flutter/material.dart';
import '../models/peca.dart';
import '../services/peca_api.dart';
import 'formulario_peca_page.dart';

class PecaListScreen extends StatefulWidget {
  const PecaListScreen({super.key});

  @override
  PecaListScreenState createState() => PecaListScreenState();
}

class PecaListScreenState extends State<PecaListScreen> {
  final PecaApi api = PecaApi();
  List<Peca> pecas = [];

  @override
  void initState() {
    super.initState();
    carregarPecas();
  }

  void carregarPecas() async {
    try {
      List<Peca> pecasApi = await api.getAll();
      setState(() {
        pecas = pecasApi;
      });
    } catch (error) {
      showErrorDialog(error.toString());
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Erro"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Peças'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              Peca? novaPeca = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FormularioPecaPage(),
                ),
              );
              if (novaPeca != null) {
                carregarPecas(); 
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),  
            onPressed: () {
              carregarPecas();  
            },
          ),
        ],
      ),
      body: pecas.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: pecas.length,
              itemBuilder: (context, index) {
                final peca = pecas[index];
                return ListTile(
                  title: Text(peca.nome),
                  subtitle: Text('Preço: ${peca.preco}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          Peca? pecaEditada = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FormularioPecaPage(peca: peca),
                            ),
                          );
                          if (pecaEditada != null) {
                            carregarPecas(); 
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await api.delete(peca.id!); 
                          carregarPecas(); 
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
