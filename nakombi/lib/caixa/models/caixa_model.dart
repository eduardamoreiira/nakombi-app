// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CaixaModel {
  String? id;
  DateTime? dataCriacao;
  String? local;
  double? totalVendas;
  CaixaModel({this.id, this.dataCriacao, this.local, this.totalVendas});

  CaixaModel copyWith({
    String? id,
    DateTime? dataCriacao,
    String? local,
    double? totalVendas,
  }) {
    return CaixaModel(
      id: id ?? this.id,
      dataCriacao: dataCriacao ?? this.dataCriacao,
      local: local ?? this.local,
      totalVendas: totalVendas ?? this.totalVendas,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'dataCriacao': dataCriacao?.millisecondsSinceEpoch,
      'local': local,
      'totalVendas': totalVendas,
    };
  }

  factory CaixaModel.fromMap(Map<String, dynamic> map) {
    return CaixaModel(
      id: map['id'] != null ? map['id'] as String : null,
      dataCriacao:
          map['dataCriacao'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['dataCriacao'] as int)
              : null,
      local: map['local'] != null ? map['local'] as String : null,
      totalVendas:
          map['totalVendas'] != null ? map['totalVendas'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CaixaModel.fromJson(String source) =>
      CaixaModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CaixaModel(id: $id, dataCriacao: $dataCriacao, local: $local, totalVendas: $totalVendas)';
  }

  @override
  bool operator ==(covariant CaixaModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.dataCriacao == dataCriacao &&
        other.local == local &&
        other.totalVendas == totalVendas;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        dataCriacao.hashCode ^
        local.hashCode ^
        totalVendas.hashCode;
  }
}
