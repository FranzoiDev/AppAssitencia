import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peças para Assistência Técnica'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              title: const Text('Lista de Peças'),
              onTap: () {
                Navigator.pushNamed(context, '/lista'); // Navega para a tela de lista
              },
            ),
            ListTile(
              title: const Text('Adicionar Peça'),
              onTap: () {
                Navigator.pushNamed(context, '/formulario'); // Navega para a tela de formulário
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text(
          'Bem-vindo ao app de Peças!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
