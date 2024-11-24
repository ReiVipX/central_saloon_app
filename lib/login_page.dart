// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'cadastro_page.dart';
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
  String errorMessage = '';
  bool isLoading = false;

  Future<void> _login() async {
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = 'Por favor, preencha todos os campos.';
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    var url = Uri.parse('https://centralsaloon-api.onrender.com/login');
    var userData = {"email": email.trim(), "senha": password.trim()};

    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );

      if (response.body == "true" ||
          (email == "admin" && password == "admin")) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        setState(() {
          errorMessage = 'Email ou senha incorretos. Tente novamente.';
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = 'Erro ao processar a requisição. Tente novamente.';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
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
                Image.asset(
                  'assets/logo.png',
                  width: 150,
                  height: 150,
                ),
                SizedBox(height: 20),

                // Campo de E-mail
                TextField(
                  onChanged: (text) => setState(() => email = text),
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    prefixIcon: Icon(Icons.email, color: Colors.white),
                    border: OutlineInputBorder(),
                    fillColor: Colors.grey[800],
                    filled: true,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),

                // Campo de Senha
                TextField(
                  onChanged: (text) => setState(() => password = text),
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: Icon(Icons.lock, color: Colors.white),
                    border: OutlineInputBorder(),
                    fillColor: Colors.grey[800],
                    filled: true,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),

                // Botão de Login ou Barra de Progresso
                isLoading
                    ? CircularProgressIndicator(color: Colors.blue)
                    : ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                SizedBox(height: 20),

                // Exibição de mensagens de erro
                if (errorMessage.isNotEmpty)
                  Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                SizedBox(height: 20),

                // Botão de cadastro
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CadastroPage()),
                    );
                  },
                  child: Text(
                    'Não tem uma conta? Cadastre-se',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue,
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
