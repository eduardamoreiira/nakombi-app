import 'package:flutter/material.dart';
import 'package:nacombi/clientes/service/cliente_services.dart';
import 'package:nacombi/commons/my_card.dart';
import 'package:nacombi/clientes/models/cliente_model.dart';
import 'package:nacombi/clientes/pages/editar_cliente_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListaClientesPage extends StatelessWidget {
  const ListaClientesPage({super.key});

  @override
  Widget build(BuildContext context) {
    ClienteServices clienteServices = ClienteServices();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Clientes'),
        backgroundColor: Color.fromARGB(255, 219, 132, 235),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: clienteServices.getClientes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: MyCard(
                            'Clientes',
                            'Registrar',
                            Colors.purple,
                            Colors.purpleAccent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nome: ${ds['nome']}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Email: ${ds['email']}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  softWrap: true,
                                ),
                                Text(
                                  'CPF: ${ds['cpf']}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            ClienteModel cliente = ClienteModel(
                              id: ds.id,
                              nome: ds['nome'],
                              email: ds['email'],
                              cpf: ds['cpf'],
                            );

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        EditarClientePage(cliente: cliente),
                              ),
                            );
                          },
                          icon: Icon(Icons.edit),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar clientes'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
