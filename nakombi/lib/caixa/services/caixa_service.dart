import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nacombi/caixa/models/caixa_model.dart';
import 'package:flutter/material.dart';


class CaixaService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  get horarioEvento => null;
  Future<void> salvar(CaixaModel caixa) async {
    try {
      await _firestore.collection('caixa').add(caixa.toMap());
    } catch (e) {
      print('Erro ao salvar caixa: $e');
    }
  }

  set horario(TimeOfDay value) {
  }

  Stream<QuerySnapshot> getCaixas() {
    return _firestore
        .collection('caixa')
        .orderBy('dataEvento', descending: true)
        .snapshots();
  }

}
