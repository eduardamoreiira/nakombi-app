import 'package:flutter/material.dart';
import 'package:nacombi/clientes/pages/add_client_page.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Perfil de Usuário'),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/images/image.png',
                  height: 120,
                  width: 120,
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                'prof.albertosales@gmail.com',
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 25),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ALBERTO SALES E SILVA'),
                      Text('Rua: Dr. Santo Santos'),
                      Text('(65) - 9973-7171'),
                      SizedBox(height: 3),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddClientPage(),
                                ),
                              );
                            },
                            child: Text('Registrar'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              debugPrint('cliquei no botão!!!');
                            },
                            child: Text('Alterar'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
