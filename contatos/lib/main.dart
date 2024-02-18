import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

  final foto = const CircleAvatar(
    backgroundImage:  AssetImage('perfil.jpg'),
    radius: 150,

  );

  final nome = const Text(
    'Luiz Gustavo Francisco',
    style: TextStyle(fontSize: 30),
    textAlign: TextAlign.center,
  );

  final obs = const Text(
    'Programador Full Stack', 
    style: TextStyle(fontSize: 20, color: Colors.blue),
    textAlign: TextAlign.center,
    
  );

  final botaoTelefone = IconButton(
    color: Colors.blue,
    icon: const Icon(Icons.phone),
    onPressed: (){
      launchUrl(Uri(scheme: 'tel', path: '4497400-9708'));
    },
  );

   final botaoEmail = IconButton(
    color: Colors.blue,
    icon: const Icon(Icons.mail),
    onPressed: (){
      launchUrl(Uri(scheme: 'mailto', path: 'luiz.francisco@docente.pr.senac.br'));
    },
  );

   final botaoSMS = IconButton(
    color: Colors.blue,
    icon: const Icon(Icons.sms),
    onPressed: (){
      launchUrl(Uri(scheme: 'sms', path: '4497400-9708'));
    },
  );

final botaoNavegador = IconButton(
  color: Colors.blue,
  icon: const Icon(Icons.open_in_browser),
  onPressed: () {
    launchUrl(Uri.parse('https://www.example.com'));
  },
);

final botaoCompartilhar = IconButton(
  color: Colors.blue,
  icon: const Icon(Icons.share),
  onPressed: () {
    launchUrl(Uri(
      scheme: 'mailto',
      path: 'mailto:?',
      queryParameters: { 
        'subject': 'Assunto do Email',
        'body': 'Conteúdo para compartilhar',
      },
    ));
  },
);  

final botaoMapa = IconButton(
  color: Colors.blue,
  icon: const Icon(Icons.map),
  onPressed: () {
    launchUrl(Uri.parse('geo:0,0?q=1600+Amphitheatre+Parkway,+Mountain+View,+California'));
  },
);

final botaoCalendario = IconButton(
  color: Colors.blue,
  icon: const Icon(Icons.calendar_today),
  onPressed: () {
    launchUrl(Uri.parse('content://com.android.calendar/time/'));
  },
);


  @override
  Widget build(BuildContext contexto){
    return Scaffold(
      appBar: AppBar(
        title: Text('Acesso ao Contato', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      
      body: Column(
        //centralizando acima e abaixo
        mainAxisAlignment: MainAxisAlignment.center,
        //criando coluna
        children: [
          
          //definindo os elementos da coluna
          foto,
          nome,
          obs,

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
              botaoTelefone, botaoEmail, botaoSMS,     botaoNavegador,
          botaoCompartilhar,
          botaoMapa,
          botaoCalendario,
            ],
          ),
          

        ],
      )
    );
  }
}