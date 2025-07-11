import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nacombi/categorias/models/categoria.dart';

class CategoriaServices {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  adicionarCategoria(Categoria categoria) {
    _firebaseFirestore.collection('categorias').add(categoria.toMap());
  }

  //atualizar dadso
  atualizarCategoria(Categoria categoria) {
    _firebaseFirestore
        .collection('categorias')
        .doc(categoria.id)
        .update(categoria.toMap());
  }

  //excluir dados
  excluirCategoria(Categoria categoria) {
    _firebaseFirestore.collection('categorias').doc(categoria.id).delete();
  }

  Stream<QuerySnapshot> getCategorias() {
    return _firebaseFirestore
        .collection('categorias')
        .orderBy('nome')
        .snapshots();
  }
}
