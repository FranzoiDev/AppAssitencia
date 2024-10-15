class Peca {
  int? id;
  String nome;
  double preco;

  Peca({this.id, required this.nome, required this.preco});

  factory Peca.fromJson(Map<String, dynamic> json) {
    return Peca(
      id: json['id'],
      nome: json['nome'],
      preco: json['preco'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'preco': preco,
    };
  }
}
