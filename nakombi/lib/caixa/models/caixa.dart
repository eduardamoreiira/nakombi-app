// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Caixa {
  String? id;
  DateTime? dataEvento;
  TimeOfDay? horario;
  String? local;
  Caixa({this.id, this.dataEvento, this.horario, this.local});

  Caixa copyWith({
    String? id,
    DateTime? dataEvento,
    TimeOfDay? horario,
    String? local,
  }) {
    return Caixa(
      id: id ?? this.id,
      dataEvento: dataEvento ?? this.dataEvento,
      horario: horario ?? this.horario,
      local: local ?? this.local,
    );
  }

  // Map<String, dynamic> toMap() {
  //   final result = <String, dynamic>{};

  //   if (id != null) {
  //     result.addAll({'id': id});
  //   }
  //   if (dataCriacao != null) {
  //     result.addAll({'dataCriacao': dataCriacao!.millisecondsSinceEpoch});
  //   }
  //   if (horario != null) {
  //     result.addAll({'horario': "${horario!.hour}:${horario!.minute}"});
  //   }
  //   if (local != null) {
  //     result.addAll({'local': local});
  //   }

  //   return result;
  // }

  //-- utilizado para enviar dados para o firebase com formato compatível com o JSON (map)
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dataEvento': dataEvento,
      'horario':
          ("${horario!.hour}:${horario!.minute.toString().padRight(2, '0')}"),
      'local': local,
      'criadoEm': FieldValue.serverTimestamp(),
    };
  }

  factory Caixa.fromMap(Map<String, dynamic> map) {
    return Caixa(
      id: map['id'],
      dataEvento:
          map['dataEvento'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['dataEvento'])
              : null,
      horario: TimeOfDay(
        hour: int.parse(map['horario'].toString().split(":").first),
        minute: int.parse(map['horario'].toString().split(":").last),
      ),
      local: map['local'],
    );
  }
  //Método utilizado para armazenar dados do documento obtido do Firebase
  Caixa.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    local = doc.get('local');
    dataEvento = (doc.get('dataEvento') as Timestamp).toDate();
    horario = doc.get('horario');
  }

  String toJson() => json.encode(toMap());

  factory Caixa.fromJson(String source) => Caixa.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Caixa(id: $id, dataEvento: $dataEvento, horario: $horario, local: $local)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Caixa &&
        other.id == id &&
        other.dataEvento == dataEvento &&
        other.horario == horario &&
        other.local == local;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        dataEvento.hashCode ^
        horario.hashCode ^
        local.hashCode;
  }
}
