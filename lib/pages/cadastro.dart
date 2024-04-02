import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:modulo01/controllers/login.dart';
import 'package:modulo01/controllers/validator.dart';
// ignore: unused_import
import 'package:modulo01/widgets/toast.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  String? nome;
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
                  'assets/menu-cadastrar.png', // Altere para o caminho da sua imagem do menu
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
                              onChanged: (value) => nome = value,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Nome',
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20), // Espaçamento aumentado
                            TextFormField(
                              enabled: enabled,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) =>
                                  ValidarDadosLogin.validarDados(
                                value!,
                              ),
                              onChanged: (value) => email = value,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'E-mail',
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
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
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Senha',
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 60), // Espaçamento aumentado
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: enabled
                                      ? () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            // Implementar a lógica de cadastro aqui
                                            // nome, email e senha são acessíveis aqui
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
                                    'Cadastrar',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold, // Negrito
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Já possui conta?',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Colors.white,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: enabled
                                          ? () => Navigator.pushNamed(
                                                context,
                                                '/login',
                                              )
                                          : null,
                                      child: const Text(
                                        'Faça login',
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
