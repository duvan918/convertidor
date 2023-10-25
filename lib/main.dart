/*
* Aplicaciones Híbridas
* Proyecto final - Convertidor de Monedas
* Desarrollado por Yeison Duvan Franco Rojas
* c.c. 1128452868
* */

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Convertidor de Monedas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Convertidor de Monedas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Map<Divisas, double> exchangeRates = {
    Divisas.COP: 4213.55, // Tasa de cambio COP a USD
    Divisas.USD: 1.0,     // Tasa de cambio USD a USD (1.0 es la tasa base)
    Divisas.EUR: 0.94,    // Tasa de cambio EUR a USD
    Divisas.GBP: 0.82,    // Tasa de cambio GBP a USD
    Divisas.JPY: 149.64   // Tasa de cambio JPY a USD
  };

  Divisas selectedFrom = Divisas.COP;
  Divisas selectedTo = Divisas.USD;
  TextEditingController amountController = TextEditingController(text: "1");
  double convertedAmount = 0.0;

  void convert() {
    setState(() {
      convertedAmount =
          (double.parse(amountController.text) / exchangeRates[selectedFrom]!) *
              exchangeRates[selectedTo]!;
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.deepOrange,
        ),
        body: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 45.0),
          child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Image(image: AssetImage('assets/images/convert.png'),height: 150),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: 'Monto', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 20.0),
                    DropdownButtonFormField(
                      value: selectedFrom,
                      decoration: const InputDecoration(
                          labelText: 'Desde', border: OutlineInputBorder()),
                      onChanged: (newValue) => setState(() {
                        selectedFrom = newValue!;
                      }),
                      items: Divisas.values.map((Divisas divisas) {
                        return DropdownMenuItem(
                          value: divisas,
                          child: Text(divisas.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20.0),
                    IconButton(
                        icon: const Icon(Icons.currency_exchange_sharp, size: 35),
                        onPressed: convert,
                    color: Colors.deepOrange),
                    const SizedBox(height: 20.0),
                    DropdownButtonFormField(
                      value: selectedTo,
                      decoration: const InputDecoration(
                          labelText: 'A', border: OutlineInputBorder()),
                      onChanged: (newValue) => setState(() {
                        selectedTo = newValue!;
                      }),
                      items: Divisas.values.map((Divisas divisas) {
                        return DropdownMenuItem(
                          value: divisas,
                          child: Text(divisas.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      'Resultado: ${convertedAmount.toStringAsFixed(2)} ${selectedTo.name}',
                      style: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ])),
        ));
  }
}

enum Divisas { COP, USD, EUR, GBP, JPY }
