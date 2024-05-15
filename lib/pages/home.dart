// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_blue/flutter_blue.dart';

void main() {
  runApp(const Home(userName: "User"));
}

class Home extends StatefulWidget {
  final String userName;

  const Home({Key? key, required this.userName}) : super(key: key);
  static const routeName = '/home';

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late FlutterBlue flutterBlue;
  bool isWatchConnected = false;
  late String _editedName;

  @override
  void initState() {
    super.initState();
    flutterBlue = FlutterBlue.instance;
    initializeDateFormatting('pt_BR', null);
    _editedName = widget.userName;
    flutterBlue.scanResults.listen((results) {
      // Verifica se o smartwatch está na lista de dispositivos encontrados
      // Se estiver, define isWatchConnected como true e atualiza o estado
      // Caso contrário, define isWatchConnected como false e atualiza o estado
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat.yMMMMd('pt_BR').format(DateTime.now());

    return MaterialApp(
      theme: ThemeData.dark(),
      scrollBehavior: const MaterialScrollBehavior().copyWith(scrollbars: false), //Scroll do Site//
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(''),
          ),
          body: Column(
            children: [
              Expanded(
                child: TabBarView(
                  children: [
                    Stack(
                      children: [
                        const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Adicione os ícones de outras abas aqui, se necessário
                            ],
                          ),
                        ),
                        Positioned( // Texto Bem - Vindo//
                          top: 0,
                          left: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Bem-vindo, $_editedName!',
                              style: const TextStyle(fontSize: 26),
                            ),
                          ),
                        ),
                        Positioned( //Imagens//
                          top: 35,
                          left: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              formattedDate,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                        const Positioned(
                          top: 290,
                          left: 0,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Atividades',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Escolha sua rotina',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 50,
                          left: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/grafico.png',
                              width: MediaQuery.of(context).size.width,
                              height: 248,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 310,
                          left: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/atividade1.png',
                              width: MediaQuery.of(context).size.width,
                              height: 250,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 491,
                          left: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/atividade2.png',
                              width: MediaQuery.of(context).size.width,
                              height: 250,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 16,
                          right: 16,
                          child: FloatingActionButton(
                            onPressed: () {
                              // Navegar para a página de chat
                              Navigator.pushNamed(context, '/chat');
                            },
                            backgroundColor: Colors.red,
                            child: const Icon(Icons.chat),
                          ),
                        ),
                      ], //Fim das imagens//
                    ),
                    Center( //Estilização Tab2//
                      child: SingleChildScrollView (
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Construa seu Corpo',
                              style: TextStyle(fontSize: 24),
                            ),
                            const SizedBox(height: 20),
                            Image.asset(
                              'assets/total.png',
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height * 0.6,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Monitoramento',
                              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Image.asset(
                              'assets/monitoramento.png',
                              width: MediaQuery.of(context).size.width,
                              height: 355, //Fim da estilização//
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center( // TAB3 -estrutura de um widget de coluna que contém vários elementos, incluindo um texto e uma imagem.//
                      child: Column( //widget de layout que organiza seus filhos em uma única coluna vertical. Os widgets passados para o parâmetro children são dispostos de cima para baixo.//
                        mainAxisAlignment: MainAxisAlignment.center, //define como os filhos da coluna são alinhados verticalmente. Neste caso, eles são centralizados verticalmente na coluna.//
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Construa seu Corpo',
                            style: TextStyle(fontSize: 24),
                          ),
                          const SizedBox(height: 20),
                          Image.asset(
                            'assets/metas.png',
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.6,
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Column( //TAB 4//
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Smartwatch',
                            style: TextStyle(fontSize: 24),
                          ),
                          const SizedBox(height: 20),
                          Image.asset(
                            isWatchConnected ? 'assets/watch-on.png' : 'assets/watch-off.png', //Relógio em funcionamento//
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.6,
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView( //Puxa a primeira imagem//
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('assets/profile_image.jfif'),
                          ),
                          const SizedBox(height: 20),
                          Text( //Puxar nome //
                            _editedName,
                            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10), //Puxar modal//
                          ElevatedButton(
                            onPressed: () {
                              showEditModal(context);
                            }, //Puxar todas as informações necessárias //
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text('Editar Perfil', style: TextStyle(
                              color: Colors.white,
                            ),),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Plano Atual:',
                            style: TextStyle(fontSize: 18),
                          ),
                          Positioned(
                            top: 215,
                            left: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset( //Imagem abaixo da Tab 5//
                                'assets/kratos_plano.png',
                                width: MediaQuery.of(context).size.width,
                                height: 250,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: const TabBar( //Galeria de Icons//
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.assessment_sharp)),
              Tab(icon: Icon(Icons.book)),
              Tab(icon: Icon(Icons.watch)),
              Tab(icon: Icon(Icons.person)),
            ],
            labelColor: Colors.red,
            unselectedLabelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: Colors.red,
          ),
        ),
      ),
    );
  }

  void showEditModal(BuildContext context) { //Editar Modal //
    // Variáveis para armazenar os valores dos campos
    String editedName = _editedName;
    String editedEmail = '';
    String editedNumber = '';
    String editedPassword = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Perfil'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Campo de edição do nome
              TextFormField(
                initialValue: _editedName,
                decoration: const InputDecoration(labelText: 'Nome'),
                onChanged: (value) {
                  _editedName = value;
                },
              ),
              // Campo de edição do email
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (value) {
                  editedEmail = value;
                },
              ),
              // Campo de edição do número
              TextFormField(
                decoration: const InputDecoration(labelText: 'Número'),
                onChanged: (value) {
                  editedNumber = value;
                },
              ),
              // Campo de edição da senha atual (censurada)
              TextFormField(
                decoration: const InputDecoration(labelText: 'Senha Atual'),
                onChanged: (value) {
                  editedPassword = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                // Aqui você pode adicionar a lógica para salvar as alterações no perfil
                // Por exemplo, pode usar os valores das variáveis editedName, editedEmail, editedNumber, editedPassword
                // para atualizar os dados do usuário
                Navigator.of(context).pop();
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }
}
