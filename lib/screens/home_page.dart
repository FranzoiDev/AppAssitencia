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
                color: Colors.deepPurpleAccent,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              title: const Text('Lista de Peças'),
              onTap: () {
                Navigator.pushNamed(context, '/lista'); 
              },
            ),
                        ListTile(
              title: const Text('Sua loja'),
              onTap: () {
                Navigator.pushNamed(context, '/maps'); 
              },
            ),
            ListTile(
              title: const Text('Adicionar Peça'),
              onTap: () {
                Navigator.pushNamed(context, '/formulario');
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
