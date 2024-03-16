import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversor de Moeda',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CurrencyConverter(),
    );
  }
}

class CurrencyConverter extends StatefulWidget {
  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  double _amount = 0.0;
  double _conversionRate = 0.0;
  String _selectedFromCurrency = 'USD'; // Moeda padrão é Dólar
  String _selectedToCurrency = 'BRL'; // Moeda padrão é Real
  bool _isLoading = false;

  void _fetchConversionRate() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse('https://api.exchangerate-api.com/v4/latest/$_selectedFromCurrency'));
    final responseData = json.decode(response.body);

    setState(() {
      _conversionRate = responseData['rates'][_selectedToCurrency];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversor de Moeda'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Quantidade'),
                    onChanged: (value) {
                      setState(() {
                        _amount = double.tryParse(value) ?? 0.0;
                      });
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: DropdownButton<String>(
                    value: _selectedFromCurrency,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedFromCurrency = newValue!;
                      });
                    },
                    items: <String>['USD', 'BRL', 'EUR', 'GBP', 'JPY', 'CAD', 'AUD']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox(), // Placeholder para alinhar os elementos
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: DropdownButton<String>(
                    value: _selectedToCurrency,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedToCurrency = newValue!;
                      });
                    },
                    items: <String>['BRL', 'USD', 'EUR', 'GBP', 'JPY', 'CAD', 'AUD']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _fetchConversionRate();
              },
              child: _isLoading ? CircularProgressIndicator() : Text('Converter'),
            ),
            SizedBox(height: 20),
            Text(
              'Valor convertido: ${(_amount * _conversionRate).toStringAsFixed(2)} $_selectedToCurrency',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}