// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'home_page.dart'; // Importe a página inicial
import 'cadastro_page.dart'; // Importe a página de cadastro

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  String errorMessage = ''; // Mensagem de erro para exibir

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
                Image.asset(
                  'assets/logo.png',
                  width: 200,
                  height: 200,
                ),
                SizedBox(height: 20),
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
                ElevatedButton(
                  onPressed: () {
                    // Removendo espaços em branco na esquerda e na direita
                    email = email.trim();
                    password = password.trim();

                    if (email == 'admin' && password == 'admin') {
                      print('Login realizado com sucesso!');
                      // Navegar para a página inicial após o login bem-sucedido
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    } else {
                      print('Falhou o login!');
                      // Exibir alerta de login inválido
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
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Botão com cor azul
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white), // Texto branco
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  errorMessage,
                  style: TextStyle(
                    color: Colors.red, // Texto vermelho
                  ),
                ),
                SizedBox(height: 20),
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
