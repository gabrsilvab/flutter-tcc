class ValidarDadosLogin {
  static validarDados(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }
}

class ValidarDadosCadastro {
  static validarNome(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }

    if (!value.contains(' ')) {
      return 'Obrigatório dois nomes';
    }

    if (value.indexOf(' ') + 1 == value.length || value.indexOf(' ') == 0) {
      return 'Obrigatório dois nomes';
    }

    return null;
  }

  static validarEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }

    if (!value.contains('@')) {
      return 'Obrigatório @';
    }

    if (value.indexOf('@') < 6) {
      return "Obrigatório 6 caracteres antes do '@'";
    }

    if (value.substring(value.length - 4) != '.com' &&
        value.substring(value.length - 7) != '.com.br') {
      return 'Termine com ".com" ou ".com.br"';
    }

    if (value.substring(value.length - 4) == '.com') {
      String txt = value.substring(value.indexOf('@') + 1);
      txt = txt.replaceAll('.com', '');
      if (txt.length < 3) {
        return 'Mínimo de 3 dígitos após o @';
      }
    }

    if (value.substring(value.length - 7) == '.com.br') {
      String txt = value.substring(value.indexOf('@') + 1);
      txt = txt.replaceAll('.com.br', '');
      if (txt.length < 3) {
        return 'Mínimo de 3 dígitos após o @';
      }
    }

    if (value[0].contains(RegExp(r'[0-9]'))) {
      return 'Não pode iniciar em número';
    }

    for (int i = 0; i < value.length; i++) {
      if (!value[i].contains(RegExp(r'[A-Z]')) &&
          !value[i].contains(RegExp(r'[a-z]')) &&
          !value[i].contains(RegExp(r'[0-9]')) &&
          !value[i].contains('_') &&
          !value[i].contains('@') &&
          !value[i].contains('.')) {
        return 'Email possuí caracteres inválidos';
      }
    }

    return null;
  }

  static validarCelular(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  static validarUsuario(String? value) {
    int letrasMaiusculas = 0;
    int letrasMinusculas = 0;
    int numeros = 0;

    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }

    if (value.length < 6) {
      return "Deve ter no mínimo 6 caracteres";
    }

    if (value[0].contains(RegExp(r'[0-9]'))) {
      return 'Não pode iniciar em número';
    }

    for (int i = 0; i < value.length; i++) {
      if (!value[i].contains(RegExp(r'[A-Z]')) &&
          !value[i].contains(RegExp(r'[a-z]')) &&
          !value[i].contains(RegExp(r'[0-9]')) &&
          !value[i].contains('_') &&
          !value[i].contains('.')) {
        return 'Usuário possuí caracteres inválidos';
      }
    }

    for (int i = 0; i < value.length; i++) {
      if (value[i].contains(RegExp(r'[A-Z]'))) {
        letrasMaiusculas++;
      }
      if (value[i].contains(RegExp(r'[a-z]'))) {
        letrasMinusculas++;
      }
      if (value[i].contains(RegExp(r'[0-9]'))) {
        numeros++;
      }
    }

    if (letrasMinusculas < 1) {
      return 'Deve conter pelo menos uma letra minúscula';
    }
    if (letrasMaiusculas < 1) {
      return 'Deve conter pelo menos uma letra maiuscula';
    }
    if (numeros < 1) {
      return 'Deve conter pelo menos um número';
    }

    return null;
  }

  static validarSenha(String? value) {
    int letrasMaiusculas = 0;
    int letrasMinusculas = 0;
    int numeros = 0;

    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }

    if (value.length < 8) {
      return "Deve ter no mínimo 8 caracteres";
    }

    for (int i = 0; i < value.length; i++) {
      if (!value[i].contains(RegExp(r'[A-Z]')) &&
          !value[i].contains(RegExp(r'[a-z]')) &&
          !value[i].contains(RegExp(r'[0-9]')) &&
          !value[i].contains('_') &&
          !value[i].contains('.')) {
        return 'Senha possuí caracteres inválidos';
      }
    }

    for (int i = 0; i < value.length; i++) {
      if (value[i].contains(RegExp(r'[A-Z]'))) {
        letrasMaiusculas++;
      }
      if (value[i].contains(RegExp(r'[a-z]'))) {
        letrasMinusculas++;
      }
      if (value[i].contains(RegExp(r'[0-9]'))) {
        numeros++;
      }
    }

    if (letrasMinusculas < 1) {
      return 'Deve conter pelo menos uma letra minúscula';
    }
    if (letrasMaiusculas < 1) {
      return 'Deve conter pelo menos uma letra maiuscula';
    }
    if (numeros < 2) {
      return 'Deve conter pelo menos dois números';
    }

    return null;
  }

  static validarConfirmarSenha(String? senha, String? confirmarSenha) {
    if (confirmarSenha == null || confirmarSenha.isEmpty) {
      return 'Campo obrigatório';
    }

    if (senha != confirmarSenha) {
      return 'As senhas são diferentes';
    }

    return null;
  }
}

class ValidarDadosCadastroPerfil {
  static validarDados(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }

    for (int i = 0; i < value.length; i++) {
      if (!value[i].contains(RegExp(r'[0-9]')) && value[i] != '.') {
        return 'Apenas números';
      }
    }

    return null;
  }

  static validarNascimento(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }

    return null;
  }
}
