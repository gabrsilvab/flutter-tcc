// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api

import 'package:flutter/material.dart'; //Importar classe //

Future<void> fetchData() async { //Conectar API //
  var http;
  final response = await http.get(Uri.parse('http://10.91.234.33:3000/clientes/cadastroCartao'));
  if (response.statusCode == 200) {
    // Dados foram buscados com sucesso
    print(response.body);
  } else {
    // Houve um erro ao buscar os dados
    print('Falha ao buscar dados: ${response.statusCode}');
  }
}

void main() {
  runApp(PaginaPagamento());
}

class PaginaPagamento extends StatelessWidget { //Verificar informações //
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), // Definindo o tema escuro
      home: Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              FormularioPagamento(),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login'); // Redirecionamento para /login
                },
                child: Text('Ir para Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FormularioPagamento extends StatefulWidget {
  const FormularioPagamento({super.key});

  @override
  _FormularioPagamentoState createState() => _FormularioPagamentoState();
}

class _FormularioPagamentoState extends State<FormularioPagamento> { // As classes do Formulário //
  final _formKey = GlobalKey<FormState>();

  String digitos_cartao = '';
  String bandeira_cartao = '';
  String titular_cartao = '';
  String vencimento_cartao = '';
  String cvv_cartao = '';
  String cep = '';
  String endereco_cobranca = '';
  String complemento = '';
  String bairro = '';
  String cidade = '';
  String uf = '';

  @override
  Widget build(BuildContext context) {
    return Form( // Estilização do site //
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Detalhes do Cartão:',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          TextFormField( // Inserir número do cartão //
            decoration: InputDecoration(
              labelText: 'Número do Cartão',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red), // Definindo a cor vermelha para o texto
              ),
            ),
            onChanged: (value) {
              setState(() {
                digitos_cartao = value;
              });
            },
            validator: (value) { 
              if (value!.isEmpty) { // Inserir número do cartão //
                return 'Por favor, insira o número do cartão';
              }
              return null;
            },
          ),
          TextFormField( // Inserir bandeira //
            decoration: InputDecoration(labelText: 'Bandeira'),
            onChanged: (value) {
              setState(() {
                bandeira_cartao = value;
              });
            },
          ),
          TextFormField( //  Inserir Titular do cartão //
            decoration: InputDecoration(
              labelText: 'Titular do Cartão',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red), // Definindo a cor vermelha para o texto
              ),
            ),
            onChanged: (value) {
              setState(() {
                titular_cartao = value;
              });
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor, insira o titular do cartão';
              }
              return null;
            },
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField( //Inserir vencimento do cartão //
                  decoration: InputDecoration(labelText: 'Vencimento'),
                  onChanged: (value) {
                    setState(() {
                      vencimento_cartao = value;
                    });
                  },
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: TextFormField( //Inserir CVV do cartão //
                  decoration: InputDecoration(labelText: 'CVV'),
                  onChanged: (value) {
                    setState(() {
                      cvv_cartao = value;
                    });
                  },
                ),
              ),
            ],
          ),
          const Text(
            'Endereço de Cobrança:', // Inserir endereço de cobrança //
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          TextFormField( // Inserir CEP //
            decoration: InputDecoration(labelText: 'CEP'),
            onChanged: (value) {
              setState(() {
                cep = value;
              });
            },
          ),
          TextFormField( // Inserir endereço //
            decoration: InputDecoration(labelText: 'Endereço'),
            onChanged: (value) {
              setState(() {
                endereco_cobranca = value;
              });
            },
          ),
          TextFormField( //Inserir Complemento //
            decoration: InputDecoration(labelText: 'Complemento'),
            onChanged: (value) {
              setState(() {
                complemento = value;
              });
            },
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField( // Inserir Bairro //
                  decoration: InputDecoration(labelText: 'Bairro'),
                  onChanged: (value) {
                    setState(() {
                      bairro = value;
                    });
                  },
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Cidade'),
                  onChanged: (value) {
                    setState(() {
                      cidade = value;
                    });
                  },
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'UF'),
                  onChanged: (value) {
                    setState(() {
                      uf = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
