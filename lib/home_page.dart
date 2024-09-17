import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peças para Assistência Técnica'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Lista de Peças'),
              onTap: () {
                Navigator.pushNamed(context, '/lista'); // Navegar para a tela de lista
              },
            ),
            ListTile(
              title: Text('Adicionar Peça'),
              onTap: () {
                Navigator.pushNamed(context, '/formulario'); // Navegar para a tela de formulário
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Bem-vindo ao app de Peças!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
