import 'package:app_agenda/home_page.dart';
import 'package:flutter/material.dart';

class EspacoMulherPage extends StatefulWidget {
  const EspacoMulherPage({super.key});

  @override
  State<EspacoMulherPage> createState() => _EspacoMulherPageState();
}

class _EspacoMulherPageState extends State<EspacoMulherPage> {
  DateTime? selectedDate;
  String? selectedTime;
  String? selectedService;
  String? selectedState;
  String? selectedCity;
  String? selectedEnterprise;
  String searchQuery = ''; // Para o campo de pesquisa
  bool isLocationInvisible = false;
  bool isServiceInvisible = true;

  final List<String> services = [
    'Corte de Cabelo',
    'Coloração',
    'Manicure',
    'Pedicure',
    'Maquiagem',
  ];

  final List<String> availableTimes = [
    '09:00',
    '10:00',
    '11:00',
    '14:00',
    '15:00',
    '16:00',
  ];

  final List<dynamic> enterpriseLocation = [
    {
      "estados": [
        {
          "sigla": "SP",
          "nome": "São Paulo",
          "cidades": {
            "São Paulo": [
              [1, "Barbearia barbixas"],
              [2, "Barbearia dois irmãos"],
              [3, "Barbearia trato feito"],
            ],
            "Campo Limpo Paulista": [
              [4, "Barbearia bons de corte"],
              [5, "Barbearia da esquina"],
              [6, "Corte na hora barbearia"],
            ],
          },
        },
        {
          "sigla": "RJ",
          "nome": "Rio de Janeiro",
          "cidades": {
            "Rio de Janeiro": [
              [7, "Barbearia dos crias"],
              [8, "Barbearia favela venceu"],
              [9, "Barbearia pão de açucar"],
            ],
            "Volta Redonda": [
              [10, "Barbearia dos bruxos"],
              [11, "Barbearia irmãos na causa"],
              [12, "Barbearia vapt-vupt"],
            ],
          }
        }
      ],
    }
  ];

  List<String> filteredServices = []; // Para pesquisa de serviços

  @override
  void initState() {
    super.initState();
    filteredServices = services; // Inicializar a lista filtrada
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredServices = services
          .where(
              (service) => service.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.grey[900],
        textTheme: ThemeData.dark().textTheme.apply(
              bodyColor: Colors.white,
            ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Agendamento'),
          actions: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: updateSearchQuery,
                decoration: InputDecoration(
                  hintText: 'Pesquisar serviço...',
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.grey[800],
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Offstage(
                offstage: isLocationInvisible,
                child: Column(
                  children: [
                    const Text(
                      'Selecione o estado',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    DropdownButton<dynamic>(
                      value: selectedState,
                      hint: const Text('Estados'),
                      onChanged: (newValue) {
                        selectedCity = null;
                        setState(() {
                          selectedState = newValue;
                        });
                      },
                      items: enterpriseLocation[0]["estados"]
                          .map<DropdownMenuItem<String>>((estado) {
                        String estadoNome = estado["nome"];
                        return DropdownMenuItem<String>(
                          value: estadoNome,
                          child: Text(estadoNome),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Selecione a cidade',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    DropdownButton<dynamic>(
                      value: selectedCity,
                      hint: const Text('Cidades'),
                      onChanged: (newValue) {
                        setState(() {
                          selectedEnterprise = null;
                          selectedCity = newValue;
                        });
                      },
                      items: selectedState != null
                          ? (enterpriseLocation[0]['estados'].firstWhere(
                                      (estado) =>
                                          estado['nome'] ==
                                          selectedState)['cidades']
                                  as Map<String, dynamic>)
                              .keys
                              .map<DropdownMenuItem<String>>((cidade) {
                              return DropdownMenuItem<String>(
                                value: cidade,
                                child: Text(cidade),
                              );
                            }).toList()
                          : [],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              Offstage(
                offstage: isServiceInvisible,
                child: Column(
                  children: [
                    const Text(
                      'Serviços disponíveis',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredServices.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(filteredServices[index]),
                            onTap: () {
                              setState(() {
                                selectedService = filteredServices[index];
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
