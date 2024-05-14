import 'package:flutter/material.dart';

void main() {
  runApp(MyChatApp());
}

class MyChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.red,
      ),
      home: MyChatPage(),
    );
  }
}

class MyChatPage extends StatefulWidget {
  @override
  _MyChatPageState createState() => _MyChatPageState();
}

class _MyChatPageState extends State<MyChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Text('${message['_userName']}: ${message['text']}'),
                  subtitle: Text('${message['time']}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Digite sua mensagem...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _sendMessage();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    String messageText = _messageController.text;
    if (messageText.isNotEmpty) {
      DateTime now = DateTime.now();
      String formattedTime = '${now.hour}:${now.minute}';
      Map<String, dynamic> message = {
        '_userName': '_userName', // Substitua pelo nome do usuário
        'text': messageText,
        'time': formattedTime,
      };

      setState(() {
        _messages.add(message);
        _messageController.clear();
      });
    }
  }
}
