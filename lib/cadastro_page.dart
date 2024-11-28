// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();

  String _nome = '';
  String _email = '';
  String _telefone = '';
  String _endereco = '';
  String _cpf = '';
  String _senha = '';
  String _confirmarSenha = '';
  String _dataNascimento = '';

  void _buscarEnderecoPorCEP() {
    // Simulação da busca do endereço pelo CEP
    String cep = _cepController.text;
    // Aqui você pode implementar a lógica real para buscar o endereço pelo CEP
    String endereco = 'Rua Nome da Rua, 123';
    _enderecoController.text = endereco;
  }

  Future<void> _cadastrarUsuario() async {
    // URL da API
    var url = Uri.parse('https://centralsaloon-api.onrender.com/cadastro');

    String cep = _cepController.text;

    // Dados do usuário a serem enviados no corpo da requisição
    var userData = {
      "nome": _nome,
      "data_nascimento": _dataNascimento,
      "cep": cep,
      "endereco": _endereco,
      "cpf" : _cpf,
      "email": _email,
      "celular": _telefone,
      "senha": _senha
    };

    try {
      // Realiza a requisição POST
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );

      // Verifica se a requisição foi bem-sucedida
      if (response.statusCode == 201) {
        print('Usuário cadastrado com sucesso!');
      } else {
        print('Falha ao cadastrar usuário!');
        print(response.statusCode);
      }
    } catch (error) {
      print('Erro ao processar requisição: $error');
    }

    // Após o cadastro, redireciona para a tela de login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        // Definindo o tema dark
        scaffoldBackgroundColor: Colors.grey[900], // Cor de fundo dark
        textTheme: ThemeData.dark().textTheme.apply(
              bodyColor: Colors.white, // Definindo a cor do texto para branco
            ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cadastro'),
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
          ],
        ),
        backgroundColor: Colors.grey[900], // Fundo dark
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              
              // Nome
              TextField(
                onChanged: (value) {
                  setState(() {
                    _nome = value;
                  });
                },
                style: TextStyle(
                    color:
                        Colors.white), // Definindo a cor do texto para branco
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              
              TextField(
                onChanged: (value) {
                  setState(() {
                    _dataNascimento = value;
                  });
                },
                style: TextStyle(color: Colors.white), // Definindo a cor do texto para branco
                decoration: InputDecoration(
                  labelText: 'Data de Nascimento',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _dataNascimento = _dataNascimento.replaceAll('/', '-');
                  });
                },
                child: Text('Enviar'),
              ),
              
              // CEP
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _cepController,
                      onChanged: (value) {
                        // Adicione a lógica para buscar o endereço pelo CEP aqui
                      },
                      style: TextStyle(
                          color: Colors
                              .white), // Definindo a cor do texto para branco
                      decoration: InputDecoration(
                        labelText: 'CEP',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _buscarEnderecoPorCEP,
                    child: Text('Buscar'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              
              // Endereço
              TextField(
                controller: _enderecoController,
                onChanged: (value) {
                  setState(() {
                    _endereco = value;
                  });
                },
                style: TextStyle(
                    color:
                        Colors.white), // Definindo a cor do texto para branco
                decoration: InputDecoration(
                  labelText: 'Endereço',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              
              // CPF
              TextField(
                onChanged: (value) {
                  setState(() {
                    _cpf = value;
                  });
                },
                style: TextStyle(
                    color:
                        Colors.white), // Definindo a cor do texto para branco
                decoration: InputDecoration(
                  labelText: 'CPF',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              
              // Email
              TextField(
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
                style: TextStyle(
                    color:
                        Colors.white), // Definindo a cor do texto para branco
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              
              // Telefone
              TextField(
                onChanged: (value) {
                  setState(() {
                    _telefone = value;
                  });
                },
                style: TextStyle(
                    color:
                        Colors.white), // Definindo a cor do texto para branco
                decoration: InputDecoration(
                  labelText: 'Número de Telefone',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              
              // Senha
              TextField(
                onChanged: (value) {
                  setState(() {
                    _senha = value;
                  });
                },
                obscureText: true,
                style: TextStyle(
                    color:
                        Colors.white), // Definindo a cor do texto para branco
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              
              // Confirmar Senha
              TextField(
                onChanged: (value) {
                  setState(() {
                    _confirmarSenha = value;
                  });
                },
                obscureText: true,
                style: TextStyle(
                    color:
                        Colors.white), // Definindo a cor do texto para branco
                decoration: InputDecoration(
                  labelText: 'Confirmar Senha',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              
              // Cadastrar
              ElevatedButton(
                onPressed: _cadastrarUsuario,
                child: Text('Cadastrar'),
              ),
            
            ],
          ),
        ),
      ),
    );
  }
}
