import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nacombi/categoria/models/categoria.dart';

class CategoriaServices {
  //instância do firestore (armazenamento de dados)
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //instância do storage (armazenamento de mídias [som, imagem , pdf, vídeos])
  final FirebaseStorage _storage = FirebaseStorage.instance;

  //método para adicionar/criar documento em uma coleção
  adicionarCategoria(Categoria categoria) {
    _firestore.collection('categorias').add(categoria.toMap());
  }

  //atualizando dados
  atualizarCategoria(Categoria categoria) {
    _firestore
        .collection('categorias')
        .doc(categoria.id)
        .update(categoria.toMap());
  }

  //recuperar os dados
  Stream<QuerySnapshot> getCategorias() {
    return _firestore.collection('categorias').orderBy('nome').snapshots();
  }

  //atualizando dados
  deletarCategoria(Categoria categoria) {
    _firestore.collection('categorias').doc(categoria.id).delete();
  }
}
