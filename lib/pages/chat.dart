import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(MyChatApp());
}

class MyChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        backgroundColor: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    Tab1Page(userName: "User"), // Passando o nome de usuário para a página da tab1
    Tab2Page(), // Página da tab2
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: '',
          ),
        ],
        selectedItemColor: Colors.red, // Define a cor vermelha para o ícone selecionado
      ),
    );
  }
}

class Tab1Page extends StatefulWidget {
  final String userName; // Adicionando uma variável para armazenar o nome do usuário

  Tab1Page({required this.userName}); // Modificando o construtor para receber o nome do usuário

  @override
  _Tab1PageState createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: [
          IconButton(
            icon: Icon(Icons.clear, color: Colors.red), // Definindo a cor vermelha para o ícone
            onPressed: () {
              _clearMessages(); // Limpa as mensagens ao selecionar "Limpar mensagens"
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/homechat.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void _clearMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('messages'); // Remove as mensagens do SharedPreferences

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Mensagens limpas'),
    ));

    // Atualiza o estado para refletir a remoção das mensagens
    setState(() {});
  }
}

class Tab2Page extends StatefulWidget {
  @override
  _Tab2PageState createState() => _Tab2PageState();
}

class _Tab2PageState extends State<Tab2Page> {
  final List<Map<String, dynamic>> _messages = [];
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMessages(); // Carrega as mensagens ao iniciar a página
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: [
          IconButton(
            icon: Icon(Icons.clear, color: Colors.red), // Definindo a cor vermelha para o ícone
            onPressed: () {
              _clearMessages(); // Limpa as mensagens ao selecionar "Limpar mensagens"
            },
          ),
        ],
      ),
      body: _messages.isEmpty
          ? Center(
              child: Image.asset(
                'assets/sem_mensagem.png',
                width: 200.0,
                height: 200.0,
              ),
            )
          : ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Text(
                    '${message['_userName']}: ${message['text']}',
                  ),
                  subtitle: Text(
                    '${message['time']}',
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            controller: _messageController,
            decoration: InputDecoration(
              hintText: 'Digite sua mensagem...',
              hintStyle: TextStyle(color: Colors.red), // Definindo a cor do texto como vermelho
              focusedBorder: OutlineInputBorder( // Adicionando a borda vermelha quando o campo está em foco
                borderSide: BorderSide(color: Colors.red),
              ),
              enabledBorder: OutlineInputBorder( // Adicionando a borda vermelha quando o campo não está em foco
                borderSide: BorderSide(color: Colors.red),
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  _sendMessage(_messageController.text);
                  _messageController.clear(); // Limpa o campo de texto após enviar a mensagem
                },
              ),
            ),
            onSubmitted: (value) {
              _sendMessage(value);
              _messageController.clear(); // Limpa o campo de texto após enviar a mensagem
            },
          ),
        ),
      ),
    );
  }

  void _sendMessage(String? text) async {
    if (text != null) {
      DateTime now = DateTime.now();
      String formattedTime = '${now.hour}:${now.minute}';
      Map<String, dynamic> message = {
        '_userName': 'User', // Substitua pelo nome do usuário
        'text': text, // Usando o texto digitado pelo usuário
        'time': formattedTime,
      };

      setState(() {
        _messages.add(message);
      });

      // Salva as mensagens no SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
        'messages',
        _messages.map((msg) => json.encode(msg)).toList(), // Correção aqui
      );
    }
  }

  void _loadMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedMessages = prefs.getStringList('messages');
    if (savedMessages != null) {
      setState(() {
        _messages.clear();
        savedMessages.forEach((text) {
          _messages.add(json.decode(text)); // Correção aqui
        });
      });
    }
  }

  void _clearMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('messages'); // Remove as mensagens do SharedPreferences

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Mensagens limpas'),
    ));

    // Atualiza o estado para refletir a remoção das mensagens
    setState(() {
      _messages.clear();
    });
  }

  @override
  void dispose() {
    // Dispose do controlador quando não for mais necessário
    _messageController.dispose();
    super.dispose();
  }
}
