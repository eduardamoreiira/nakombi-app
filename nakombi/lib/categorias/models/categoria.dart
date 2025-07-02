// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Categoria {
  String? id;
  String? nome;
  String? descricao;
  String? imagem;

  // Construtor da classe Categoria
  // O construtor é responsável por inicializar os atributos da classe
  Categoria({this.id, this.nome, this.descricao, this.imagem});

  // Método copyWith: cria uma cópia do objeto Categoria com novos valores
  // Esse método é útil para criar uma nova instância da classe com alguns atributos alterados
  Categoria copyWith({String? nome, String? descricao}) {
    return Categoria(
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      id: 'id',
      imagem: 'imagem',
    );
  }

  // Método toMap: converte o objeto Categoria em um mapa (Map)
  // Esse método é útil para enviar os dados para um banco de dados ou API
  Map<String, dynamic> toMap() {
    return <String, dynamic>{'nome': nome, 'descricao': descricao};
  }

  factory Categoria.fromMap(Map<String, dynamic> map) {
    return Categoria(
      nome: map['nome'] as String,
      descricao: map['descricao'] as String,
      id: 'id',
      imagem: 'imagem',
    );
  }

  String toJson() => json.encode(toMap());

  factory Categoria.fromJson(String source) =>
      Categoria.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Categoria(nome: $nome, descricao: $descricao)';

  @override
  bool operator ==(covariant Categoria other) {
    if (identical(this, other)) return true;

    return other.nome == nome && other.descricao == descricao;
  }

  @override
  int get hashCode => nome.hashCode ^ descricao.hashCode;
}
