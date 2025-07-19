import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nacombi/caixa/models/caixa.dart';
import 'package:nacombi/caixa/services/caixa_services.dart';
import 'package:nacombi/vendas/pages/vendas_listagem_produtos_page.dart';
import 'package:nacombi/vendas/services/vendas_service.dart';
import 'package:nacombi/commons/my_text.dart';

class VendasDetalhesPage2 extends StatefulWidget {
  VendasDetalhesPage2({super.key, this.cliente, this.id});
  final String? cliente;
  final String? id;
  double total = 0; // state variable for counting

  @override
  State<VendasDetalhesPage2> createState() => _VendasDetalhesPage2State();
}

class _VendasDetalhesPage2State extends State<VendasDetalhesPage2> {
  late final Future vendaFuture;

  VendasService vendaServices = VendasService();

  double _calcTotal(double value) {
    debugPrint('value $value');
    return widget.total = widget.total + value; // updating the state variable
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(text: 'Detalhes de Venda - ${widget.cliente}', size: 14),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (context) => VendasListagemProdutosPage(
                          widget.id!,
                          widget.cliente!,
                        ),
                  ),
                );
              },
              icon: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: vendaServices.getVendasPorItens(widget.id!),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            debugPrint('erro ');
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            debugPrint('Esperando dados do Firebase ');
            return CircularProgressIndicator();
          } else {
            int item = 1;
            return Column(
              children: [
                // Text('${venda.cliente!.nome}'),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 15,
                  ),

                  child: Row(
                    children: [
                      SizedBox(
                        width: 30,
                        child: MyText(text: 'Item', size: 12),
                      ),

                      SizedBox(
                        width: 115,
                        child: MyText(text: 'Descrição', size: 12),
                      ),
                      SizedBox(
                        width: 50,
                        child: MyText(text: 'Qtde', size: 12),
                      ),

                      SizedBox(
                        width: 60,
                        child: MyText(text: 'Preço', size: 12),
                      ),
                      SizedBox(
                        width: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,

                          children: [MyText(text: 'Subtotal', size: 12)],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 0.7, color: Colors.black45),

                ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data!.docs[index];
                    item = item + index;
                    _calcTotal(ds['subtotal']);
                    debugPrint('${widget.total}');
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 3.0,
                        horizontal: 15,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 30,
                            child: MyText(text: item.toString(), size: 12),
                          ),

                          SizedBox(
                            width: 115,
                            child: MyText(
                              text: '${ds['produto']['nome']}',
                              size: 12,
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            child: MyText(
                              text: '${ds['quantidade']}',
                              size: 12,
                              weight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            child: MyText(
                              text: ds['preco'].toString().padRight(2, '0'),
                              size: 12,
                              weight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                MyText(
                                  text: ds['subtotal'].toString(),

                                  size: 12,
                                  weight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                    // return Text(
                    // 'produto'
                    // 'nome',
                    // );
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
