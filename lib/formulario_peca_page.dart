import 'package:flutter/material.dart';
import 'models/peca.dart';

class FormularioPecaPage extends StatefulWidget {
  final Function(Peca) adicionarPeca;

  const FormularioPecaPage({super.key, required this.adicionarPeca});

  @override
  _FormularioPecaPageState createState() => _FormularioPecaPageState();
}

class _FormularioPecaPageState extends State<FormularioPecaPage> {
  final _formKey = GlobalKey<FormState>();
  String? _nome;
  double? _preco;
  CategoriaPeca? _categoriaSelecionada;
  final List<CategoriaPeca> _categorias = [
    CategoriaPeca(id: 1, nome: 'Eletrônica'),
    CategoriaPeca(id: 2, nome: 'Mecânica'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Peça'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nome da Peça'),
              onSaved: (value) => _nome = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o nome da peça';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Preço'),
              keyboardType: TextInputType.number,
              onSaved: (value) => _preco = double.tryParse(value ?? '0'),
              validator: (value) {
                if (value == null || value.isEmpty || double.tryParse(value) == null) {
                  return 'Por favor, insira um preço válido';
                }
                return null;
              },
            ),
            DropdownButtonFormField<CategoriaPeca>(
              value: _categoriaSelecionada,
              decoration: const InputDecoration(labelText: 'Categoria'),
              items: _categorias.map((categoria) {
                return DropdownMenuItem(
                  value: categoria,
                  child: Text(categoria.nome),
                );
              }).toList(),
              onChanged: (value) => setState(() => _categoriaSelecionada = value),
              validator: (value) {
                if (value == null) {
                  return 'Por favor, selecione uma categoria';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  // Criar a peça e adicionar
                  Peca novaPeca = Peca(
                    id: DateTime.now().millisecondsSinceEpoch,
                    nome: _nome!,
                    preco: _preco!,
                    categoria: _categoriaSelecionada!,
                  );

                  // Adiciona a peça
                  widget.adicionarPeca(novaPeca);
                  
                  // Volta para a lista
                  Navigator.pop(context);
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
