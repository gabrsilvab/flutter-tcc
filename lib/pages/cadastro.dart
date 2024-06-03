import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modulo01/controllers/validator.dart'; 

// Classe principal da tela de cadastro, que é um StatefulWidget
class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  State<Cadastro> createState() => _CadastroState();
}

// Estado da classe Cadastro
class _CadastroState extends State<Cadastro> {
  // Variáveis para armazenar os dados do formulário
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

  // Chave para o formulário
  final _formKey = GlobalKey<FormState>();

  // Variáveis de controle de exibição
  bool obscureText = true;
  bool enabled = true;

  // Função para simular o envio de dados para um Workbench
  Future<void> enviarParaWorkbench() async {
    print('Enviando dados para o Workbench');
    await Future.delayed(Duration(seconds: 2));
    print('Dados enviados para o Workbench com sucesso');
  }

  // Função para realizar o cadastro enviando os dados para a API
  Future<void> realizarCadastro() async {
    final url = Uri.parse('http://10.91.234.33:3000/clientes/cadastro');
    try {
      final response = await http.post(
        url,
        body: {
          'nome': nome!,
          'sobrenome': sobrenome!,
          'email': email!,
          'senha': senha!,
          'cpf': cpf!,
          'data_nascimento': data_nascimento!,
          'nacionalidade': nacionalidade!,
          'ddd': ddd!,
          'telefone': telefone!,
          'genero': genero!,
          'aceitarTermos': aceitarTermos.toString(),
        },
      );

      // Verifica o status da resposta da API
      if (response.statusCode == 201) {
        Navigator.pushReplacementNamed(context, '/pagamento');
      } else {
        print('Erro ao cadastrar: ${response.body}');
      }
    } catch (e) {
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
              // Imagem de cabeçalho
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: height * 0.3,
                  child: Image.asset(
                    'assets/menu-cadastrar.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Formulário de cadastro
              Padding(
                padding: EdgeInsets.only(top: height * 0.3 + 20, left: 20, right: 20),
                child: SizedBox(
                  width: width,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Campo de nome
                              TextFormField(
                                enabled: enabled,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, insira seu nome';
                                  }
                                  return null;
                                },
                                onChanged: (value) => nome = value,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  labelText: 'Nome',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Campo de sobrenome
                              TextFormField(
                                enabled: enabled,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, insira seu sobrenome';
                                  }
                                  return null;
                                },
                                onChanged: (value) => sobrenome = value,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  labelText: 'Sobrenome',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Campo de email
                              TextFormField(
                                enabled: enabled,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty || !value.contains('@')) {
                                    return 'Por favor, insira um email válido';
                                  }
                                  return null;
                                },
                                onChanged: (value) => email = value,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Campo de senha
                              TextFormField(
                                enabled: enabled,
                                obscureText: obscureText,
                                keyboardType: TextInputType.visiblePassword,
                                validator: (value) {
                                  if (value == null || value.length < 6) {
                                    return 'A senha deve ter pelo menos 6 caracteres';
                                  }
                                  return null;
                                },
                                onChanged: (value) => senha = value,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  labelText: 'Senha',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      obscureText ? Icons.visibility : Icons.visibility_off,
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
                              const SizedBox(height: 20),
                              // Campo de CPF
                              TextFormField(
                                enabled: enabled,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty || value.length != 11) {
                                    return 'Por favor, insira um CPF válido com 11 dígitos';
                                  }
                                  return null;
                                },
                                onChanged: (value) => cpf = value,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  labelText: 'CPF',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Campo de data de nascimento
                              TextFormField(
                                enabled: enabled,
                                keyboardType: TextInputType.datetime,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, insira uma data de nascimento válida';
                                  }
                                  return null;
                                },
                                onChanged: (value) => data_nascimento = value,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  labelText: 'Data de Nascimento',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Campo de nacionalidade
                              TextFormField(
                                enabled: enabled,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, insira sua nacionalidade';
                                  }
                                  return null;
                                },
                                onChanged: (value) => nacionalidade = value,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  labelText: 'Nacionalidade',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Campo de DDD
                              TextFormField(
                                enabled: enabled,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty || value.length != 2) {
                                    return 'Por favor, insira um DDD válido com 2 dígitos';
                                  }
                                  return null;
                                },
                                onChanged: (value) => ddd = value,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  labelText: 'DDD',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Campo de telefone
                              TextFormField(
                                enabled: enabled,
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value == null || value.isEmpty || value.length < 8 || value.length > 9) {
                                    return 'Por favor, insira um telefone válido';
                                  }
                                  return null;
                                },
                                onChanged: (value) => telefone = value,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  labelText: 'Telefone',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Campo de gênero
                              TextFormField(
                                enabled: enabled,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, insira seu gênero';
                                  }
                                  return null;
                                },
                                onChanged: (value) => genero = value,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  labelText: 'Gênero',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Checkbox para aceitar termos
                              CheckboxListTile(
                                title: const Text(
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
                              const SizedBox(height: 60),
                              // Botão de cadastro
                              ElevatedButton(
                                onPressed: enabled
                                    ? () async {
                                        if (_formKey.currentState!.validate()) {
                                          await realizarCadastro();
                                          if (cadastradoComSucesso) {
                                            Navigator.pushNamed(context, '/login');
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
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Exibição de mensagem de sucesso
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
                                      const Text(
                                        'Cadastro realizado com sucesso!',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context, '/pagamento');
                                        },
                                        child: const Text(
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
