import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:nacombi/produto/models/produto.dart';
import 'package:uuid/uuid.dart';

class ProdutoServices {
  //instância para persistência dos dados no Firebase
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //instância para upload de mídias (imagens, vídeos, pdf) para o Firebase
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Produto? produto;
  final CollectionReference _collectionRef = FirebaseFirestore.instance
      .collection('produtos');
  DocumentReference get _firestoreRef =>
      _firestore.doc('products/${produto!.id}');
  Reference get _storageRef =>
      _storage.ref().child('products').child('${produto!.id}');

  Future<bool> salvar({Produto? produto, dynamic imagem, bool? plat}) async {
    try {
      final doc = await _collectionRef.add(produto!.toMap());
      this.produto = produto;
      this.produto!.id = doc.id;

      _uploadImage(imagem, plat!);
      return Future.value(true);
    } on FirebaseException {
      return Future.value(false);
    }
    // if (product.id == null) {
    //   final doc = await _firestore.collection('products').add(product.toMap());
    //   product.id = doc.id;
    // } else {
    //   //atualiza apenas os dados passados, se houve algum dado não passado este não será atualizado
    //   await _firestoreRef.update(
    //       product.toMap()); //não usar setdata, pois sobrescreve todos os dados
    // }
  }

  Future<void> atualizar(Produto produto) async {
    await _collectionRef
        .doc(produto.id)
        .update(
          // {"name": product.name, "price": product.price},
          produto.toMap(),
        );
  }

  Future<Produto?> getProdutoPorId(String? id) async {
    final docProduto = _firestore.collection('produtos').doc(id);
    final snapShot = await docProduto.get();
    if (snapShot.exists) {
      return Produto.fromDocument(snapShot);
    } else {
      return null;
    }
  }

  Stream<QuerySnapshot> getTodosProdutos() {
    return _collectionRef.snapshots();
  }

  Future<List<Produto>> getProdutos() async {
    List<Produto> listaProdutos = [];
    final result = await _collectionRef.get();
    listaProdutos = result.docs.map((e) => Produto.fromSnapshot(e)).toList();
    return listaProdutos;
  }

  _uploadImage(dynamic imagem, bool plat) async {
    //chave para persistir a imagem no firebasestorage
    final uuid = const Uuid().v1();
    try {
      Reference storageRef = _storage
          .ref()
          .child('produtos')
          .child(produto!.id!);
      //objeto para realizar o upload da imagem
      UploadTask task;

      if (!plat) {
        task = storageRef
            .child(uuid)
            .putFile(
              imagem,
              // SettableMetadata(
              //   contentType: 'image/jpg',
              //   customMetadata: {'product name': product!.name!, 'description': 'Informação de arquivo', 'imageName': imageFile},
              // ),
            );
      } else {
        task = storageRef
            .child(uuid)
            .putData(
              imagem,
              // SettableMetadata(contentType: 'image/jpg', customMetadata: {
              //   'product name': product!.name!,
              //   'description': 'Informação de arquivo',
              //   // 'imageName': File(imageFile).
              // }),
            );
      }
      //procedimento para persistir a imagem no banco de dados firebase
      String url = await (await task.whenComplete(() {})).ref.getDownloadURL();
      DocumentReference docRef = _collectionRef.doc(produto!.id);
      await docRef.update({'id': produto!.id, 'imagem': url});
    } on FirebaseException catch (e) {
      if (e.code != 'OK') {
        debugPrint('Problemas ao gravar dados');
      } else if (e.code == 'ABORTED') {
        debugPrint('Inclusão de dados abortada');
      }
      return Future.value(false);
    }
  }

  Future<bool> deletar() {
    try {
      _firestoreRef.update({'deletado': true});
      return Future.value(true);
    } on FirebaseException {
      return Future.value(false);
    }
  }

  Future<QuerySnapshot> getDocs() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      // debugPrint(a.id);
    }
    return querySnapshot;
  }

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    debugPrint(allData.toString());
  }

  Future<List<DocumentSnapshot>> getProdutoPorNome(String nome) =>
      _collectionRef
          .orderBy('nome')
          .startAt([nome.toLowerCase()])
          .endAt([
            '${nome.toLowerCase()}\uf8ff',
          ]) //.endAt([name.toLowerCase() + '\uf8ff'])
          .get()
          .then((snapshot) {
            return snapshot.docs;
          });

  Future<List<DocumentSnapshot>> getProdutoPorNome2(String nome) async {
    try {
      var result = _collectionRef
          .where('nome', isGreaterThanOrEqualTo: nome)
          .where('name', isLessThan: '${nome}z')
          .get()
          .then((value) {
            return value.docs;
          }); //.where('name', isLessThan: name +'z').snapshots(); //
      return Future.value(result);
    } on FirebaseException {
      return Future.value(null);
    }
  }
}


/*
Firestore.instance
      .collection('your-collection')
      .orderBy('your-document')
      .startAt([searchkey])
      .endAt([searchkey + '\uf8ff']

Firestore.instance
 .collection('Col-Name')
 .where('fieldName', isGreaterThanOrEqualTo: searchKey)
 .where('fieldName', isLessThan: searchKey +’z’)

var start = DateTime.parse("2021-04-01");
var end = DateTime.parse("2021-04-30");

FirebaseFirestore.instance
        .collection("AllFarm")
        .doc("${Variables.collectionNameID}")
        .collection("${Variables.collectionNameID}")
        .doc(docID)
        .collection("Deposit")
        .where('date', isGreaterThan: start)
        .where('date', isLessThan: end)
        .orderBy('date', descending: true)
        .snapshots(),

*/