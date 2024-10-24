import 'package:flutter/material.dart';
import '../models/peca.dart';
import '../services/peca_api.dart';

class FormularioPecaPage extends StatefulWidget {
  final Peca? peca;

  const FormularioPecaPage({Key? key, this.peca}) : super(key: key);

  @override
  _FormularioPecaPageState createState() => _FormularioPecaPageState();
}

class _FormularioPecaPageState extends State<FormularioPecaPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final PecaApi api = PecaApi();

  @override
  void initState() {
    super.initState();
    _nomeController.text = widget.peca?.nome ?? '';
    _precoController.text = widget.peca?.preco?.toString() ?? '';
  }

  void _limparCampos() {
    _nomeController.clear();
    _precoController.clear();
  }

  @override
  void dispose() {

    _nomeController.dispose();
    _precoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.peca == null ? 'Criar Peça' : 'Editar Peça'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Campo para nome
              TextFormField(
                controller: _nomeController,  
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              // Campo para preço
              TextFormField(
                controller: _precoController,  
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
              ),

              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    
                    String nome = _nomeController.text;
                    double preco = double.parse(_precoController.text);

                    Peca novaPeca = Peca(nome: nome, preco: preco);
                    
                    try {
                      if (widget.peca == null) {
                        await api.create(novaPeca);  

                        _limparCampos();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Produto criado com sucesso')),
                        );
                      } else {
                        await api.update(widget.peca!.id!, novaPeca);  

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Produto atualizado com sucesso')),
                        );
                      }
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Erro ao salvar produto: $error')),
                      );
                    }
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
