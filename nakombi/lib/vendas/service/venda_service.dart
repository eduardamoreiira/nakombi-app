import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nacombi/produtos/models/produto_model.dart';
import 'package:nacombi/vendas/models/item_venda_model.dart';
import 'package:nacombi/clientes/models/cliente_model.dart';

class VendaService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  ClienteModel? cliente;
  List<ItemVendaModel> itensVenda = [];

  // Método para salvar a venda no Firestore
  adicionarItemVenda(ProdutoModel produto, int quantidade) {
    itensVenda.add(ItemVendaModel(produto: produto, quantidade: quantidade));
  }

  // Método para salvar a venda no Firestore
  atualizarQuantidadeItemVenda(ProdutoModel produto, int quantidade) {
    for (var item in itensVenda) {
      if (item.produto == produto) {
        item.quantidade = quantidade;
        item.subTotal = item.preco! * quantidade;
        break;
      }
    }
  }
}
