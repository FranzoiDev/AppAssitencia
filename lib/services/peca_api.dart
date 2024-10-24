import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/peca.dart';
import 'crud_api.dart';

class PecaApi extends CrudApi<Peca> {
  final String apiUrl = 'http://localhost:3500/pecas';  

  PecaApi() : super('http://localhost:3500/pecas'); 

  @override
  Future<List<Peca>> getAll() async {
    
    final response = await http.get(Uri.parse(apiUrl)); 
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Peca.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar as peças');
    }
  }

  @override
  Future<Peca> getById(int id) async {
    
    final response = await http.get(Uri.parse('$apiUrl/$id')); 
    if (response.statusCode == 200) {
      return Peca.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao carregar a peça');
    }
  }

  @override
  Future<Peca> create(Peca item) async {
    
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );
    if (response.statusCode == 201) {
      return Peca.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao criar a peça');
    }
  }

  @override
  Future<Peca> update(int id, Peca item) async {
   
    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );
    if (response.statusCode == 200) {
      return Peca.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao atualizar a peça');
    }
  }

  @override
  Future<void> delete(int id) async {
    
    final response = await http.delete(Uri.parse('$apiUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar a peça');
    }
  }
}
