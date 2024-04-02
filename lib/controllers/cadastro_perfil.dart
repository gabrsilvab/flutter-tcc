import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modulo01/pages/home.dart';
import 'package:modulo01/widgets/toast.dart';

class CadastroPerfilController {
  static Future<List> getTreinos(token) async {
    try {
      final url = Uri.parse('http://192.168.86.100:3000/tp01/treinos/');

      final req = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));

        return res['resultado'];
      }
      MyToast.gerarToast('Login realizado com sucesso');
      return [];
    } catch (e) {
      MyToast.gerarToast('Erro ao logar');
      return [];
    }
  }

  static Future<List> getDiasSemana(token) async {
    try {
      final url = Uri.parse('http://192.168.86.100:3000/tp01/dias_semanas/');

      final req = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        return res['resultado'];
      }
      MyToast.gerarToast('Erro ao buscar dias da semana');
      return [];
    } catch (e) {
      MyToast.gerarToast('Erro ao buscar dias da semana');
      return [];
    }
  }

  static atualizarPerfil(
    String nascimento,
    String peso,
    String altura,
    String token,
    context,
  ) async {
    try {
      final url = Uri.parse('http://192.168.86.100:3000/tp01/usuarios/');

      final req = await http.put(url, headers: {
        'Authorization': 'Bearer $token'
      }, body: {
        "peso": peso,
        "altura": altura.replaceAll('.', ''),
        "dt_nascimento": nascimento,
      });

      if (req.statusCode == 200) {
        MyToast.gerarToast('Perfil atualizado com sucesso!');
        Navigator.pushNamed(
          context,
          Home.routeName,
          arguments: HomeArguments(token),
        );
      } else {
        MyToast.gerarToast('Erro ao atualizar perfil');
      }
    } catch (e) {
      MyToast.gerarToast('Erro ao atualizar perfil');
    }
  }
}
