import 'package:flutter/material.dart';
import 'package:modulo01/controllers/recupera.dart';

//CRIA CLASSES IMPORTANTES
class RecuperarSenhaPage extends StatefulWidget {
  @override
  _RecuperarSenhaPageState createState() => _RecuperarSenhaPageState();
}

class _RecuperarSenhaPageState extends State<RecuperarSenhaPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _codigoController = TextEditingController();
  RecuperarSenhaController _controller = RecuperarSenhaController();
  String _mensagem = '';
  bool _showEmailForm = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    //ELE COLOCA A IMAGEM DO "MENU-LOGIN"
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/menu-login.png',
              fit: BoxFit.cover,
            ),
          ),
          //ESCREVE O E-MAIL PARA O USUÁRIO RECEBER O CÓDIGO DE "ESQUECEU SENHA"
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: width,
              height: height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  _showEmailForm
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: _emailController,
                              enabled: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'E-mail',
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                ),
                              ),
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                _enviarEmail();
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(width, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: Colors.white,
                              ),
                              //TEXTO "ENVIAR E-MAIL DE RECUPERAÇÃO
                              child: Text(
                                'Enviar E-mail de Recuperação',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //TEXTO
                            TextField(
                              controller: _codigoController,
                              enabled: true,
                              keyboardType: TextInputType.number,
                              maxLength: 6,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Código de Recuperação',
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                ),
                              ),
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                              ),
                            ),
                            //VALIDAR O CÓDIGO
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                _validarCodigo();
                              //CAMPO DE ESCRITA DO CÓDIGO DE RECUPERAÇÃO DE SENHA
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(width, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: Colors.white,
                              ),
                              //BOTÃO DE "ENVIAR"
                              child: Text(
                                'Enviar',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                  //QUANDO O CÓDIGO FOR ENVIADO, O USUÁRIO RECEBERÁ UMA NOTIFICAÇÃO AVISANDO QUE O PROCESSO FOI FEITO
                  const SizedBox(height: 10),
                  Text(
                    _mensagem,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: _mensagem.contains('sucesso') ? Colors.black : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //VERIFICA SE O CAMPO "E-MAIL" NÃO ESTÁ VAZIO
  void _enviarEmail() async {
    String email = _emailController.text;
    bool enviadoComSucesso = await _controller.enviarEmailRecuperacao(email);

    if (enviadoComSucesso) {
      setState(() {
        _mensagem = 'E-mail de recuperação enviado com sucesso';
        _showEmailForm = false;
      });
    } else {
      setState(() {
        _mensagem = 'Erro ao enviar e-mail de recuperação';
      });
    }
  }

  //SIMULAÇÃO COM O CÓDIGO PADRÃO
  void _validarCodigo() {
    String codigo = _codigoController.text;

    if (codigo == '111111') {
      // Show dialog before redirection
      //AVISA QUE A SENHA FOI TROCADA
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.red[900],
            title: Text(
              "Senha Trocada",
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              "Sua senha foi trocada com sucesso.",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              //BOTÃO QUE FARÁ O USUÁRIO VOLTAR A TELA DE LOGIN
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/login');
                },
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      );
    //SE O CÓDIGO ESTIVER ERRADO ELE IRÁ DAR UM ALERTA
    } else {
      setState(() {
        _mensagem = 'Código incorreto. Por favor, tente novamente.';
      });
    }
  }
}
