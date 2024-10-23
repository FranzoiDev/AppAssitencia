import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/peca.dart';
import 'crud_api.dart';

class PecaApi extends CrudApi<Peca> {
  bool _apiUrlInitialized = false;  

  PecaApi() : super("") {
    _initApiUrl();  
  }

  Future<void> _initApiUrl() async {
    if (_apiUrlInitialized) return;  
    try {

      final response = await http.get(Uri.parse('http://localhost:3000/getPort'));
     
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final port = data['port'];
        apiUrl = 'http://localhost:$port/pecas'; 
        _apiUrlInitialized = true; 
      } else {
        throw Exception('Erro ao obter a porta');
      }
    } catch (e) {
      throw Exception('Erro ao ler a porta: $e');
    }
  }

  @override
  Future<List<Peca>> getAll() async {
    await _initApiUrl();  
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
    await _initApiUrl();
    final response = await http.get(Uri.parse('$apiUrl/$id'));
    if (response.statusCode == 200) {
      return Peca.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao carregar a peça');
    }
  }

  @override
  Future<Peca> create(Peca item) async {
    await _initApiUrl();
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
    await _initApiUrl();
    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),);
    if (response.statusCode == 200) {
      return Peca.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao atualizar a peça');
    }
  }

  @override
  Future<void> delete(int id) async {
    await _initApiUrl();
    final response = await http.delete(Uri.parse('$apiUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar a peça');
    }
  }
}
