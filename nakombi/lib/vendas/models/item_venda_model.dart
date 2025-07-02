// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:nacombi/produtos/models/produto_model.dart';

class ItemVendaModel {
  String? id; //sequencia numerica não do firebase
  int? quantidade;
  double? subTotal;
  double? preco;
  ProdutoModel? produto;

  ItemVendaModel({
    this.id,
    this.quantidade,
    this.subTotal,
    this.preco,
    this.produto,
  }) {
    subTotal = preco! + quantidade!;
  }

  ItemVendaModel copyWith({
    String? id,
    int? quantidade,
    double? subTotal,
    double? preco,
    ProdutoModel? produto,
  }) {
    return ItemVendaModel(
      id: id ?? this.id,
      quantidade: quantidade ?? this.quantidade,
      subTotal: subTotal ?? this.subTotal,
      preco: preco ?? this.preco,
      produto: produto ?? this.produto,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'quantidade': quantidade,
      'subTotal': subTotal,
      'preco': preco,
      'produto': produto?.toMap(),
    };
  }

  factory ItemVendaModel.fromMap(Map<String, dynamic> map) {
    return ItemVendaModel(
      id: map['id'] != null ? map['id'] as String : null,
      quantidade: map['quantidade'] != null ? map['quantidade'] as int : null,
      subTotal:
          map['subTotal'] != null ? (map['subTotal'] as num).toDouble() : null,
      preco: map['preco'] != null ? (map['preco'] as num).toDouble() : null,
      produto:
          map['produto'] != null
              ? ProdutoModel.fromMap(map['produto'] as Map<String, dynamic>)
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemVendaModel.fromJson(String source) =>
      ItemVendaModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ItemVendaModel(id: $id, quantidade: $quantidade, subTotal: $subTotal, preco: $preco, produto: $produto)';
  }

  @override
  bool operator ==(covariant ItemVendaModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.quantidade == quantidade &&
        other.subTotal == subTotal &&
        other.preco == preco &&
        other.produto == produto;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        quantidade.hashCode ^
        subTotal.hashCode ^
        preco.hashCode ^
        produto.hashCode;
  }
}
extension on double? {
  toMap() {}
}

extension on String? {
  toMap() {}
}

extension on int? {
  toMap() {
    return this != null ? this : 0;
  }
}
