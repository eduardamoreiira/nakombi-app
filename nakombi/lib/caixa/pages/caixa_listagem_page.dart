import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nacombi/caixa/models/caixa.dart';
import 'package:nacombi/caixa/services/caixa_services.dart';
import 'package:nacombi/vendas/pages/vendas_listagem_page.dart';
import 'package:nacombi/commons/my_text.dart';
import 'package:nacombi/caixa/pages/editar_caixa_page.dart'; // Importe a página de edição

class CaixaListagemPage extends StatefulWidget {
  const CaixaListagemPage({super.key});

  @override
  State<CaixaListagemPage> createState() => _CaixaListagemPageState();
}

class _CaixaListagemPageState extends State<CaixaListagemPage> {
  final formKey = GlobalKey<FormState>();
  DateTime? _dia;
  DateFormat data = DateFormat("dd/MM/yyyy");
  final TextEditingController _diaEscolhido = TextEditingController();
  final TextEditingController _local = TextEditingController();
  final TextEditingController _horario = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // DateTime? pickedDate; // Não é mais necessário aqui
    // TimeOfDay horario = TimeOfDay.now(); // Não é mais necessário aqui
    CaixaServices caixaServices = CaixaServices();
    // Caixa caixa = Caixa(); // Não é mais necessário instanciar aqui, apenas para passar para a edição

    return Scaffold(
      appBar: AppBar(actions: const [], title: const Text('Caixas')),
      body: StreamBuilder(
        stream: caixaServices.getCaixas(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  // Criar um objeto Caixa a partir do DocumentSnapshot para passar para a edição
                  Caixa caixaAtual = Caixa(
                    id: ds.id,
                    dataEvento: ds['dataEvento'].toDate(),
                    local: ds['local'],
                    horario: TimeOfDay(
                      hour: int.parse(ds['horario'].split(":")[0]),
                      minute: int.parse(ds['horario'].split(":")[1]),
                    ),
                  );

                  return Row(
                    children: [
                      SizedBox(
                        width: 320,
                        child: Card(
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                      text:
                                          'Dia do Evento: ${DateFormat("dd/MM/yyyy").format(ds['dataEvento'].toDate())}',
                                      color: Colors.brown.shade800,
                                      size: 10,
                                      weight: FontWeight.bold,
                                    ),
                                    MyText(
                                      text:
                                          'Horário do Evento: ${ds['horario']}',
                                      color: Colors.brown.shade800,
                                      size: 10,
                                      weight: FontWeight.bold,
                                    ),
                                    MyText(
                                      text: 'Local: ${ds['local']}',
                                      color: Colors.deepOrange,
                                      size: 10,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      softWrap: true,
                                      weight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                                IconButton.outlined(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder:
                                            (context) => VendasListagemPage(
                                              diaEvento:
                                                  ds['dataEvento'].toDate(),
                                              horario: ds['horario'],
                                              local: ds['local'],
                                            ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.shopping_bag),
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      iconSize: 15,
                                      onPressed: () {
                                        // Navegar para a página de edição
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder:
                                                (context) => EditarCaixaPage(
                                                  caixaParaEditar: caixaAtual,
                                                ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      iconSize: 15,
                                      onPressed: () {
                                        // Diálogo de confirmação antes de deletar
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text(
                                                'Confirmar Exclusão',
                                              ),
                                              content: Text(
                                                'Tem certeza que deseja deletar o caixa de ${DateFormat("dd/MM/yyyy").format(caixaAtual.dataEvento ?? DateTime.now())} - ${caixaAtual.local}?',
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(
                                                      context,
                                                    ).pop(); // Fechar o diálogo
                                                  },
                                                  child: const Text('Cancelar'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    caixaServices.deletar(
                                                      caixaAtual.id!,
                                                    );
                                                    Navigator.of(
                                                      context,
                                                    ).pop(); // Fechar o diálogo
                                                  },
                                                  child: const Text(
                                                    'Deletar',
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Resetar os controladores ao abrir o diálogo de criação
          _diaEscolhido.clear();
          _horario.clear();
          _local.clear();
          _dia = null; // Resetar a data selecionada
          // horario = TimeOfDay.now(); // Resetar o horário inicial

          showDialog(
            context: context,
            builder: (context) {
              // TimeOfDay horarioDialog = TimeOfDay.now(); // Variável local para o diálogo
              return Dialog(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 3, 45, 5),
                          offset: Offset(1, 1),
                          spreadRadius: 1,
                          blurStyle: BlurStyle.solid,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Align(
                            alignment: Alignment.topRight,
                            child: CloseButton(),
                          ),
                          const Center(
                            child: Text(
                              "Abrir Caixa",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Dia",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2030),
                                context: context,
                                initialDate: _dia ?? DateTime.now(),
                              );

                              if (pickedDate != null && pickedDate != _dia) {
                                setState(() {
                                  _dia = pickedDate;
                                  debugPrint('dia escolhido $_dia');
                                });
                                _diaEscolhido.text = data.format(_dia!);
                              }
                            },
                            controller: _diaEscolhido,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.green[50],
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Por favor, preenche o dia da abertura do caixa';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8),

                          const Text(
                            "Horário", // Corrigido para "Horário"
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),

                          TextFormField(
                            controller: _horario,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.green[50],
                            ),
                            onTap: () async {
                              TimeOfDay horarioDialog =
                                  TimeOfDay.now(); // Usar uma variável local para o diálogo
                              var hora = await showTimePicker(
                                context: context,
                                initialTime: horarioDialog,
                              );
                              if (hora != null && hora != horarioDialog) {
                                setState(() {
                                  horarioDialog = hora;
                                });
                              }
                              _horario.text =
                                  "${horarioDialog.hour.toString().padLeft(2, '0')}:${horarioDialog.minute.toString().padLeft(2, '0')}";
                              // Não precisa mais de caixa.horario aqui, pois será criado no salvar
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Por favor, preenche o horário da abertura do caixa';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Local",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _local,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.green[50],
                            ),
                            onChanged: (value) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Local é obrigatório';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  Caixa novoCaixa = Caixa(
                                    dataEvento: DateFormat(
                                      'dd/MM/yyyy',
                                    ).parse(_diaEscolhido.text),
                                    horario: TimeOfDay(
                                      hour: int.parse(
                                        _horario.text.split(":")[0],
                                      ),
                                      minute: int.parse(
                                        _horario.text.split(":")[1],
                                      ),
                                    ),
                                    local: _local.text,
                                  );
                                  caixaServices.salvar2(novoCaixa);
                                  Navigator.of(context).pop();
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor: const WidgetStatePropertyAll(
                                  Colors.blueGrey,
                                ),
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Salvar',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: const Text(
          '+',
          style: TextStyle(
            color: Color.fromARGB(255, 4, 53, 6),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
