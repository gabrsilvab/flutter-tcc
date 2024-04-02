import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:modulo01/widgets/toast.dart';

class HomeController {
  static getDadosUser(String token, context) async {
    try {
      final url = Uri.parse('http://192.168.86.100:3000/tp01/usuarios/');

      final req = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        print(res);
        return [
          res['dados_usuario']['nome'],
          res['dados_usuario']['email'],
          res['dados_usuario']['imagem_url'].replaceAll('localhost', ''),
        ];
      }
    } catch (e) {
      MyToast.gerarToast('Erro ao buscar dados do usuário');
    }
  }
}
