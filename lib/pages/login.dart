// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modulo01/controllers/login.dart';
import 'package:modulo01/controllers/validator.dart'; 
import 'package:modulo01/widgets/toast.dart'; //importar as extensões necessárias//

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? email;
  String? senha;
  final _formKey = GlobalKey<FormState>();

  bool obscureText = true;
  bool enabled = true;

  bloquear() async {
    setState(() {
      enabled = false;
    });

    await Future.delayed(const Duration(seconds: 30));

    setState(() {
      enabled = true;
    });
  }

  Future<void> realizarLogin() async {
    final url = Uri.parse('http://10.91.234.33:3000/clientes/cadastro');
    try {
      final response = await http.post(
        url,
        body: {
          'email': email!,
          'senha': senha!,
        },
      );

      if (response.statusCode == 200) {
        // Login bem-sucedido
        Navigator.pushNamed(context, '/tela_de_inicio'); // Substitua pelo nome da tela de início
      } else {
        // Login falhou
        MyToast.gerarToast('Credenciais inválidas');
      }
    } catch (e) {
      // Erro ao fazer a requisição
      print('Erro ao realizar login: $e');
      MyToast.gerarToast('Erro ao realizar login');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/menu-login.png', // Altere para o caminho da sua imagem do menu
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: width,
                  height: height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 100), // Espaçamento aumentado
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              enabled: enabled,
                              keyboardType: TextInputType.name,
                              validator: (value) =>
                                  ValidarDadosLogin.validarDados(
                                value!,
                              ),
                              onChanged: (value) => email = value,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'e-mail',
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red), // Cor vermelha quando focado
                                ),
                              ),
                            ),
                            const SizedBox(height: 20), // Espaçamento aumentado
                            TextFormField(
                              enabled: enabled,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) =>
                                  ValidarDadosLogin.validarDados(
                                value!,
                              ),
                              obscureText: obscureText,
                              onChanged: (value) => senha = value,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Senha',
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red), // Cor vermelha quando focado
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      obscureText = !obscureText;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 20), // Espaçamento aumentado
                            TextButton(
                           onPressed: () {
                  Navigator.pushNamed(context, '/recupera'); // Substitua pelo nome da rota da página de recuperação de senha
  },
                   child: const Text('Esqueceu a senha?',style: TextStyle(
                   fontFamily: 'Montserrat',
                   color: Colors.white,
                   ),
                     ),
                      ),
                            const SizedBox(height: 40), // Espaçamento aumentado
                           ElevatedButton(
  onPressed: enabled
      ? () async {
          if (_formKey.currentState!.validate()) {
            await realizarLogin();
          }
        }
      : null,
  style: ElevatedButton.styleFrom(
    fixedSize: Size(width, 40),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  child: const Text(
    'Entrar',
    style: TextStyle(
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.bold, // Negrito
      color: Colors.white,
    ),
  ),
),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Não possui conta?',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  ),
                                ),
                                TextButton(
                                  onPressed: enabled
                                      ? () => Navigator.pushNamed(
                                            context,
                                            '/cadastro',
                                          )
                                      : null,
                                  child: const Text(
                                    'Cadastre-se',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
