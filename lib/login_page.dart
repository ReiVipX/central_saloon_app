// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'home_page.dart'; // Importe a página inicial
import 'cadastro_page.dart'; // Importe a página de cadastro
import 'package:http/http.dart' as http;
import 'dart:convert';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  String errorMessage = ''; // Mensagem de erro para exibir

  Future<void> _login() async {
    // URL da API
    var url = Uri.parse('https://centralsaloon-api.onrender.com/login');

    // Removendo espaços em branco na esquerda e na direita
    email = email.trim();
    password = password.trim();

    // Dados do usuário a serem enviados no corpo da requisição
    var userData = {
      "email": email,
      "senha": password
    };

    try {
      // Realiza a requisição POST
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );

      // Verifica se a requisição foi bem-sucedida
      if (response.body == "true") {
        print("Login bem sucedido!");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        print(response.statusCode);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Erro de Login'),
            content: Text(
                'Email ou senha incorretos. Por favor, tente novamente.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      print('Erro ao processar requisição: $error');
    }    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                // Imagem da logo
                Image.asset(
                  'assets/logo.png',
                  width: 200,
                  height: 200,
                ),
                SizedBox(height: 20),
                
                // Email
                TextField(
                  onChanged: (text) {
                    setState(() {
                      email = text;
                    });
                    print('Email digitado: $text');
                  },
                  style: TextStyle(
                      color: Colors.white), // Define a cor do texto para branco
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(),
                    fillColor: Colors.grey[900],
                    filled: true,
                  ),
                ),
                SizedBox(height: 20),
                
                // Password
                TextField(
                  onChanged: (text) {
                    setState(() {
                      password = text;
                    });
                    print('Senha digitada: $text');
                  },
                  obscureText: true,
                  style: TextStyle(
                      color: Colors.white), // Define a cor do texto para branco
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    fillColor: Colors.grey[900],
                    filled: true,
                  ),
                ),
                SizedBox(height: 20),
                
                // Botão de Login
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Botão com cor azul
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white), // Texto branco
                  ),
                ),
                SizedBox(height: 20),
                
                // Mensagem de erro
                Text(
                  errorMessage,
                  style: TextStyle(
                    color: Colors.red, // Texto vermelho
                  ),
                ),
                SizedBox(height: 20),
                
                // Botão de cadastro
                GestureDetector(
                  onTap: () {
                    // Navegação para a tela de cadastro
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CadastroPage()),
                    );
                  },
                  child: Text(
                    'Cadastre-se',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue, // Texto azul
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
