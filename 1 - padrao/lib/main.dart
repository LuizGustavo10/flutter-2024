import 'package:flutter/material.dart';


// A função main inicia a execução, e runApp inicia o aplicativo, passando um widget chamado MyApp 
// como componente principal. Em Flutter, os aplicativos são construídos com a composição de widgets, 
// representando a estrutura visual do aplicativo.

void main() {
  runApp(const MyApp());
}

//class MyApp extends StatelessWidget { ... }: Define uma classe chamada MyApp que herda de StatelessWidget.
// Em Flutter, StatelessWidget é uma classe base para widgets que não precisam manter um estado interno mutável.

//A classe MyApp é um widget no Flutter que não mantém estado interno mutável (StatelessWidget). 
//Ela possui um construtor que opcionalmente aceita uma chave (key) para identificação única,
// sendo boa prática usar chaves para facilitar a eficiência na gestão e atualização de widgets.

//const MyApp({Key? key}): Declara um construtor para a classe MyApp. 
//O construtor aceita um parâmetro opcional chamado key do tipo Key?. A chave (key) 
//é usada para identificar exclusivamente um widget, 
//facilitando o Flutter a gerenciar e atualizar a interface do usuário de maneira eficiente.

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Este widget é a raiz da sua aplicação.
 // @override: Uma anotação que indica que o método que segue está substituindo 
 //um método da classe pai. No contexto do Flutter, geralmente isso significa que você está 
 //substituindo o método build da classe pai StatelessWidget ou StatefulWidget.]

 //Widget build(BuildContext context): Este é o método que você está substituindo. 
 //Ele é responsável por construir e retornar a hierarquia de widgets que compõem o 
 //visual do widget em questão. O parâmetro BuildContext context fornece informações sobre 
 //a posição do widget na árvore de widgets, como o tema atual ou a localização na tela.
 
  @override
  Widget build(BuildContext context) {

    //MaterialApp é um widget fundamental no framework Flutter, utilizado para configurar 
    //e definir características específicas de um aplicativo que segue as diretrizes de design 
    //do Material Design, que é um conjunto de diretrizes de design visual desenvolvido pelo Google.

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       // Este é o tema da sua aplicação.
        //
        // TENTE ISTO: Tente executar sua aplicação com "flutter run". Você vai ver
        // a aplicação possui uma barra de ferramentas roxa. Então, sem sair do aplicativo,
        //tente alterar seedColor no colorScheme abaixo para Colors.green
        // e então invocar "hot reload" (salve suas alterações ou pressione o botão "hot
        // recarregar" em um IDE compatível com Flutter ou pressione "r" se você usou
        //a linha de comando para iniciar o aplicativo).
        //
        // Observe que o contador não foi zerado; a aplicação
        // o estado não é perdido durante a recarga. Para redefinir o estado, use hot
        // em vez disso, reinicie.
        //
        // Isso também funciona para código, não apenas para valores: a maioria das alterações de código podem ser
        // testado apenas com uma recarga a quente.

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

//A classe MyHomePage é um widget no Flutter que pode manter um estado mutável, 
//pois estende StatefulWidget. Isso permite que a interface do usuário seja dinamicamente 
//atualizada em resposta a eventos, entrada do usuário ou mudanças nos dados. A classe _MyHomePageState 
//é criada para gerenciar o estado mutável associado a esse widget.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // Este widget é a página inicial da sua aplicação. É Stateful, o que significa
  // que possui um objeto State (definido abaixo) que contém campos que afetam
  // como parece.

  // Esta classe é a configuração do estado. Ele contém os valores (neste
  // caso o título) fornecido pelo pai (neste caso, o widget do aplicativo) e
  // usado pelo método build do Estado. Os campos em uma subclasse Widget são
  // sempre marcado como "final".

  final String title;


//Em resumo, esse trecho de código é essencial para a criação do estado associado ao widget MyHomePage 
//quando necessário, permitindo a dinâmica atualização da interface do usuário com base em eventos, entrada do usuário ou mudanças nos dados.
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //colocando contador
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      // Esta chamada para setState informa ao framework Flutter que algo aconteceu
      // alterado neste estado, o que faz com que ele execute novamente o método de construção abaixo
      // para que a exibição possa refletir os valores atualizados. Se nós mudássemos
      // _counter sem chamar setState(), então o método build não seria
      // ligou novamente e nada pareceu acontecer.
      _counter++;
    });
  }

//classe de construção
  @override
  Widget build(BuildContext context) {
   // Este método é executado novamente toda vez que setState é chamado, por exemplo, como feito
    // pelo método _incrementCounter acima.
    //
    // A estrutura Flutter foi otimizada para executar novamente métodos de construção
    // rápido, para que você possa reconstruir qualquer coisa que precise ser atualizada
    // do que ter que alterar individualmente as instâncias dos widgets.
    return Scaffold(
      appBar: AppBar(
       // TENTE ISTO: Tente mudar a cor aqui para uma cor específica (para
        // Colors.amber, talvez?) e acione um hot reload para ver o AppBar
        //muda a cor enquanto as outras cores permanecem as mesmas.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
     // Aqui pegamos o valor do objeto MyHomePage que foi criado por
        // o método App.build e use-o para definir o título da barra de aplicativos.
        title: Text(widget.title),
      ),
      body: Center(
        // Center é um widget de layout. Ele pega uma única criança e a posiciona
        // no meio do pai.
        child: Column(
          // A coluna também é um widget de layout. É preciso uma lista de childs e
          // organiza-os verticalmente. Por padrão, ele se dimensiona para caber em seu
          // filhos horizontalmente e tenta ser tão alto quanto seu pai.
          //
          // A coluna possui diversas propriedades para controlar como ela se dimensiona e
          // como posiciona seus filhos. Aqui usamos mainAxisAlignment para
          //centraliza os filhos verticalmente; o eixo principal aqui é a vertical
          // eixo porque as colunas são verticais (o eixo cruzado seria
          //horizontal).
          //
          // TENTE ISTO: Invoque "debug painting" (escolha "Toggle Debug Paint"
          //ação no IDE, ou pressione "p" no console), para ver o
          // wireframe para cada widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
    
  }
}
