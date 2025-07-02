import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:nacombi/clientes/models/cliente_model.dart';
import 'package:nacombi/commons/my_card.dart';

class ClienteServices {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  adicionarCliente(ClienteModel cliente) {
    _firebaseFirestore.collection('clientes').add(cliente.toMap());
  }

  //atualizar dadso
  atualizarCliente(ClienteModel cliente) {
    _firebaseFirestore
        .collection('clientes')
        .doc(cliente.id)
        .update(cliente.toMap());
  }

  //excluir dados
  excluirCategoria(ClienteModel cliente) {
    _firebaseFirestore.collection('clientes').doc(cliente.id).delete();
  }

  Stream<QuerySnapshot> getClientes() {
    return _firebaseFirestore
        .collection('clientes')
        .orderBy('nome')
        .snapshots();
  }
}
