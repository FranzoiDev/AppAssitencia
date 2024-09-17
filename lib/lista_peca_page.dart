import 'package:flutter/material.dart';
import 'models/peca.dart';

class ListaPecaPage extends StatelessWidget {
  final List<Peca> pecas;

  const ListaPecaPage({super.key, required this.pecas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Peças'),
      ),
      body: pecas.isEmpty
          ? const Center(child: Text('Nenhuma peça cadastrada'))
          : ListView.builder(
              itemCount: pecas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(pecas[index].nome),
                  subtitle: Text('Categoria: ${pecas[index].categoria.nome}'),
                  trailing: Text('R\$ ${pecas[index].preco.toStringAsFixed(2)}'),
                );
              },
            ),
    );
  }
}
