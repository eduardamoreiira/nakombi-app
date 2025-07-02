// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:nacombi/clientes/models/cliente_model.dart';
import 'package:nacombi/vendas/models/item_venda_model.dart';

class VendaModel {
  String? id; //sequencia numerica não do firebase
  ClienteModel? cliente;
  DateTime? dataVenda;
  String? observacao;
  List<ItemVendaModel>? itensVenda;
  VendaModel({
    this.id,
    this.cliente,
    this.dataVenda,
    this.observacao,
    this.itensVenda,
  });

  VendaModel copyWith({
    String? id,
    ClienteModel? cliente,
    DateTime? dataVenda,
    String? observacao,
    List<ItemVendaModel>? itensVenda,
  }) {
    return VendaModel(
      id: id ?? this.id,
      cliente: cliente ?? this.cliente,
      dataVenda: dataVenda ?? this.dataVenda,
      observacao: observacao ?? this.observacao,
      itensVenda: itensVenda ?? this.itensVenda,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cliente': cliente?.toMap(),
      'dataVenda': dataVenda?.millisecondsSinceEpoch,
      'observacao': observacao,
      'itensVenda': itensVenda!.map((x) => x?.toMap()).toList(),
    };
  }

  factory VendaModel.fromMap(Map<String, dynamic> map) {
    return VendaModel(
      id: map['id'] != null ? map['id'] as String : null,
      cliente:
          map['cliente'] != null
              ? ClienteModel.fromMap(map['cliente'] as Map<String, dynamic>)
              : null,
      dataVenda:
          map['dataVenda'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['dataVenda'] as int)
              : null,
      observacao:
          map['observacao'] != null ? map['observacao'] as String : null,
      itensVenda:
          map['itensVenda'] != null
              ? List<ItemVendaModel>.from(
                (map['itensVenda'] as List<int>).map<ItemVendaModel?>(
                  (x) => ItemVendaModel.fromMap(x as Map<String, dynamic>),
                ),
              )
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VendaModel.fromJson(String source) =>
      VendaModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VendaModel(id: $id, cliente: $cliente, dataVenda: $dataVenda, observacao: $observacao, itensVenda: $itensVenda)';
  }

  @override
  bool operator ==(covariant VendaModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.cliente == cliente &&
        other.dataVenda == dataVenda &&
        other.observacao == observacao &&
        listEquals(other.itensVenda, itensVenda);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        cliente.hashCode ^
        dataVenda.hashCode ^
        observacao.hashCode ^
        itensVenda.hashCode;
  }
}
