import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nacombi/caixa/models/caixa.dart';
import 'package:nacombi/caixa/services/caixa_services.dart';
import 'package:nacombi/produto/models/produto.dart';
import 'package:nacombi/produto/services/produto_services.dart';
import 'package:nacombi/vendas/services/vendas_service.dart';
import 'package:nacombi/commons/my_text.dart';

class VendasListagemProdutosPage extends StatelessWidget {
  VendasListagemProdutosPage(this.idVenda, this.nomeCliente, {super.key});
  String idVenda, nomeCliente;
  @override
  Widget build(BuildContext context) {
    ProdutoServices produtoServices = ProdutoServices();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [const Text("Vendas de Produtos"), Text(nomeCliente)],
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: "Buscar",
                hintText: "Filtra por nome do produto",
                prefixIcon: Icon(Icons.search),
                prefixIconColor: Colors.blue,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
              onChanged: (name) {},
            ),
            const SizedBox(height: 15),
            StreamBuilder(
              stream: produtoServices.getTodosProdutos(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot docSnapshot =
                            snapshot.data!.docs[index];
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.network(
                                    height: 50,
                                    docSnapshot['imagem'],
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      docSnapshot['nome'],
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'R\$ ${docSnapshot['preco'].toString()}',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(flex: 1),
                                IconButton(
                                  color: const Color.fromARGB(255, 4, 62, 6),
                                  onPressed: () {
                                    Produto produto = Produto(
                                      id: docSnapshot.id,
                                      nome: docSnapshot['nome'],
                                      preco: docSnapshot['preco'],
                                    );
                                    VendasService vendasService =
                                        VendasService();
                                    vendasService.adicionarItemVenda(
                                      idVenda,
                                      produto,
                                      1,
                                    );
                                  },
                                  icon: Icon(
                                    size: 22,
                                    Icons.shopping_bag_rounded,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
