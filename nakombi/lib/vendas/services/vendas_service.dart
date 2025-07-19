import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nacombi/clientes/models/cliente.dart';
import 'package:nacombi/produto/models/produto.dart';
import 'package:nacombi/utils/utils.dart';
import 'package:nacombi/vendas/models/item_venda.dart';
import 'package:nacombi/vendas/models/venda.dart';

class VendasService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _collectionRef = FirebaseFirestore.instance
      .collection('vendas');

  Cliente? cliente;
  final List<ItemVenda> _items = [];
  Venda? venda;

  adicionarItemVenda(String idVenda, Produto produto, int quantidade) async {
    try {
      ItemVenda itemVenda = ItemVenda(
        produto: produto,
        preco: produto.preco,
        quantidade: quantidade,
      );
      _collectionRef
          .doc(idVenda)
          .collection('itemsVenda')
          .add(itemVenda.toMap());
      DocumentReference docRef = _collectionRef.doc(idVenda);
      DocumentSnapshot doc = await docRef.get();
      if (doc.exists) {
        double total =
            (doc.data() as Map<String, dynamic>?)?.containsKey('total') == true
                ? (doc.data() as Map<String, dynamic>)['total'].toDouble()
                : 0.0;
        // Add the new sale amount to the current total
        double totalAtual = total + (produto.preco! * quantidade);

        // Update the document with the new total
        await docRef.update({'total': totalAtual});
        print('Total de vendas atualizado com sucesso!');
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error updating sales total: $e');
    }
    // getVenda(idVenda);
    // _items.add(ItemVenda(produto: produto, quantidade: quantidade));
  }

  atualizarQuantidade(Produto produto, int quantidade) {
    for (var item in _items) {
      if (item.produto == produto) {
        item.quantidade = quantidade;
      }
    }
  }
  //carregar carrinho da base de dados

  Stream<QuerySnapshot> getVendas() {
    // obtêm dados do carrinho da base de dados para o usuário atual
    // Atualiza o objeto _items de acordo com os requisitos
    return _firestore
        .collection('vendas')
        .orderBy('data', descending: true)
        .snapshots();
  }

  //salvar o carrinho na base de dados
  Future<void> adicionarVenda(Venda venda) async {
    this.venda = venda;
    cliente = venda.cliente;
    _firestore.collection('vendas').add(venda.toMap());
  }

  void addItemVenda(Venda venda, Produto produto, int quantidade) {
    debugPrint("Adicionando item ao carrinho de compras");
    // verifica se o produto já existe no carrinho, incrementa a quantidade se houver
    // Caso contrário, adiciona um novo item no carrinho
    _items.add(
      ItemVenda(produto: produto, quantidade: quantidade, preco: produto.preco),
    );
    notifyListeners();
  }

  Future<Venda?>? getVendaId(String? id) async {
    final docProduct = _firestore.collection('vendas').doc(id);

    final snapShot = await docProduct.get();
    debugPrint('objeto Venda --> ${Venda.fromMap(snapShot.data()!)}');
    if (snapShot.exists) {
      return Venda.fromMap(snapShot.data()!);
    } else {
      return null;
    }
  }

  Future<List<ItemVenda>> getItemsVenda(String? idVenda) async {
    List<ItemVenda> items = [];
    var query = await _collectionRef.get();
    for (var item in query.docs) {
      QuerySnapshot snap =
          await FirebaseFirestore.instance
              .collection("vendas")
              .doc(item.id)
              .collection("itemsVenda")
              .get();
      for (var itemDoc in snap.docs) {
        ItemVenda itemVenda = ItemVenda.fromDocument(itemDoc);
        items.add(itemVenda);
      }
    }
    return items;
  }

  Stream<QuerySnapshot> getVendasPorItens(String idVenda) {
    return _collectionRef.doc(idVenda).collection('itemsVenda').snapshots();
  }

  Future<List<Venda>> getVendaClienteId(String? id) async {
    QuerySnapshot querySnapshot = await _collectionRef.orderBy('name').get();
    return querySnapshot.docs.map((doc) {
      return Venda(
        id: doc.id,
        cliente: doc['cliente'],
        items: doc['items'] != null ? doc['itens'] : null,
        data: doc['data'],
        observacao: doc['observacao'],
      );
    }).toList();
  }

  //salvar o carrinho na base de dados
  Future<void> salvarVenda(Cliente cliente) async {
    // Salva os dados do carrinho na base de dados para o usuário atual
    Venda? venda = Venda(
      items: _items,
      cliente: cliente,
      data: DateTime.parse(Utils.getDateTime()),
    );
    _firestore.collection('vendas').add(venda.toMap());
  }

  //salvar o carrinho na base de dados
  Future<void> cartCheckout(Cliente cliente) async {
    cliente = cliente;
    // Salva os dados do carrinho na base de dados para o usuário atual
    Venda? venda = Venda(
      items: _items,
      cliente: cliente,
      data: DateTime.parse(Utils.getDateTime()),
    );
    _firestore.collection('vendas').add(venda.toMap());
  }

  // setUser(Usuario userServices) {
  //   userModel = userServices.userModel;
  //   notifyListeners();
  // }
  getVenda(String id) async {
    var doc = await _firestore.collection('vendas').doc(id).get();
    venda = Venda.fromDocument(doc);
  }
}
