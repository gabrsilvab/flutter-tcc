import 'package:flutter/material.dart';
import 'package:modulo01/controllers/login.dart';
import 'package:modulo01/controllers/validator.dart';
import 'package:modulo01/widgets/toast.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? usuario;
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
    int erros = 0;
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
                              onChanged: (value) => usuario = value,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text(
                                  'Usuário',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  ),
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
                                label: Text(
                                  'Senha',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  ),
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
                                            var res =
                                                await LoginController.logar(
                                              usuario!,
                                              senha!,
                                              context,
                                            );

                                            if (res == 'erro') {
                                              erros++;
                                              if (erros % 3 == 0) {
                                                bloquear();
                                                MyToast.gerarToast(
                                                  'Login bloqueado: aguarde 30s!',
                                                );
                                              }
                                            }
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
                                      color: Colors.white
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
