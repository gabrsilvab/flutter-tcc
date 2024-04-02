import 'dart:io';
import 'package:flutter/material.dart';
import 'package:modulo01/widgets/toast.dart';
import 'package:http/http.dart' as http;

class CadastroController {
  static logar(
    String email,
    String senha,
    String nome,
    String usuario,
    String celular,
    File image,
    context,
  ) async {
    try {
      final url = Uri.parse(
        'http://192.168.86.100:3000/tp01/usuarios/cadastro',
      );

      final stream = http.ByteStream(image.openRead());
      final length = await image.length();
      final listFileName = image.path.split('/');
      final fileName = listFileName[listFileName.length - 1];
      final req = http.MultipartRequest('POST', url);

      req.fields['email'] = email;
      req.fields['senha'] = senha;
      req.fields['nome'] = nome;
      req.fields['usuario'] = usuario;
      req.fields['celular'] = celular;

      req.files.add(
        http.MultipartFile('imagem', stream, length, filename: fileName),
      );

      final res = await req.send();

      if (res.statusCode == 201) {
        MyToast.gerarToast('Usuário cadastrado com sucesso!');
        Navigator.pushNamed(context, '/login');
      } else {
        MyToast.gerarToast('Erro ao cadastrar');
      }
    } catch (e) {
      MyToast.gerarToast('Erro ao cadastrar');
    }
  }
}
