// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProdutoModel {
  String? id;
  String? nome;
  String? descricao;
  String? marca;
  double? preco;
  int? estoque;
  String? idCategoria;

  ProdutoModel({
    this.id,
    this.nome,
    this.descricao,
    this.marca,
    this.preco,
    this.estoque,
  });

  ProdutoModel copyWith({
    String? id,
    String? nome,
    String? descricao,
    String? marca,
    double? preco,
    int? estoque,
  }) {
    return ProdutoModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      marca: marca ?? this.marca,
      preco: preco ?? this.preco,
      estoque: estoque ?? this.estoque,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'marca': marca,
      'preco': preco,
      'estoque': estoque,
    };
  }

  factory ProdutoModel.fromMap(Map<String, dynamic> map) {
    return ProdutoModel(
      id: map['id'] != null ? map['id'] as String : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
      marca: map['marca'] != null ? map['marca'] as String : null,
      preco:
          map['preco'] != null
              ? (map['preco'] is int
                  ? (map['preco'] as int).toDouble()
                  : map['preco'] as double)
              : null,
      estoque: map['estoque'] != null ? map['estoque'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProdutoModel.fromJson(String source) =>
      ProdutoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProdutoModel(id: $id, nome: $nome, descricao: $descricao, marca: $marca, preco: $preco, estoque: $estoque)';
  }

  @override
  bool operator ==(covariant ProdutoModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nome == nome &&
        other.descricao == descricao &&
        other.marca == marca &&
        other.preco == preco &&
        other.estoque == estoque;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nome.hashCode ^
        descricao.hashCode ^
        marca.hashCode ^
        preco.hashCode ^
        estoque.hashCode;
  }
}

extension on String? {
  toMap() {
    return this != null ? json.decode(this!) as Map<String, dynamic> : null;
  }
}
