import 'package:flutter/material.dart';
import '../models/peca.dart';

class FormularioPecaPage extends StatefulWidget {
  final Function(Peca) adicionarPeca; // Função callback para adicionar peça
  final Peca? peca; // Objeto peça que será editado (pode ser nulo para criação)

  // Super.key foi adicionado para seguir as boas práticas
  const FormularioPecaPage({required this.adicionarPeca, this.peca, Key? key}) : super(key: key);

  @override
  _FormularioPecaPageState createState() => _FormularioPecaPageState();
}

class _FormularioPecaPageState extends State<FormularioPecaPage> {
  final _formKey = GlobalKey<FormState>();
  late String _nome; // Variável para armazenar o nome da peça
  late double _preco; // Variável para armazenar o preço da peça

  @override
  void initState() {
    super.initState();
    // Inicializa os campos com os valores da peça, se estiver editando
    _nome = widget.peca?.nome ?? '';
    _preco = widget.peca?.preco ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.peca == null ? 'Nova Peça' : 'Editar Peça'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Campo para o nome da peça
              TextFormField(
                initialValue: _nome,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nome = value!;
                },
              ),
              // Campo para o preço da peça
              TextFormField(
                initialValue: _preco != 0 ? _preco.toString() : '',
                decoration: const InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o preço';
                  }
                  try {
                    double.parse(value);
                  } catch (e) {
                    return 'Insira um valor numérico válido';
                  }
                  return null;
                },
                onSaved: (value) {
                  _preco = double.parse(value!);
                },
              ),
              // Botão de submissão
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    // Cria uma nova peça com os dados inseridos
                    Peca novaPeca = Peca(nome: _nome, preco: _preco);
                    
                    // Chama a função de callback para adicionar ou editar a peça
                    widget.adicionarPeca(novaPeca);

                    Navigator.pop(context); // Fecha a tela ao salvar
                  }
                },
                child: Text(widget.peca == null ? 'Criar' : 'Atualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
