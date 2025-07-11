import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nacombi/caixa/models/caixa_model.dart';
import 'package:nacombi/caixa/services/caixa_service.dart';
import 'package:nacombi/commons/my_textformfield.dart';

class ListaCaixaPage extends StatelessWidget {
  const ListaCaixaPage({super.key});

  @override
  Widget build(BuildContext context) {
    var keyForm = GlobalKey<FormState>();
    TextEditingController dataController = TextEditingController();
    TextEditingController horaControlller = TextEditingController();
    TimeOfDay horarioEvento = TimeOfDay.now();
    CaixaService caixaService = CaixaService();
    CaixaModel caixa = CaixaModel();
    return Scaffold(
      appBar: AppBar(title: Text('Caixa Diário')),
      floatingActionButton: FloatingActionButton(
        child: Text('+', style: TextStyle(fontSize: 18)),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Container(
                  height: 300,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(210, 246, 98, 202),
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Form(
                    key: keyForm,
                    child: Column(
                      children: [
                        MyTextFormField(
                          'Data',
                          controller: dataController,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2030),
                              initialDate: DateTime.now(),
                            );
                            if (pickedDate != null) {
                              dataController.text = DateFormat(
                                'dd-MM-yyyy',
                              ).format(pickedDate);
                            }
                          },
                        ),
                        TextFormField(
                          // 'Horário',
                          controller: horaControlller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.green[50],
                          ),

                          onTap: () async {
                            var hora = await showTimePicker(
                              context: context,
                              initialTime: horarioEvento,
                            );
                            if (hora != null && hora != horarioEvento) {
                              setState(() {
                                horarioEvento = hora;
                              });
                            }

                            horaControlller.text =
                                "${horarioEvento.hour}:${horarioEvento.minute}";
                            horaControlller.text.padRight(5, '0');
                            caixaService.horario = TimeOfDay(
                              hour: horarioEvento.hour,
                              minute: horarioEvento.minute,
                            );
                            debugPrint(
                              'caixaService.horario ${caixaService.horarioEvento.toString()}',
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        MyTextFormField('Local'),
                        SizedBox(height: 15),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text('Salvar'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void setState(Null Function() param0) {}
}
