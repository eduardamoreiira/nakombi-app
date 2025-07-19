import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nacombi/categoria/models/categoria.dart';
import 'package:nacombi/categoria/pages/adicionar_categoria.dart';
import 'package:nacombi/categoria/pages/categoria_editar_page.dart';
import 'package:nacombi/categoria/services/categoria_services.dart';

class CategoriaListaPage extends StatelessWidget {
  const CategoriaListaPage({super.key});

  @override
  Widget build(BuildContext context) {
    CategoriaServices categoriaServices = CategoriaServices();
    Categoria categoria = Categoria();
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Categorias')),
      body: StreamBuilder(
        stream: categoriaServices.getCategorias(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
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
                          debugPrint("doc id ${ds.id}");
                          categoria.id = ds.id;
                          categoria.nome = ds['nome'];
                          categoria.descricao = ds['descricao'];
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      CategoriaEditarPage(categoria: categoria),
                            ),
                          );
                        },
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.delete, color: Colors.red),
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
        child: Text('+', style: TextStyle(fontSize: 14)),
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => AdicionarCategoria()));
        },
      ),
    );
  }
}
