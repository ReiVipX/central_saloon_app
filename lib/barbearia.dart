import 'package:flutter/material.dart';
import 'package:app_agenda/home_page.dart';

class Register {
  DateTime? _registeredSelectedDate;
  String? _registeredSelectedTime;
  String? _registeredSelectedService;
  String? _registeredSelectedState;
  String? _registeredSelectedCity;
  String? _registeredSelectedEnterprise;

  aaa() {
    
  }
}

class BarbeariaPage extends StatefulWidget {
  const BarbeariaPage({Key? key}) : super(key: key);

  @override
  State<BarbeariaPage> createState() => _BarbeariaPageState();
}

class _BarbeariaPageState extends State<BarbeariaPage> {
  DateTime? selectedDate;
  String? selectedTime;
  String? selectedService;
  String? selectedState;
  String? selectedCity;
  String? selectedEnterprise;
  bool isLocationInvisible = false;
  bool isServiceInvisible = true;


  final List<String> services = [
    'Corte de Cabelo',
    'Barba',
    'Tosa e Aparo',
    'Tratamentos Capilares',
    'Coloração',
    'Ritual de Barbear Clássico',
    'Tratamentos Faciais',
    'Venda de Produtos',
    'Consultoria de Estilo'
  ];

  final List<String> availableTimes = [
    '08:00',
    '09:00',
    '10:00',
    '11:00',
    '14:00',
    '15:00',
    '17:00',
    '18:00',
    '19:00',
    '20:00',
  ];

  final List<dynamic> enterpriseLocation = [
    {
      "estados": [

        { // Estado SP
          "sigla": "SP",
          "nome": "São Paulo",
          "cidades": {
            "São Paulo": [
              [1, "Barbearia barbixas"],
              [2, "Barbearia dois irmãos"],
              [3, "Barbearia trato feito"],
            ], // São Paulo
            "Campo Limpo Paulista": [
              [4, "Barbearia bons de corte"],
              [5, "Barbearia da esquina"],
              [6, "Corte na hora barbearia"],
            ], // Campo Limpo Paulista
          }, // Cidades
        }, // Estado SP

        { // Estado RJ
          "sigla": "RJ",
          "nome": "Rio de Janeiro",
          "cidades": {
            "Rio de Janeiro": [
              [7, "Barbearia dos crias"],
              [8, "Barbearia favela venceu"],
              [9, "Barbearia pão de açucar"],
            ], // Rio de Janeiro
            "Volta Redonda": [
              [10, "Barbearia dos bruxos"],
              [11, "Barbearia irmãos na causa"],
              [12, "Barbearia vapt-vupt"],
            ], // Volta Redonda
          } // Cidades
        } // Estado RJ

      ], // Estados  
    }
  ];

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
            
            IconButton(icon: Icon(Icons.pin_drop), onPressed: null),
            
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                if (isLocationInvisible == true && isServiceInvisible == false) {
                  Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const BarbeariaPage()),
                );  
                }else{
                  Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
                }   
              },
            ),

          ],
        ),
        body: Container(  
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Offstage( // Location
                offstage: isLocationInvisible,
                child: Column(
                  children: [
                    const Text(
                      'Selecione o estado',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      items: enterpriseLocation[0]["estados"].map<DropdownMenuItem<String>>((estado) {
                        String estadoNome = estado["nome"]; // Obtém o nome do estado
                        return DropdownMenuItem<String>(
                          value: estadoNome,
                          child: Text(estadoNome),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 50), // Espaço em branco

                    const Text(
                      'Selecione a cidade',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                        ? (enterpriseLocation[0]['estados']
                          .firstWhere((estado) => estado['nome'] == selectedState)['cidades']
                          as Map<String, dynamic>)
                          .keys
                          .map<DropdownMenuItem<String>>((cidade) {
                            return DropdownMenuItem<String>(
                              value: cidade,
                              child: Text(cidade),
                            );
                          }).toList(): [], // Lista vazia se nenhum estado estiver selecionado
                    ),
                    const SizedBox(height: 50), // Espaço em branco

                    const Text(
                      'Selecione a barbearia',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),

                    DropdownButton<dynamic>(
                      value: selectedEnterprise,
                      hint: const Text('Barbearias'),
                      onChanged: (newValue) {
                        setState(() {
                          selectedEnterprise = newValue;
                        });
                      },
                      items: selectedState != null && selectedCity != null
                        ? (enterpriseLocation[0]['estados']
                            .firstWhere((estado) => estado['nome'] == selectedState)['cidades'][selectedCity]
                            as List<dynamic>)
                            .map<DropdownMenuItem<String>>((barbearia) {
                              return DropdownMenuItem<String>(
                                value: barbearia[1],
                                child: Text(barbearia[1]),
                              );
                            }).toList()
                        : [], // Lista vazia se nenhum estado ou cidade estiver selecionado
                    ),
                    const SizedBox(height: 50), // Espaço em branco

                    ElevatedButton(
                      onPressed: () {
                        if (selectedState != null && selectedCity != null && selectedEnterprise != null) {
                          setState(() {
                            isLocationInvisible = true;
                            isServiceInvisible = false;
                          });
                        }
                      },
                      child: const Text('Prosseguir'),
                    )
                    
                  ],
                ),
              ),
              
              Offstage( // Service
              
                offstage: isServiceInvisible,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Selecione o serviço:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    
                    DropdownButton<String>(
                      value: selectedService,
                      hint: const Text('Selecione o serviço'),
                      onChanged: (newValue) {
                        setState(() {
                          selectedService = newValue;
                        });
                      },
                      items: services
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),                   
                    const SizedBox(height: 20),
                    
                    const Text(
                      'Selecione a data:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    
                    ElevatedButton(
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2025),
                        );
                        if (picked != null && picked != selectedDate) {
                          setState(() {
                            selectedDate = picked;
                          });
                        }
                      },
                      child: Text(
                        selectedDate != null
                            ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                            : 'Selecione a data',
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    const Text(
                      'Selecione o horário:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    
                    DropdownButton<String>(
                      value: selectedTime,
                      hint: const Text('Selecione o horário'),
                      onChanged: (newValue) {
                        setState(() {
                          selectedTime = newValue;
                        });
                      },
                      items: availableTimes
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    
                    ElevatedButton(
                      onPressed: () {
                        if (selectedService != null &&
                            selectedTime != null &&
                            selectedDate != null) {
                          Register r = Register();

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Agendamento Confirmado'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Serviço: $selectedService'),
                                    Text(
                                        'Data: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'),
                                    Text('Horário: $selectedTime'),
                                  ],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Erro'),
                                content: const Text(
                                    'Por favor, selecione o serviço, a data e o horário.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: const Text('Agendar'),
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
