import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nacombi/categorias/models/categoria.dart';
import 'package:nacombi/categorias/pages/adicionar_categoria.dart';
import 'package:nacombi/categorias/pages/editar_categoria_page.dart';
import 'package:nacombi/categorias/services/categoria_services.dart';

class ListaCategoriaPage extends StatelessWidget {
  const ListaCategoriaPage({super.key});

  @override
  Widget build(BuildContext context) {
    CategoriaServices categoriaServices = CategoriaServices();
    Categoria categoria = Categoria();
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Categorias'),
        backgroundColor: const Color.fromARGB(255, 219, 132, 235),
      ),
      body: StreamBuilder(
        stream: categoriaServices.getCategorias(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  return Row(
                    children: [
                      SizedBox(
                        width: 250,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nome: ${ds['nome']}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Descrição: ${ds['descricao']}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          categoria.id = ds.id;
                          categoria.nome = ds['nome'];
                          categoria.descricao = ds['descricao'];
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) => EditarCategoriaPage(
                                    categoria: categoria,
                                  ),
                            ),
                          );
                        },
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          categoria.id = ds.id;
                          CategoriaServices().excluirCategoria(categoria);
                        },
                        icon: Icon(Icons.delete, color: Colors.purple),
                      ),
                    ],
                  );
                },
              ),
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => AdicionarCategoria()));
        },
        backgroundColor: Colors.purple,
        child: Text('+', style: TextStyle(fontSize: 14)),
      ),
    );
  }
}
