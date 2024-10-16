import 'package:flutter/material.dart';
import '../models/peca.dart';
import '../services/peca_api.dart';
import 'formulario_peca_page.dart';

class PecaListScreen extends StatefulWidget {
  const PecaListScreen({Key? key}) : super(key: key);

  @override
  _PecaListScreenState createState() => _PecaListScreenState();
}

class _PecaListScreenState extends State<PecaListScreen> {
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

  void adicionarPeca(Peca peca) {
    setState(() {
      pecas.add(peca);
    });
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
                  builder: (context) =>
                      FormularioPecaPage(adicionarPeca: adicionarPeca),
                ),
              );
              if (novaPeca != null) {
                adicionarPeca(novaPeca);
              }
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
                              builder: (context) => FormularioPecaPage(
                                adicionarPeca: (pecaEditada) {
                                  setState(() {
                                    pecas[index] = pecaEditada;
                                  });
                                },
                                peca: peca,
                              ),
                            ),
                          );
                          if (pecaEditada != null) {
                            setState(() {
                              pecas[index] = pecaEditada;
                            });
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          try {
                            await api.delete(peca.id!);
                            setState(() {
                              pecas.removeAt(index);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Peça deletada com sucesso!'),
                              ),
                            );
                          } catch (error) {
                            showErrorDialog(error.toString());
                          }
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
