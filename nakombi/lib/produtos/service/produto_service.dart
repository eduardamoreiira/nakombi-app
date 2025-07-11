import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nacombi/produtos/models/produto_model.dart';

class ProdutoService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  adicionarProduto(ProdutoModel produto) {
    _firebaseFirestore.collection('produtos').add(produto.toMap());
  }

  // Atualizar dados
  atualizarProduto(ProdutoModel produto) {
    _firebaseFirestore
        .collection('produtos')
        .doc(produto.id)
        .update(produto.toMap());
  }

  // Excluir dados
  excluirProduto(ProdutoModel produto) {
    _firebaseFirestore.collection('produtos').doc(produto.id).delete();
  }

  Stream<QuerySnapshot> getProdutos() {
    return _firebaseFirestore
        .collection('produtos')
        .orderBy('nome')
        .snapshots();
  }
}
