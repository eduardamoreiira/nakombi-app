import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nacombi/produto/pages/produto_adicionar_page.dart';
import 'package:nacombi/produto/services/produto_services.dart';
import 'package:nacombi/vendas/services/vendas_service.dart';
import 'package:nacombi/vendas/models/venda.dart';
import 'package:intl/intl.dart'; // Para formatar a data

class ProdutoListarPage extends StatelessWidget {
  const ProdutoListarPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProdutoServices produtoServices = ProdutoServices();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Listagem de Produtos"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProdutoAdicionarPage()),
          );
        },
        child: Text(
          '+',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
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
                          child: Row(
                            children: [
                              Image.network(height: 50, docSnapshot['imagem']),
                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    docSnapshot['nome'],
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'R\$ ${docSnapshot['preco'].toString()}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
