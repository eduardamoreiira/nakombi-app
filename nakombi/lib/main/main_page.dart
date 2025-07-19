import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nacombi/caixa/pages/caixa_listagem_page.dart';
import 'package:nacombi/caixa/services/caixa_services.dart';
import 'package:nacombi/categoria/pages/categoria_lista_page.dart';
import 'package:nacombi/clientes/pages/perfil_page.dart';
import 'package:nacombi/commons/my_card.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nacombi/utils/utils.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nakombi Baixa Gastronomia Cuiabana',
          style: TextStyle(fontSize: 14),
        ),
        centerTitle: true,
      ),
      body:
          [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    MyCard(
                      'Vendas',
                      'registrar',
                      Colors.blue,
                      Colors.blueAccent,
                    ),
                    SizedBox(height: 20),
                    MyCard('Locais', 'regiões', Colors.green, Colors.green),
                    SizedBox(height: 20),
                    MyCard('Clientes', 'gerenciar', Colors.cyan, Colors.cyan),
                  ],
                ),
              ),
            ),
            CaixaListagemPage(),
            Container(color: Colors.blueAccent),
            PerfilPage(),
          ][_index],
      bottomNavigationBar: NavigationBar(
        height: 45.0,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        indicatorColor: Colors.lightGreen.shade200,
        labelTextStyle: WidgetStatePropertyAll(TextStyle(fontSize: 10)),
        selectedIndex: _index,
        onDestinationSelected: (value) {
          setState(() {
            _index = value;
          });
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart),
            label: 'Vendas',
          ),
          NavigationDestination(icon: Icon(Icons.list), label: 'Relatórios'),
          NavigationDestination(icon: Icon(Icons.person_2), label: 'Sua Conta'),
        ],
      ),
      drawer: Drawer(
        width: 250,
        child: SafeArea(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Image.asset(
                      'assets/logo/kombi.jpg',
                      width: 50,
                      height: 50,
                    ),
                    //SvgPicture.asset('assets/logo/Logo.svg'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Nakombi Gastro',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: TextTheme.of(context).bodyMedium!.color,
                      ),
                    ),
                    //SvgPicture.asset('assets/logo/Logo.svg'),
                  ),
                ],
              ),
              const Divider(),
              SizedBox(height: 10),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    // SizedBox(child: DrawerHeader(child: Text('Nakombi Gastro'))),
                    Theme(
                      data: Theme.of(
                        context,
                      ).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        // shape: Border(),
                        initiallyExpanded: isSelected,
                        leading: SvgPicture.asset(
                          isSelected
                              ? 'assets/icons/home_filled.svg'
                              : 'assets/icons/home_light.svg',
                        ),
                        onExpansionChanged: (value) {
                          setState(() {
                            isSelected = value;
                          });
                        },
                        title: Text(
                          'Gerenciamento',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: TextTheme.of(context).bodyMedium!.color,
                          ),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 35.0),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => CategoriaListaPage(),
                                  ),
                                );
                              },
                              title: Text(
                                'Categorias',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: TextTheme.of(context).bodySmall!.color,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(Icons.people),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: Text(
                        'Perfil de Usuário',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: TextTheme.of(context).bodyMedium!.color,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(Icons.shop),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: Text(
                        'Vendas',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: TextTheme.of(context).bodyMedium!.color,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(Icons.shop),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: Text(
                        'Pedidos',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: TextTheme.of(context).bodyMedium!.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ListView(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           children: [
//             SizedBox(child: DrawerHeader(child: Text('Nakombi Gastro'))),
//             ExpansionTile(
//               leading: SvgPicture.asset(isSelected ? 'assets/icons/home_filled.svg' : 'assets/icons/home_light.svg'),
//               title: Text(
//                 'Gerenciamento',
//                 style: TextStyle(fontWeight: FontWeight.w600, color: TextTheme.of(context).bodyMedium!.color),
//               ),
//               children: [
//                 ListTile(

//                   onTap: () {
//                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdicionarCategoria()));
//                   },
//                   title: Text(
//                     'Categorias',
//                     style: TextStyle(fontWeight: FontWeight.w600, color: TextTheme.of(context).bodyMedium!.color),
//                   ),
//                 ),
//               ],
//             ),
//             ListTile(title: Text('Perfil de Usuário')),
//           ],
//         ),

String _formatPubDate() {
  DateTime date = DateTime.now();
  DateFormat ptBrFormat = DateFormat('EEEE, dd/MM/y H:m', 'pt_BR');
  return ptBrFormat.format(date);
}
