import 'package:flutter/material.dart';
import 'package:modulo01/controllers/home.dart';
import 'package:modulo01/styles/styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static const routeName = '/home';

  @override
  State<Home> createState() => _HomeState();
}

class HomeArguments {
  final String token;

  HomeArguments(this.token);
}

class _HomeState extends State<Home> {
  gerarModal() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'VitaHealth - V1.0',
          style: TextStyle(
            fontFamily: Fontes.fonte,
            color: Cores.cinza,
          ),
        ),
        content: Text(
          'Renan Coelho - Senai928',
          style: TextStyle(
            fontFamily: Fontes.fonte,
            color: Cores.cinza,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: Text(
              'OK',
              style: TextStyle(
                fontFamily: Fontes.fonte,
                color: Cores.cinza,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as HomeArguments;

    return FutureBuilder(
      future: HomeController.getDadosUser(args.token, context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List data = snapshot.data as List;
          String img = data[2].replaceFirst(':3000/', 'localhost');
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Text(
                    'Vita',
                    style: TextStyle(
                      fontFamily: Fontes.fonte,
                      color: Cores.vermelho,
                    ),
                  ),
                  Text(
                    'Health',
                    style: TextStyle(
                      fontFamily: Fontes.fonte,
                      color: Cores.ciano,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () => gerarModal(),
                  icon: const Icon(Icons.info_outline_rounded),
                ),
              ],
            ),
            drawer: Drawer(
              child: Column(
                children: [
                  DrawerHeader(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Cores.cinza),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(img, fit: BoxFit.cover),
                          ),
                        ),
                        Container(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data[0],
                              style: TextStyle(
                                fontFamily: Fontes.fonte,
                                color: Cores.cinza,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              data[1],
                              style: TextStyle(
                                fontFamily: Fontes.fonte,
                                color: Cores.cinza,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.home),
                        title: Text(
                          'Home',
                          style: TextStyle(
                            fontFamily: Fontes.fonte,
                            color: Cores.cinza,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.accessibility),
                        title: Text(
                          'Exercícios',
                          style: TextStyle(
                            fontFamily: Fontes.fonte,
                            color: Cores.cinza,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.attach_money_rounded),
                        title: Text(
                          'WS Coin',
                          style: TextStyle(
                            fontFamily: Fontes.fonte,
                            color: Cores.cinza,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.shopping_cart_outlined),
                        title: Text(
                          'Loja',
                          style: TextStyle(
                            fontFamily: Fontes.fonte,
                            color: Cores.cinza,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.settings),
                        title: Text(
                          'Configurações',
                          style: TextStyle(
                            fontFamily: Fontes.fonte,
                            color: Cores.cinza,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.logout),
                        onTap: () => Navigator.pushNamed(context, '/login'),
                        title: Text(
                          'Sair',
                          style: TextStyle(
                            fontFamily: Fontes.fonte,
                            color: Cores.cinza,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Para melhorar o bem-estar e manter o corpo das pessoas mais saudáveis, a startup IANES desenvolveu o aplicativo VitaHealth que permite seus usuários obter e monitorar as informações corporais, como também planejar, definir metas e receber notificações sobre as atividades físicas. Para garantir a acessibilidade do seu aplicativo, a startup IANES decidiu criar um projeto para melhorar a usabilidade do aplicativo para todos os seus usuários, incluindo aqueles com restrições de visão, daltonismo, dificuldades auditivas, comprometimento da coordenação motora, deficiências cognitivas e muitas outras deficiências. ',
                  style: TextStyle(
                    fontFamily: Fontes.fonte,
                    color: Cores.cinza,
                  ),
                ),
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
