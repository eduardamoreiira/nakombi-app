import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nacombi/caixa/models/caixa.dart';
import 'package:nacombi/caixa/services/caixa_services.dart';
import 'package:nacombi/vendas/pages/vendas_adicionar_page.dart';
import 'package:nacombi/vendas/pages/vendas_detalhes_page2.dart';
import 'package:nacombi/vendas/services/vendas_service.dart';
import 'package:nacombi/commons/my_text.dart';

class VendasListagemPage extends StatelessWidget {
  const VendasListagemPage({
    super.key,
    required this.diaEvento,
    required this.horario,
    required this.local,
  });
  final DateTime diaEvento;
  final String horario;
  final String local;

  @override
  Widget build(BuildContext context) {
    VendasService vendasService = VendasService();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    MyText(
                      text: 'Evento $local',
                      size: 20,
                      weight: FontWeight.w700,
                      color: const Color.fromARGB(255, 3, 45, 5),
                    ),
                    MyText(
                      text: 'Horário: $horario',
                      size: 20,
                      weight: FontWeight.w500,
                      color: const Color.fromARGB(255, 3, 45, 5),
                    ),
                    MyText(
                      text:
                          'Vendas do dia: ${DateFormat("dd/MM/yyyy").format(diaEvento)}',
                      color: Colors.amber,
                      weight: FontWeight.bold,
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      // Added const
                      height: 1,
                      color: Color.fromARGB(255, 3, 45, 5),
                    ),
                  ],
                ),
              ),
            ),
            StreamBuilder(
              stream: vendasService.getVendas(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(), // Add this to prevent nested scroll issues
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data!.docs[index];
                      // Safely access the data as a Map
                      final data = ds.data() as Map<String, dynamic>?;

                      // Check if 'cliente' field exists and is a Map
                      final clientData =
                          (data != null &&
                                  data['cliente'] is Map<String, dynamic>)
                              ? data['cliente'] as Map<String, dynamic>
                              : null;

                      // Get client name safely
                      final String clienteNome =
                          (clientData != null && clientData['nome'] is String)
                              ? clientData['nome'] as String
                              : 'Cliente Não Informado'; // Default value if not found

                      // Safely access 'data' (timestamp)
                      final Timestamp? timestamp =
                          (data != null && data['data'] is Timestamp)
                              ? data['data'] as Timestamp
                              : null;
                      final String formattedDate =
                          timestamp != null
                              ? DateFormat(
                                'dd/MM/yyyy',
                              ).format(timestamp.toDate())
                              : 'Data Inválida';

                      // Safely access 'total'
                      final String totalVenda =
                          data?['total'] != null
                              ? ds['total'].toString()
                              : 'Total N/A';

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 20,
                        ),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (context) => VendasDetalhesPage2(
                                          id: ds.id,
                                          cliente:
                                              clienteNome, // Pass the safely accessed name
                                          // venda: venda,
                                        ),
                                  ),
                                );
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 15,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          MyText(
                                            text:
                                                'Cliente: $clienteNome', // Use the safely accessed name
                                            color: Colors.brown.shade800,
                                            size: 10,
                                            weight: FontWeight.bold,
                                          ),
                                          MyText(
                                            text:
                                                'Data: $formattedDate', // Use the safely accessed date
                                            color: Colors.brown.shade800,
                                            size: 10,
                                            weight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                      MyText(
                                        text:
                                            'Total da Venda: $totalVenda', // Use the safely accessed total
                                        size: 10,
                                        weight: FontWeight.w800,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 0.5),
                      ),
                      child: const CircularProgressIndicator(), // Added const
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder:
                  (context) => VendasAdicionarPage(
                    diaEvento: diaEvento,
                    horario: horario,
                    local: local,
                  ),
            ),
          );
        },
        child: const Icon(Icons.add), // Added const
      ),
    );
  }
}
