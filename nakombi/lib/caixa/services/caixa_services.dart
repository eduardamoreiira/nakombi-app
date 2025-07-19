import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nacombi/caixa/models/caixa.dart';

class CaixaServices extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //SALVANDO DADOS COM DATA RECEBIDA NO FORMATO STRING
  Future<void> salvar(String data, String local) async {
    DateTime dateTime = DateFormat('dd/MM/yyyy').parse(data);
    try {
      await _firestore.collection('caixas').add({
        'dataEvento': DateUtils.dateOnly(dateTime),
        'local': local,
        'horario': '20:30',
      });
    } catch (e) {
      debugPrint('Erro ao salvar caixa: $e');
    }
  }

  //SALVANDO DADOS COM DATA RECEBIDA NO FORMATO PADRÃO DE DATA
  Future<void> salvar2(Caixa caixa) async {
    try {
      // await _firestore.collection('caixas').add({
      //   'data': DateUtils.dateOnly(cx.dataCriacao!),
      //   'local': cx.local,
      // });

      await _firestore.collection('caixas').add(caixa.toMap());
    } catch (e) {
      debugPrint('Erro ao salvar caixa: $e');
    }
  }

  Stream<QuerySnapshot> getCaixas() {
    return _firestore
        .collection('caixas')
        .orderBy('dataEvento', descending: true)
        .snapshots();
  }

  //editar o caixa
  Future<void> editarCaixa(Caixa caixa) async {
    try {
      await _firestore.collection('caixas').doc(caixa.id).update(caixa.toMap());
    } catch (e) {
      debugPrint('Erro ao atualizar caixa: $e');
    }
  }

  //deletar o caixa
  Future<void> deletar(String idCaixa) async {
    try {
      await _firestore.collection('caixas').doc(idCaixa).delete();
      print('Caixa deletado com sucesso: $idCaixa');
    } catch (e) {
      print('Erro ao deletar caixa: $e');
    }
  }
}
