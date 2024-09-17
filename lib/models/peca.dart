class Peca {
  final int id;
  final String nome;
  final double preco;
  final CategoriaPeca categoria;

  Peca({required this.id, required this.nome, required this.preco, required this.categoria});
}

class CategoriaPeca {
  final  int id;
  final String nome;

  CategoriaPeca({required this.id, required this.nome});
}