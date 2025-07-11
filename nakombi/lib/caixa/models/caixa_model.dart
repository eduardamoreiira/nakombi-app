// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class CaixaModel {
  String? id;
  DateTime? dataEvento;
  TimeOfDay? horaEvento;
  String? local;
  double? totalVendas;
  CaixaModel({
    this.id,
    this.dataEvento,
    this.horaEvento,
    this.local,
    this.totalVendas,
  });

  CaixaModel copyWith({
    String? id,
    DateTime? dataEvento,
    TimeOfDay? horaEvento,
    String? local,
    double? totalVendas,
  }) {
    return CaixaModel(
      id: id ?? this.id,
      dataEvento: dataEvento ?? this.dataEvento,
      horaEvento: horaEvento ?? this.horaEvento,
      local: local ?? this.local,
      totalVendas: totalVendas ?? this.totalVendas,
    );
  }

  /*Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'dataEvento': dataEvento?.millisecondsSinceEpoch,
      'horaEvento': horaEvento?.toMap(),
      'local': local,
      'totalVendas': totalVendas,
    };
  }*/

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'dataEvento': dataEvento?.millisecondsSinceEpoch,
      'horaEvento': horaEvento?.toMap(),
      'local': local,
      'totalVendas': totalVendas,
    };
  }

  factory CaixaModel.fromMap(Map<String, dynamic> map) {
    return CaixaModel(
      id: map['id'] != null ? map['id'] as String : null,
      dataEvento:
          map['dataEvento'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['dataEvento'] as int)
              : null,
      horaEvento:
          map['horaEvento'] != null
              ? TimeOfDayFromMapExtension.fromMap(
                map['horaEvento'] as Map<String, dynamic>,
              )
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
    return 'CaixaModel(id: $id, dataEvento: $dataEvento, horaEvento: $horaEvento, local: $local, totalVendas: $totalVendas)';
  }

  @override
  bool operator ==(covariant CaixaModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.dataEvento == dataEvento &&
        other.horaEvento == horaEvento &&
        other.local == local &&
        other.totalVendas == totalVendas;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        dataEvento.hashCode ^
        horaEvento.hashCode ^
        local.hashCode ^
        totalVendas.hashCode;
  }
}

extension TimeOfDayMapExtension on TimeOfDay? {
  Map<String, dynamic>? toMap() {
    if (this == null) return null;
    return {'hour': this!.hour, 'minute': this!.minute};
  }
}

extension TimeOfDayFromMapExtension on TimeOfDay {
  static TimeOfDay fromMap(Map<String, dynamic> map) {
    return TimeOfDay(hour: map['hour'] as int, minute: map['minute'] as int);
  }
}
