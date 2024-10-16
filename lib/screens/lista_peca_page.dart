import 'package:flutter/material.dart';
import '../models/peca.dart';
import '../services/peca_api.dart';
import 'formulario_peca_page.dart';

class PecaListScreen extends StatelessWidget {
  final PecaApi api = PecaApi();
  final Function(Peca) adicionarPeca;  

  PecaListScreen({Key? key, required this.adicionarPeca}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Peças'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FormularioPecaPage(adicionarPeca: adicionarPeca),  
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Peca>>(
        future: api.getAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Erro: ${snapshot.error}');
          } else {
            final pecas = snapshot.data!;
            return ListView.builder(
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FormularioPecaPage(
                                adicionarPeca: adicionarPeca,  
                                peca: peca,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          api.delete(peca.id!).then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Peça deletada com sucesso!'),
                              ),
                            );
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
