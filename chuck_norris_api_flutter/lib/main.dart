import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String apiKey = 'e331ef36547c4b18a6c0d49a45d5f0d3'; // Insira sua chave de API aqui
  late String city = 'London'; // Cidade padrão

  late Future<Weather> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
  }

  Future<Weather> fetchWeather() async {
    final response = await http.get(Uri.https(
      'api.openweathermap.org',
      '/data/2.5/weather',
      {'q': city, 'appid': apiKey, 'units': 'metric'},
    ));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return Weather.fromJson(data);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Digite a cidade',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    city = value;
                    futureWeather = fetchWeather();
                  });
                },
              ),
            ),
            FutureBuilder<Weather>(
              future: futureWeather,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  Weather weather = snapshot.data!;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Cidade: ${weather.city}',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Temperatura: ${weather.temperature}°C',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Condição: ${weather.condition}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Weather {
  final String city;
  final double temperature;
  final String condition;

  Weather({
    required this.city,
    required this.temperature,
    required this.condition,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['name'],
      temperature: json['main']['temp'],
      condition: json['weather'][0]['description'],
    );
  }
}