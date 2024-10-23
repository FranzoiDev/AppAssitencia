import 'package:flutter/material.dart';
import '../models/peca.dart';
import '../services/peca_api.dart';

class FormularioPecaPage extends StatefulWidget {
  final Peca? peca;

  const FormularioPecaPage({this.peca, Key? key}) : super(key: key);

  @override
  _FormularioPecaPageState createState() => _FormularioPecaPageState();
}

class _FormularioPecaPageState extends State<FormularioPecaPage> {
  final _formKey = GlobalKey<FormState>();
  late String _nome;
  late double _preco;
  final PecaApi api = PecaApi();

  @override
  void initState() {
    super.initState();
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
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    Peca novaPeca = Peca(nome: _nome, preco: _preco);
                    if (widget.peca == null) {
                      await api.create(novaPeca);
                    } else {
                      await api.update(widget.peca!.id!, novaPeca); 
                    }

                    Navigator.pop(context, novaPeca); 
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
