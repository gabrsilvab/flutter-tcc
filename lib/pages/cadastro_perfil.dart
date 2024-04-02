import 'package:flutter/material.dart';
import 'package:modulo01/controllers/cadastro_perfil.dart';
import 'package:modulo01/controllers/validator.dart';
import 'package:modulo01/styles/styles.dart';

class CadastroPerfil extends StatefulWidget {
  const CadastroPerfil({super.key});
  static const routeName = '/cadastroPerfil';

  @override
  State<CadastroPerfil> createState() => _CadastroPerfilState();
}

class CadastroPerfilArguments {
  final String nome;
  final String email;
  final String token;

  CadastroPerfilArguments(this.nome, this.email, this.token);
}

class _CadastroPerfilState extends State<CadastroPerfil> {
  List<bool> exercicios = [false, false, false];
  List<List<bool>> diasExercicios = [
    [false, false, false, false, false, false, false],
    [false, false, false, false, false, false, false],
    [false, false, false, false, false, false, false],
  ];

  String? peso;
  String? altura;
  double? imc;
  List<String> horario = ['00:00', '00:00', '00:00'];
  String msg = 'Calcule para saber seu resultado';

  final _formKey = GlobalKey<FormState>();

  calcularIMC() {
    int pesoInt = int.parse(peso!);
    double alturaInt = double.parse(altura!);

    imc = pesoInt / (alturaInt * alturaInt);

    if (imc! < 18.5) {
      msg =
          'Seu IMC é de: ${imc.toString().substring(0, 4)}, o que indica MAGREZA!';
    }
    if (imc! >= 18.5 && imc! < 24.9) {
      msg =
          'Seu IMC é de: ${imc.toString().substring(0, 4)}, o que indica NORMAL!';
    }
    if (imc! >= 25 && imc! < 29.9) {
      msg =
          'Seu IMC é de: ${imc.toString().substring(0, 4)}, o que indica SOBREPESO!';
    }
    if (imc! >= 30 && imc! < 29.9) {
      msg =
          'Seu IMC é de: ${imc.toString().substring(0, 4)}, o que indica OBESIDADE!';
    }
    if (imc! >= 40) {
      msg =
          'Seu IMC é de: ${imc.toString().substring(0, 4)}, o que indica OBESIDADE GRAVE!';
    }
  }

  DateTime? _dataSelecionada;

  Future<void> _selecionarData(BuildContext context) async {
    final dataEscolhida = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 18),
      firstDate: DateTime(DateTime.now().year - 150),
      lastDate: DateTime(
        DateTime.now().year - 18,
        DateTime.now().month,
        DateTime.now().day,
      ),
    );

    if (dataEscolhida != null && dataEscolhida != _dataSelecionada) {
      setState(() {
        _dataSelecionada = dataEscolhida;
      });
    }
  }

  setHorario(int i) async {
    final a = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (a != null) {
      setState(() {
        horario[i] = '${a.hour} : ${a.minute}';
      });
    }
  }

  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    final args =
        ModalRoute.of(context)!.settings.arguments as CadastroPerfilArguments;

    return Scaffold(
        body: FutureBuilder(
      future: Future.wait([
        CadastroPerfilController.getTreinos(args.token),
        CadastroPerfilController.getDiasSemana(args.token)
      ]),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List res = snapshot.data!;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Seja bem-vindo(a)',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: Fontes.fonte,
                          color: Cores.ciano,
                        ),
                      ),
                      Container(height: 10),
                      Text(
                        'Como esse é seu primeiro acesso, precisamos de mais algumas informações para continuar!',
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: Fontes.fonte,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Container(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await _selecionarData(context);
                            setState(() {
                              if (_dataSelecionada != null) {
                                _controller.text = _dataSelecionada
                                    .toString()
                                    .substring(0, 11);
                              }
                            });
                          },
                          child: TextFormField(
                            controller: _controller,
                            keyboardType: TextInputType.name,
                            validator: (value) =>
                                ValidarDadosCadastroPerfil.validarNascimento(
                              value!,
                            ),
                            onChanged: (value) => peso = value,
                            enabled: false,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.calendar_month),
                              border: const OutlineInputBorder(),
                              label: Text(
                                'Data de nascimento',
                                style: TextStyle(
                                  fontFamily: Fontes.fonte,
                                  color: Cores.cinza,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          validator: (value) =>
                              ValidarDadosCadastroPerfil.validarDados(
                            value!,
                          ),
                          onChanged: (value) => peso = value,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            border: const OutlineInputBorder(),
                            label: Text(
                              'Peso',
                              style: TextStyle(
                                fontFamily: Fontes.fonte,
                                color: Cores.cinza,
                              ),
                            ),
                          ),
                        ),
                        Container(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) =>
                              ValidarDadosCadastroPerfil.validarDados(
                            value!,
                          ),
                          onChanged: (value) => altura = value,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.accessibility),
                            border: const OutlineInputBorder(),
                            label: Text(
                              'Altura',
                              style: TextStyle(
                                fontFamily: Fontes.fonte,
                                color: Cores.cinza,
                              ),
                            ),
                          ),
                        ),
                        Container(height: 10),
                        Text(
                          'Resultado: $msg',
                          style: TextStyle(
                            fontFamily: Fontes.fonte,
                            color: Cores.cinza,
                          ),
                        ),
                        Container(height: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    calcularIMC();
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(width, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Calcular',
                                style: TextStyle(
                                  fontFamily: Fontes.fonte,
                                  color: Cores.ciano,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(height: 20),
                  Text(
                    'Treino semanal',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: Fontes.fonte,
                      color: Cores.ciano,
                    ),
                  ),
                  for (int i = 0; i < res[0].length; i++)
                    Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: exercicios[i],
                              onChanged: (value) => setState(() {
                                exercicios[i] = !exercicios[i];
                              }),
                            ),
                            Text(
                              '${res[0][i]['nome']}',
                              style: TextStyle(
                                fontFamily: Fontes.fonte,
                                color: Cores.cinza,
                              ),
                            ),
                            Container(width: 15),
                            Row(
                              children: [
                                Text(horario[i]),
                                IconButton(
                                  onPressed: exercicios[i]
                                      ? () => setHorario(i)
                                      : null,
                                  icon: Icon(
                                    Icons.timer,
                                    color: Cores.cinza,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            for (int e = 0; e < res[1].length; e++)
                              Column(
                                children: [
                                  Checkbox(
                                    value: diasExercicios[i][e],
                                    onChanged: exercicios[i]
                                        ? (value) => setState(() {
                                              diasExercicios[i][e] =
                                                  !diasExercicios[i][e];
                                            })
                                        : null,
                                  ),
                                  Text(
                                    '${res[1][e]["codigo"]}',
                                    style: TextStyle(
                                      fontFamily: Fontes.fonte,
                                      color: Cores.cinza,
                                    ),
                                  ),
                                ],
                              )
                          ],
                        ),
                      ],
                    ),
                  Container(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        CadastroPerfilController.atualizarPerfil(
                          _dataSelecionada.toString().substring(0, 11),
                          peso!,
                          altura!,
                          args.token,
                          context,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(width, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Salvar',
                      style: TextStyle(
                        fontFamily: Fontes.fonte,
                        color: Cores.ciano,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}
