import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nacombi/caixa/models/caixa.dart';
import 'package:nacombi/caixa/services/caixa_services.dart';
import 'package:nacombi/vendas/models/venda.dart';
import 'package:nacombi/vendas/pages/vendas_listagem_produtos_page.dart';
import 'package:nacombi/vendas/services/vendas_service.dart';
import 'package:nacombi/commons/my_text.dart';

class VendasDetalhesPage extends StatefulWidget {
  const VendasDetalhesPage({super.key, this.cliente, this.id});
  final String? cliente;
  final String? id;
  @override
  State<VendasDetalhesPage> createState() => _VendasDetalhesPageState();
}

class _VendasDetalhesPageState extends State<VendasDetalhesPage> {
  late final Future vendaFuture;
  VendasService vendaServices = VendasService();

  Future preparandoDadosVenda(String id) async {
    var venda = await vendaServices.getVendaId(id);
    setState(() {});
    return venda;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vendaFuture = preparandoDadosVenda(widget.id!);
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
      body: FutureBuilder<Venda?>(
        future: vendaServices.getVendaId(widget.id!),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            final Venda venda = snapshot.data!;
            debugPrint('venda ${venda.items.toString()}');
            if (venda.items != null) {
              return Column(
                children: [
                  // Text('${venda.cliente!.nome}'),
                  ListView.builder(
                    itemCount: venda.items!.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data!.docs[index];
                      return Text('${ds['produto']['nome']}');
                    },
                  ),
                ],
              );
            } else {
              return Center(
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 0.1),
                  ),
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
