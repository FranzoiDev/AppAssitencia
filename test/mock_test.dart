import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:app_peca/models/peca.dart';
import 'package:app_peca/services/peca_api.dart';
import 'mock_test.mocks.dart';

@GenerateMocks([PecaApi])
void main() {
  group('PecaListScreen Tests', () {
    late MockPecaApi mockApi;

    setUp(() {
      mockApi = MockPecaApi();
    });

    test('Deve retornar uma lista vazia quando não há peças disponíveis', () async {
      when(mockApi.getAll()).thenAnswer((_) async => []);

      final pecas = await mockApi.getAll();

      expect(pecas.isEmpty, isTrue);
    });

    test('Deve adicionar uma nova peça usando o método create', () async {
      final novaPeca = Peca(id: 3, nome: 'Peça C', preco: 150.0);
      when(mockApi.create(any)).thenAnswer((_) async => novaPeca);

      final pecaCriada = await mockApi.create(novaPeca);

      expect(pecaCriada.nome, 'Peça C');
      expect(pecaCriada.preco, 150.0);
    });

    test('Deve filtrar peças com preço acima de 200.0', () async {
      final pecas = [
        Peca(id: 1, nome: 'Peça A', preco: 150.0),
        Peca(id: 2, nome: 'Peça B', preco: 300.0),
      ];
      when(mockApi.getAll()).thenAnswer((_) async => pecas);

      final pecasFiltradas = (await mockApi.getAll()).where((peca) => peca.preco > 200.0).toList();

      expect(pecasFiltradas.length, 1);
      expect(pecasFiltradas[0].nome, 'Peça B');
    });
  });
}