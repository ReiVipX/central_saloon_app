import 'package:app_agenda/barbearia.dart';
import 'package:app_agenda/login_page.dart';
import 'package:flutter/material.dart';
import 'espaco_mulher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          title: const Text('Escolha um local'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const BarbeariaPage()), // Navegar para EspacoMulherPage
                  ); // Navigate to Barbearia page
                },
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Opacity(
                      opacity: 0.7,
                      child: Image.asset(
                        'assets/barbearia.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.2),
                      child: const Center(
                        child: Text(
                          'Barbearia',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  // Navigate to Espaço Mulher page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const EspacoMulherPage()), // Navegar para EspacoMulherPage
                  );
                },
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Opacity(
                      opacity: 0.7,
                      child: Image.asset(
                        'assets/salao_beleza.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.2),
                      child: const Center(
                        child: Text(
                          'Espaço Mulher',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
