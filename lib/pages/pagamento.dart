import 'package:flutter/material.dart';


Future<void> fetchData() async {
  var http;
  final response =
      await http.get(Uri.parse('http://10.91.234.33:3000/clientes/registrar_cartoes'));
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


class PaginaPagamento extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          labelStyle: TextStyle(color: Colors.white), // Texto do rótulo branco
        ),
      ),
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
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text(
                  'Ir para Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class FormularioPagamento extends StatefulWidget {
  const FormularioPagamento({Key? key}) : super(key: key);


  @override
  _FormularioPagamentoState createState() => _FormularioPagamentoState();
}


class _FormularioPagamentoState extends State<FormularioPagamento> {
  final _formKey = GlobalKey<FormState>();


  String digitos_cartao = '';
  String bandeira_cartao = 'Visa';
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
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Detalhes do Cartão:',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Número do Cartão',
            ),
            onChanged: (value) {
              setState(() {
                digitos_cartao = value;
              });
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor, insira o número do cartão';
              }
              return null;
            },
          ),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: 'Bandeira'),
            value: bandeira_cartao,
            onChanged: (value) {
              setState(() {
                bandeira_cartao = value!;
              });
            },
            items: <String>[
              'Visa',
              'Mastercard',
              'American Express (Amex)',
              'Elo',
              'Hipercard',
              'Diners Club International'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(color: Colors.white), // Texto branco
                ),
              );
            }).toList(),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Titular do Cartão',
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
                child: TextFormField(
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
                child: TextFormField(
                  keyboardType: TextInputType.number,
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
            'Endereço de Cobrança:',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'CEP'),
            onChanged: (value) {
              setState(() {
                cep = value;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Endereço'),
            onChanged: (value) {
              setState(() {
                endereco_cobranca = value;
              });
            },
          ),
          TextFormField(
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
                child: TextFormField(
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



