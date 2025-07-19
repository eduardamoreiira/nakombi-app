// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Produto {
  String? id;
  String? nome;
  String? descricao;
  String? marca;
  double? preco;
  int? estoque;
  String? idCategoria;
  String? imagem;

  Produto({
    this.id,
    this.nome,
    this.descricao,
    this.marca,
    this.preco,
    this.estoque,
    this.idCategoria,
    this.imagem,
  });

  Produto copyWith({
    String? id,
    String? nome,
    String? descricao,
    String? marca,
    double? preco,
    int? estoque,
    String? idCategoria,
    String? imagem,
  }) {
    return Produto(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      marca: marca ?? this.marca,
      preco: preco ?? this.preco,
      estoque: estoque ?? this.estoque,
      idCategoria: idCategoria ?? this.idCategoria,
      imagem: imagem ?? this.imagem,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (nome != null) {
      result.addAll({'nome': nome});
    }
    if (descricao != null) {
      result.addAll({'descricao': descricao});
    }
    if (marca != null) {
      result.addAll({'marca': marca});
    }
    if (preco != null) {
      result.addAll({'preco': preco});
    }
    if (estoque != null) {
      result.addAll({'estoque': estoque});
    }
    if (idCategoria != null) {
      result.addAll({'idCategoria': idCategoria});
    }
    if (imagem != null) {
      result.addAll({'imagem': imagem});
    }

    return result;
  }

  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
      id: map['id'],
      nome: map['nome'],
      descricao: map['descricao'],
      marca: map['marca'],
      preco: map['preco']?.toDouble(),
      estoque: map['estoque']?.toInt(),
      idCategoria: map['idCategoria'],
      imagem: map['imagem'],
    );
  }

  //método construtor para salvar os dados do documento firebase
  Produto.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    nome = doc.get('nome');
    descricao = doc.get('descricao');
    marca = doc.get('marca');
    estoque = doc.get('estoque') as int;
    preco = doc.get('preco') as double;
    idCategoria = doc.get('idCategoria') as String;
    imagem = doc.get('imagem');
  }

  Produto.fromSnapshot(DocumentSnapshot doc)
    : id = doc.id,
      nome = doc.get('nome'),
      descricao = doc.get('descricao'),
      marca = doc.get('marca'),
      estoque = doc.get('estoque') as int,
      preco = doc.get('preco') as double,
      idCategoria = doc.get('idCategoria') as String,
      imagem = doc.get('imagem');

  String toJson() => json.encode(toMap());

  factory Produto.fromJson(String source) =>
      Produto.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Produto(id: $id, nome: $nome, descricao: $descricao, marca: $marca, preco: $preco, estoque: $estoque, idCategoria: $idCategoria, imagem: $imagem)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Produto &&
        other.id == id &&
        other.nome == nome &&
        other.descricao == descricao &&
        other.marca == marca &&
        other.preco == preco &&
        other.estoque == estoque &&
        other.idCategoria == idCategoria &&
        other.imagem == imagem;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nome.hashCode ^
        descricao.hashCode ^
        marca.hashCode ^
        preco.hashCode ^
        estoque.hashCode ^
        idCategoria.hashCode ^
        imagem.hashCode;
  }
}
