import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modulo01/controllers/validator.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  String? nome;
  String? sobrenome;
  String? email;
  String? senha;
  String? cpf;
  String? data_nascimento;
  String? nacionalidade;
  String? ddd;
  String? telefone;
  String? genero;
  bool aceitarTermos = false;
  bool cadastradoComSucesso = false;

  final _formKey = GlobalKey<FormState>();

  bool obscureText = true;
  bool enabled = true;

  Future<void> enviarParaWorkbench() async {
    // Envie os dados para o Workbench aqui
    print('Enviando dados para o Workbench');
    // Exemplo de requisição fictícia para o Workbench
    // Substitua esta linha pela lógica real de envio para o Workbench
    await Future.delayed(Duration(seconds: 2)); // Simulando uma requisição
    print('Dados enviados para o Workbench com sucesso');
  }

  Future<void> realizarCadastro() async {
    final url = Uri.parse('http://10.91.234.33:3000/clientes/cadastro');
    try {
      final response = await http.post(
        url,
        body: {
          'nome': nome!,
          'sobrenome': sobrenome!,
          'email': email!,
          'senha': senha!, // Incluído campo senha no corpo da requisição
          'cpf': cpf!,
          'data_nascimento': data_nascimento!,
          'nacionalidade': nacionalidade!,
          'ddd': ddd!,
          'telefone': telefone!,
          'genero': genero!,
          'aceitarTermos': aceitarTermos.toString(),
        },
      );

      if (response.statusCode == 200) {
        // Cadastro bem-sucedido
        await enviarParaWorkbench(); // Enviar para o Workbench
        setState(() {
          cadastradoComSucesso = true;
        });
      } else {
        // Cadastro falhou
        print('Erro ao cadastrar: ${response.body}');
      }
    } catch (e) {
      // Erro ao fazer a requisição
      print('Erro ao realizar cadastro: $e');
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
                child: SizedBox(
                  height: height * 0.3, // Altura da imagem ajustável
                  child: Image.asset(
                    'assets/menu-cadastrar.png', // Altere para o caminho da sua imagem do menu
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: height * 0.3 + 20, left: 20, right: 20),
                child: SizedBox(
                  width: width,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20), // Espaçamento aumentado
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
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors
                                          .red, // Cor do texto quando selecionado
                                    ),
                                  ),
                                  labelText: 'Nome',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  height: 20), // Espaçamento aumentado
                              TextFormField(
                                enabled: enabled,
                                keyboardType: TextInputType.name,
                                validator: (value) =>
                                    ValidarDadosLogin.validarDados(
                                  value!,
                                ),
                                onChanged: (value) => sobrenome = value,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors
                                          .red, // Cor do texto quando selecionado
                                    ),
                                  ),
                                  labelText: 'Sobrenome',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  height: 20), // Espaçamento aumentado
                              TextFormField(
                                enabled: enabled,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) =>
                                    ValidarDadosLogin.validarDados(
                                  value!,
                                ),
                                onChanged: (value) => email = value,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors
                                          .red, // Cor do texto quando selecionado
                                    ),
                                  ),
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  height: 20), // Espaçamento aumentado
                              TextFormField(
                                enabled: enabled,
                                obscureText: true, // Campo de senha
                                keyboardType: TextInputType.visiblePassword,
                                validator: (value) =>
                                    ValidarDadosLogin.validarDados(
                                  value!,
                                ),
                                onChanged: (value) => senha = value,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors
                                          .red, // Cor do texto quando selecionado
                                    ),
                                  ),
                                  labelText: 'Senha',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  height: 20), // Espaçamento aumentado
                              TextFormField(
                                enabled: enabled,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) =>
                                    ValidarDadosLogin.validarDados(
                                  value!,
                                ),
                                onChanged: (value) => cpf = value,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors
                                          .red, // Cor do texto quando selecionado
                                    ),
                                  ),
                                  labelText: 'CPF',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  height: 20), // Espaçamento aumentado
                              TextFormField(
                                enabled: enabled,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) =>
                                    ValidarDadosLogin.validarDados(
                                  value!,
                                ),
                                onChanged: (value) => data_nascimento = value,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors
                                          .red, // Cor do texto quando selecionado
                                    ),
                                  ),
                                  labelText: 'Data de Nascimento',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  height: 20), // Espaçamento aumentado
                              TextFormField(
                                enabled: enabled,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) =>
                                    ValidarDadosLogin.validarDados(
                                  value!,
                                ),
                                onChanged: (value) => nacionalidade = value,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors
                                          .red, // Cor do texto quando selecionado
                                    ),
                                  ),
                                  labelText: 'Nacionalidade',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  height: 20), // Espaçamento aumentado
                              TextFormField(
                                enabled: enabled,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) =>
                                    ValidarDadosLogin.validarDados(
                                  value!,
                                ),
                                onChanged: (value) => ddd = value,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors
                                          .red, // Cor do texto quando selecionado
                                    ),
                                  ),
                                  labelText: 'DDI',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  height: 20), // Espaçamento aumentado
                              TextFormField(
                                enabled: enabled,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) =>
                                    ValidarDadosLogin.validarDados(
                                  value!,
                                ),
                                onChanged: (value) => telefone = value,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors
                                          .red, // Cor do texto quando selecionado
                                    ),
                                  ),
                                  labelText: 'telefone',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  height: 20), // Espaçamento aumentado
                              TextFormField(
                                enabled: enabled,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) =>
                                    ValidarDadosLogin.validarDados(
                                  value!,
                                ),
                                onChanged: (value) => genero = value,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors
                                          .red, // Cor do texto quando selecionado
                                    ),
                                  ),
                                  labelText: 'Gênero',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  height: 20), // Espaçamento aumentado
                              CheckboxListTile(
                                title: Text(
                                  'Aceitar termos',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  ),
                                ),
                                value: aceitarTermos,
                                onChanged: (value) {
                                  setState(() {
                                    aceitarTermos = value!;
                                  });
                                },
                              ),
                              const SizedBox(
                                  height: 60), // Espaçamento aumentado
                              ElevatedButton(
                                onPressed: enabled
                                    ? () async {
                                        if (_formKey.currentState!.validate()) {
                                          await realizarCadastro();
                                          if (cadastradoComSucesso) { 
                                            Navigator.pushNamed(
                                                context, '/login');
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
                                  'Cadastrar',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold, // Negrito
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (cadastradoComSucesso)
                          Container(
                            color: Colors.black.withOpacity(0.8),
                            child: Center(
                              child: Card(
                                color: Colors.red,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Cadastro realizado com sucesso!',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/pagamento');
                                        },
                                        child: Text(
                                          'Ir para o pagamento',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
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
