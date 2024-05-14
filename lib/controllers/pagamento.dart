import 'package:flutter/material.dart';

void main() {
  runApp(PaginaPagamento());
}

class PaginaPagamento extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pagamento'),
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: FormularioPagamento(),
        ),
      ),
    );
  }
}

class FormularioPagamento extends StatefulWidget {
  @override
  _FormularioPagamentoState createState() => _FormularioPagamentoState();
}

class _FormularioPagamentoState extends State<FormularioPagamento> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

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
            controller: _textController,
            decoration: InputDecoration(labelText: 'Número do Cartão'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor, insira o número do cartão';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _textController,
            decoration: InputDecoration(labelText: 'Bandeira'),
          ),
          TextFormField(
            controller: _textController,
            decoration: InputDecoration(labelText: 'Titular do Cartão'),
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
                  controller: _textController,
                  decoration: InputDecoration(labelText: 'Vencimento'),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: TextFormField(
                  controller: _textController,
                  decoration: InputDecoration(labelText: 'CVV'),
                ),
              ),
            ],
          ),
          Text(
            'Endereço de Cobrança:',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            controller: _textController,
            decoration: InputDecoration(labelText: 'CEP'),
          ),
          TextFormField(
            controller: _textController,
            decoration: InputDecoration(labelText: 'Endereço'),
          ),
          TextFormField(
            controller: _textController,
            decoration: InputDecoration(labelText: 'Complemento'),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  controller: _textController,
                  decoration: InputDecoration(labelText: 'Bairro'),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: TextFormField(
                  controller: _textController,
                  decoration: InputDecoration(labelText: 'Cidade'),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: TextFormField(
                  controller: _textController,
                  decoration: InputDecoration(labelText: 'UF'),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Center(
            child: RaisedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Processo de envio do formulário
                }
              },
              child: Text('Enviar'),
            ),
          ),
        ],
      ),
    );
  }
}

RaisedButton({required Null Function() onPressed, required Text child}) {
}
