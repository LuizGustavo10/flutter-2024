import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todos os Widgets',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Todos os Widgets Flutter'),
        ),


        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text('Text Widget'),
              Text(
                'Texto com estilo',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),

              Divider(),
              Image.network(
                'https://cdn-icons-png.flaticon.com/512/2175/2175188.png',
                width: 150.0,
                height: 150.0,
              ),
              Divider(),

              Icon(
                Icons.favorite,
                size: 50.0,
                color: Colors.red,
              ),
              Divider(),

              ElevatedButton(
                onPressed: () {},
                child: Text('Botão Elevado'),
              ),

              Divider(),
              TextButton(
                onPressed: () {},
                child: Text('Botão de Texto'),
              ),

              Divider(),
              OutlinedButton(
                onPressed: () {},
                child: Text('Botão Contornado'),
              ),

              Divider(),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Campo de Texto',
                  border: OutlineInputBorder(),
                ),
              ),

              Divider(),
              Checkbox(
                value: true,
                onChanged: (value) {},
              ),

              Divider(),
              Radio(
                value: true,
                groupValue: true,
                onChanged: (value) {},
              ),

              Divider(),
              Switch(
                value: true,
                onChanged: (value) {},
              ),

              Divider(),
              Slider(
                value: 0.5,
                onChanged: (value) {},
              ),

              Divider(),
              CircularProgressIndicator(),

              Divider(),
              LinearProgressIndicator(),

              Divider(),
              DropdownButton<String>(
                value: 'Opção 1',
                onChanged: (value) {},
                items: ['Opção 1', 'Opção 2', 'Opção 3']
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        ))
                    .toList(),
              ),

              Divider(),
              Card(
                child: ListTile(
                  leading: Icon(Icons.star),
                  title: Text('Item de Lista em um Card'),
                  subtitle: Text('Descrição do item'),
                  onTap: () {},
                ),
              ),

              Divider(),
              Container(
                height: 50.0,
                width: 50.0,
                color: Colors.blue,
              ),

              Divider(),
              ClipOval(
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  color: Colors.orange,
                ),
              ),

              Divider(),
              Wrap(
                children: [
                  Chip(
                    label: Text('Chip 1'),
                  ),
                  Chip(
                    label: Text('Chip 2'),
                  ),
                  Chip(
                    label: Text('Chip 3'),
                  ),
                ],
              ),
              
              // Adicione mais widgets conforme necessário
            ],
          ),
        ),
      ),
    );
  }
}