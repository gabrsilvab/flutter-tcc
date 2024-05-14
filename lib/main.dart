import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modulo01/pages/cadastro.dart';
import 'package:modulo01/pages/cadastro_perfil.dart';
import 'package:modulo01/pages/chat.dart';
import 'package:modulo01/pages/home.dart';
import 'package:modulo01/pages/login.dart';
import 'package:modulo01/pages/pagamento.dart';
// ignore: unused_import
import 'package:modulo01/pages/recupera.dart';
import 'package:modulo01/pages/splash.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/splash': (context) => const Splash(),
        Home.routeName: (context) =>  const Home(userName: 'User',),
        '/login': (context) => const Login(),
        '/cadastro': (context) => const Cadastro(),
        '/pagamento': (context) => const Cadastro(),
        '/recupera': (context) => RecuperarSenhaPage(),
        '/chat': (context) =>  MyChatApp(),
        // ignore: equal_keys_in_map
        '/pagamento': (context) =>  PaginaPagamento(),
        CadastroPerfil.routeName: (context) => const CadastroPerfil(),
      },
      initialRoute: '/splash',
    );
  }
}
