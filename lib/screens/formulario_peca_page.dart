import 'package:flutter/material.dart';
import '../models/peca.dart';
import '../services/peca_api.dart';

class PecaFormScreen extends StatefulWidget {
  final Peca? peca;

  PecaFormScreen({this.peca});

  @override
  _PecaFormScreenState createState() => _PecaFormScreenState();
}

class _PecaFormScreenState extends State<PecaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _nome;
  late double _preco;
  final PecaApi api = PecaApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.peca == null ? 'Nova Peça' : 'Editar Peça'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.peca?.nome ?? '',
                decoration: InputDecoration(labelText: 'Nome'),
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
              TextFormField(
                initialValue: widget.peca?.preco.toString() ?? '',
                decoration: InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o preço';
                  }
                  return null;
                },
                onSaved: (value) {
                  _preco = double.parse(value!);
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (widget.peca == null) {
                      api.create(Peca(nome: _nome, preco: _preco)).then((_) {
                        Navigator.pop(context);
                      });
                    } else {
                      api.update(widget.peca!.id!, Peca(nome: _nome, preco: _preco)).then((_) {
                        Navigator.pop(context);
                      });
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
