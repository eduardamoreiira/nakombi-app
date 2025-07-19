// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:nacombi/clientes/models/cliente.dart';
import 'package:nacombi/vendas/models/item_venda.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:nacombi/clientes/models/cliente.dart';

class Venda {
  String? id;
  Cliente? cliente;
  DateTime? data;
  String? observacao;
  List<ItemVenda>? items;
  double? total;
  Venda({
    this.id,
    this.cliente,
    this.data,
    this.observacao,
    this.items,
    this.total,
  });

  Venda copyWith({
    String? id,
    Cliente? cliente,
    DateTime? data,
    String? observacao,
    List<ItemVenda>? items,
    double? total,
  }) {
    return Venda(
      id: id ?? this.id,
      cliente: cliente ?? this.cliente,
      data: data ?? this.data,
      observacao: observacao ?? this.observacao,
      items: items ?? this.items,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (cliente != null) {
      result.addAll({'cliente': cliente!.toMap()});
    }
    if (data != null) {
      result.addAll({'data': data!.millisecondsSinceEpoch});
    }
    if (observacao != null) {
      result.addAll({'observacao': observacao});
    }
    if (items != null) {
      result.addAll({'items': items!.map((x) => x?.toMap()).toList()});
    }
    if (total != null) {
      result.addAll({'total': total});
    }

    return result;
  }

  Map<String, dynamic> toMapItems() {
    return <String, dynamic>{
      'id': id,
      'cliente': cliente?.toMap(),
      'data': data?.millisecondsSinceEpoch,
      'observacao': observacao,
      'total': total,
      'items': items!.map((x) => x.toMap()).toList(),
    };
  }

  factory Venda.fromMap(Map<String, dynamic> map) {
    return Venda(
      id: map['id'],
      cliente: map['cliente'] != null ? Cliente.fromMap(map['cliente']) : null,
      data:
          map['data'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['data'])
              : null,
      observacao: map['observacao'],
      items:
          map['items'] != null
              ? List<ItemVenda>.from(
                map['items']?.map((x) => ItemVenda.fromMap(x)),
              )
              : null,
      total: map['total']?.toDouble(),
    );
  }
  Venda.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    cliente = Cliente.fromMap(doc.get('cliente') as Map<String, dynamic>);
    data = DateTime.fromMillisecondsSinceEpoch(doc.get('data') as int);
    observacao = doc.get('observacao');
    total = doc.get('total')?.toDouble();
  }

  String toJson() => json.encode(toMap());

  factory Venda.fromJson(String source) => Venda.fromMap(json.decode(source));

  Venda.fromJson2(Map<String, dynamic> json)
    : id = json['id'],
      cliente = json['cliente'],
      data = json['data'],
      observacao = json['observacao'];

  @override
  String toString() {
    return 'Venda(id: $id, cliente: $cliente, data: $data, observacao: $observacao, items: $items, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Venda &&
        other.id == id &&
        other.cliente == cliente &&
        other.data == data &&
        other.observacao == observacao &&
        listEquals(other.items, items) &&
        other.total == total;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        cliente.hashCode ^
        data.hashCode ^
        observacao.hashCode ^
        items.hashCode ^
        total.hashCode;
  }
}
